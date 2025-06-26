FROM python:3.10

RUN pip install apache-airflow
RUN pip install apache-airflow-providers-mysql
RUN pip install pandas
RUN pip install scikit-learn
RUN pip install xgboost

RUN mkdir -p /app/dags/sql
RUN mkdir -p /app/dags/python

COPY /AIRPORT_DWH/app /app/dags/sql
COPY /AIRPORT_DWH/dag_init_airport_dwh.py /app/dags
COPY /AIRPORT_DWH/dag_sync_airport_dwh.py /app/dags
COPY /AIRPORT_DWH/init_forecast.py /app/dags/python
COPY /AIRPORT_DWH/sync_forecast.py /app/dags/python
WORKDIR /app

ENV AIRFLOW_HOME=/app
ENV AIRFLOW__CORE__DAGS_FOLDER=/app/dags

RUN export AIRFLOW_CONN_MYSQL_AIRPORTDB="mysql://user1:user1@host.docker.internal:3306/airportdb"

RUN airflow db migrate

RUN airflow connections add 'mysql_airportdb' \
  --conn-json "{\"conn_type\":\"mysql\",\"login\":\"user1\",\"password\":\"user1\",\"host\":\"host.docker.internal\",\"port\":3306,\"schema\":\"airportdb\"}"

CMD ["airflow", "standalone"]