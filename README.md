<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/your-username/airport-dwh-forecasting">
    <img src="https://img.icons8.com/ios/100/airport.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Airport DWH & Revenue Forecasting</h3>

  <p align="center">
    Big Data project integrating ETL, Data Warehousing, ML forecasting & visualization in PowerBI.
    <br />
    <a href="https://dev.mysql.com/doc/airportdb/en/airportdb-introduction.html"><strong>Explore the database»</strong></a>
    <br />
    <br />
  </p>
</p>

---

## 📌 About The Project

Uni Big Data project implementing a complete Data Warehouse and Machine Learning pipeline for forecasting airport ticket revenue.

### 🛠 Built With

- **SQL / MySQL** – Schema design, ETL logic, triggers
- **Python** – Data processing, ML model (XGBoost Random Forest Regressor)
- **Apache Airflow** – DAG automation for ETL and ML
- **Docker** – Environment containerization
- **Power BI** – Final visualization

---

## 🧠 Features

- ✅ Airport & booking database ingestion
- ✅ Star schema DWH design (fact/dim tables)
- ✅ XGBoost-based ML model for revenue prediction
- ✅ Automated DAGs for initialization and daily sync
- ✅ Power BI dashboard connection via ODBC
- ✅ Country filter: Greece and Cyprus airports

---

## 🚀 Getting Started

To run this project locally with Docker & Airflow:

### Prerequisites

- Docker
- Python 3.10+
- MySQL server or container
- AirportDB Installed on MySQL Server: user1:user1@localhost:3306/airportdb

### Installation

1. Clone the repo:
   ```
   git clone https://github.com/pbozoglou/MySQL-AirportDB-ETL-and-Forecast.git
   cd MySQL-AirportDB-ETL-and-Forecast
   ```
2. Build & Run Container:
   ```
   docker build -t airport-dwh .
   docker run -p 8080:8080 airport-dwh
   ```

---

*Note: This README is structured based on the [awesome-readme-template](https://github.com/Louis3797/awesome-readme-template) template :)*
