from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.standard.operators.python import PythonOperator
from airflow.providers.standard.operators.empty import EmptyOperator
from datetime import datetime

def init_forecast(): exec(open('dags/python/init_forecast.py').read())
def sync_forecast(): exec(open('dags/python/sync_forecast.py').read())

with DAG(
    dag_id='init_airport_dwh',
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    max_active_tasks=1,
    tags=['airport', 'dwh'],
) as dag:

    create_dwh = SQLExecuteQueryOperator(
        task_id='create_dwh',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dwschema.sql',
    )

    create_procedure_dates = SQLExecuteQueryOperator(
        task_id='create_procedure_dates',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_date.sql',
    )

    insert_dim_dates = SQLExecuteQueryOperator(
        task_id='insert_dim_dates',
        conn_id='mysql_airportdb',
        sql='use airport_dwh; CALL dates();',
    )

    create_procedure_time = SQLExecuteQueryOperator(
        task_id='create_procedure_time',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_time.sql',
    )

    insert_dim_time = SQLExecuteQueryOperator(
        task_id='insert_dim_time',
        conn_id='mysql_airportdb',
        sql='use airport_dwh; CALL times();',
    )

    insert_dim_airport = SQLExecuteQueryOperator(
        task_id='insert_dim_airport',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_airport.sql',
    )

    insert_dim_flight = SQLExecuteQueryOperator(
        task_id='insert_dim_flight',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_flights.sql',
    )

    insert_dim_passenger = SQLExecuteQueryOperator(
        task_id='insert_dim_passenger',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_passengers.sql',
    )

    insert_dim_flightschedule = SQLExecuteQueryOperator(
        task_id='insert_dim_flightschedule',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/dim_flightschedule.sql',
    )

    insert_fact_bookings = SQLExecuteQueryOperator(
        task_id='insert_fact_bookings',
        conn_id='mysql_airportdb',
        sql='sql/init_dwh/fact_bookings.sql',
    )

    init_forecast_model = PythonOperator(
        task_id='init_forecast_model',
        python_callable=init_forecast
    )

    sync_forecast_table = PythonOperator(
        task_id='sync_forecast_model',
        python_callable=sync_forecast
    )

    end = EmptyOperator(task_id='end')

    create_dwh >> create_procedure_dates >> insert_dim_dates >> create_procedure_time >> insert_dim_time >> insert_dim_airport >> insert_dim_flight >> insert_dim_passenger >> insert_dim_flightschedule >> insert_fact_bookings >> init_forecast_model >> sync_forecast_table >> end