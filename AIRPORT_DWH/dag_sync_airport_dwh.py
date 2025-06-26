from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.standard.operators.python import PythonOperator
from airflow.providers.standard.operators.empty import EmptyOperator
from datetime import datetime

def sync_forecast(): exec(open('dags/python/sync_forecast.py').read())

with DAG(
    dag_id='sync_airport_dwh',
    start_date=datetime(2025, 1, 1),
    schedule="@daily",
    catchup=False,
    max_active_tasks=1,
    tags=['airport', 'dwh'],
) as dag:

    sync_passengers = SQLExecuteQueryOperator(
        task_id='sync_dim_passengers',
        conn_id='mysql_airportdb',
        sql='sql/sync_dwh/sync_dim_passengers.sql',
    )

    sync_airport = SQLExecuteQueryOperator(
        task_id='sync_dim_airport',
        conn_id='mysql_airportdb',
        sql='sql/sync_dwh/sync_dim_airport.sql',
    )

    sync_flights = SQLExecuteQueryOperator(
        task_id='sync_dim_flights',
        conn_id='mysql_airportdb',
        sql='sql/sync_dwh/sync_dim_flights.sql',
    )

    sync_bookings = SQLExecuteQueryOperator(
        task_id='sync_fact_bookings',
        conn_id='mysql_airportdb',
        sql='sql/sync_dwh/sync_fact_bookings.sql',
    )

    sync_forecast_table = PythonOperator(
        task_id='sync_forecast_model',
        python_callable=sync_forecast
    )

    end = EmptyOperator(task_id='end')

    sync_passengers >> sync_airport >> sync_flights >> sync_bookings >> sync_forecast_table >> end