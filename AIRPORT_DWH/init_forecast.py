import mysql.connector
import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import root_mean_squared_error
import datetime


# #### Connect to DWH

# In[2]:


conn = mysql.connector.connect(
    host='host.docker.internal',
    user='user1',
    password='user1',
    database='airport_dwh'
)
cursor = conn.cursor()


# #### Get Train Data

# In[3]:


query = """
SELECT 
    t1.departure_airport_key,
    DAYOFMONTH(t2.full_date),
    t2.day_of_week,
    count(distinct t1.flight_key),
    sum(t1.price)
FROM airport_dwh.fact_bookings t1
JOIN airport_dwh.dim_date t2 ON t1.date_key = t2.date_key
group by t2.full_date, t2.day_of_week, t1.departure_airport_key
order by t2.full_date, t1.departure_airport_key;
"""

cursor.execute(query)
rows = cursor.fetchall()
cursor.close()
cursor = conn.cursor()

train = pd.DataFrame(rows, columns=["airport_key","day_of_month","day_of_week","scheduled_flights","total_revenue"])


# #### Train Model

# In[10]:


X = train[['airport_key', 'day_of_month', 'day_of_week', 'scheduled_flights']]
y = train['total_revenue'].astype("int")

X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.3, random_state=42)

model = xgb.XGBRFRegressor()
model.fit(X_train,y_train)

preds = model.predict(X_val)
rmse = root_mean_squared_error(y_val, preds)
print(rmse)


# #### Save Model

# In[23]:


model.save_model("model.json")