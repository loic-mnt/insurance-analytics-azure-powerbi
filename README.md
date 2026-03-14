# Insurance Risk Analytics Dashboard (Azure + Power BI)

This project analyzes an insurance portfolio of **8,423 policies** using **Python, Azure SQL, and Power BI**.

The goal is to explore claim risk across different customer and vehicle characteristics and build an **interactive dashboard for portfolio monitoring and risk analysis**.

---

## Project Architecture

The project follows a simple data pipeline:

Raw Dataset  
↓  
Python Preprocessing  
↓  
Azure SQL Database  
↓  
SQL Views (risk metrics)  
↓  
Power BI Dashboard

This pipeline demonstrates how raw data can be transformed into analytical insights using a combination of **data engineering and business intelligence tools**.

---


## Dataset

**Dataset:** Car Insurance Claim Dataset  
**Source:** SAS Enterprise Miner  
**Number of policies:** 8,423  

The dataset contains information about insurance policyholders, including:

- **Customer characteristics:** age, income, education, marital status  
- **Vehicle characteristics:** car type, vehicle value, car age  
- **Driving history:** vehicle points, license revocation  
- **Claims information:** claim flag, claim frequency, claim amount  

Each row represents **one insurance policy**.

---

## Data Pipeline

The data pipeline is implemented in Python and performs three main steps:

1. **Data preprocessing**
   - Load the raw dataset
   - Standardize column names
   - Convert categorical variables to SQL-compatible formats
   - Convert binary features to numeric flags (0/1)

2. **Data loading**
   - The cleaned dataset is uploaded to an Azure SQL table (`insurance_policies`)
   - Data is inserted in batches using SQLAlchemy

3. **Analytical layer**
   - SQL views are created automatically to compute portfolio KPIs and risk metrics
   - These views are later consumed directly by Power BI

This design separates **data storage**, **data transformation**, and **data visualization**, following common data engineering practices.

## Dashboard Overview

The Power BI dashboard contains **three analytical pages**.

### Portfolio Overview

Provides a high-level summary of the insurance portfolio:

- total number of policies
- total claims
- claim rate
- claim frequency
- claim rate by car type
- claim rate by city population

![Portfolio Overview](/images/portfolio_overview.PNG)

---

### Customer Risk

Analyzes claim risk across customer segments:

- claim rate by age group
- claim rate by income group
- claim rate by education
- claim rate by vehicle points

![Customer Risk](/images/customer_risk.PNG)

---

### Vehicle Risk

Explores vehicle-related risk factors:

- claim rate by vehicle age
- claim rate by vehicle value
- claim rate by car use
- scatter analysis of vehicle value vs claim amount

![Vehicle Risk](/images/vehicle_risk.PNG)

---

## Technologies Used

This project combines several tools commonly used in modern data workflows:

- **Python** – data preprocessing
- **SQL** – creation of analytical views
- **Azure SQL Database** – cloud data storage
- **Power BI** – dashboard and visualization
- **GitHub** – version control and project documentation

---

## How to Run the Project

### 1. Install dependencies

```
pip install pandas sqlalchemy pyodbc openpyxl
```

### 2. Repository Structure

```
insurance-analytics-azure-powerbi
│
├── data/
│   ├── dataset
│   └── dataset_description
│ 
│
├── python/
│   └── pipeline.py
│
├── sql/
│   ├── insurance_policies_table
│   └── views.sql
│
├── powerbi/
│   └── insurance_dashboard.pbix
│
├── images/
│   ├── portfolio_overview.png
│   ├── customer_risk.png
│   └── vehicle_risk.png
│
├── .env.example
├── .gitignore
├── requirements.txt
└── README.md
```

### 3. Folder description

- **data/** : dataset and dataset description  
- **python/** : data preprocessing and data pipeline  
- **sql/** : SQL views used to compute risk metrics  
- **powerbi/** : Power BI dashboard file  
- **images/** : dashboard screenshots used in the README  

---

## Key Insights

Some initial insights from the analysis:

- Claim rates increase significantly with **vehicle points**, indicating strong predictive power of driving history.
- Certain **car types** exhibit higher claim rates than others.
- **Urban drivers** tend to show slightly higher claim probability than rural drivers.
- **Older vehicles** are associated with higher claim frequency.

---

## Author

**Loïc Mwana-Nteba**  


