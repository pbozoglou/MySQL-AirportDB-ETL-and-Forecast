import mysql.connector
import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import root_mean_squared_error
import datetime

conn = mysql.connector.connect(
    host='host.docker.internal',
    user='user1',
    password='user1',
    database='airport_dwh'
)
cursor = conn.cursor()

# #### Load Model

# In[6]:


model = xgb.XGBRFRegressor()
model.load_model("model.json")

# #### Get Forecast Start Date

# In[ ]:


query = """
SELECT MAX(t2.full_date) 
FROM airport_dwh.fact_bookings t1
JOIN airport_dwh.dim_date t2 ON t1.date_key = t2.date_key;
"""

cursor.execute(query)
rows = cursor.fetchone()
cursor.close()
cursor = conn.cursor()

start_date = rows[0] + datetime.timedelta(days=1)


# #### Get Current Flight Schedule

# In[ ]:


query = """
select 
	t1.airport_key,
    count(t1.monday),
    count(t1.tuesday),
    count(t1.wednesday),
    count(t1.thursday),
    count(t1.friday),
    count(t1.saturday),
    count(t1.sunday)
from airport_dwh.dim_flightschedule t1
group by t1.airport_key;
"""

cursor.execute(query)
rows = cursor.fetchall()
cursor.close()
cursor = conn.cursor()

test = pd.DataFrame(rows, columns=['airport_key','monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'])


# #### Get Dim_Dates

# In[ ]:


query = "select date_key, full_date from airport_dwh.dim_date;"
cursor.execute(query)
dim_date = pd.DataFrame(cursor.fetchall(), columns=["date_key", "full_date"])
cursor.close()
cursor = conn.cursor()


# #### Prepare Dataset For Inference

# In[ ]:


days_to_forecast = 7

test_final = []
for row in test.values:
    for i in range(days_to_forecast):
        date = start_date+datetime.timedelta(days=i)
        date_key = dim_date[dim_date.full_date == date].date_key.iloc[0]
        test_final.append([int(date_key), int(row[0]), int(date.timetuple().tm_mday), int(date.weekday()+1), int(row[date.weekday()+1])])
        
test_final = pd.DataFrame(test_final, columns=["date_key","airport_key","day_of_month","day_of_week","scheduled_flights"])


# #### Predict Future Airport Revenue

# In[ ]:


test_final['predicted'] = model.predict(test_final.loc[:,test_final.columns[1:]]).astype("float")


# #### Truncate Old Forecasts

# In[ ]:


query = "truncate table airport_dwh.fact_forecasts;"
cursor.execute(query)
cursor.close()
cursor = conn.cursor()


# #### Insert New Forecasts

# In[ ]:


insert_sql = """
insert into fact_forecasts (date_key,airport_key,day_of_month,day_of_week,scheduled_flights,price_forecast)
values (%s, %s, %s, %s, %s, %s);
"""

cursor.executemany(insert_sql, list(test_final.itertuples(index=False,name=None)))
conn.commit()
cursor.close()
cursor = conn.cursor()