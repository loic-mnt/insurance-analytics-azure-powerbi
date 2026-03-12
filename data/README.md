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

![Portfolio Overview](powerbi/portfolio_overview.png)

---

### Customer Risk

Analyzes claim risk across customer segments:

- claim rate by age group
- claim rate by income group
- claim rate by education
- claim rate by vehicle points

![Customer Risk](powerbi/customer_risk.png)

---

### Vehicle Risk

Explores vehicle-related risk factors:

- claim rate by vehicle age
- claim rate by vehicle value
- claim rate by car use
- scatter analysis of vehicle value vs claim amount

![Vehicle Risk](powerbi/vehicle_risk.png)

---

## Technologies Used

This project combines several tools commonly used in modern data workflows:

- **Python** – data preprocessing
- **SQL** – creation of analytical views
- **Azure SQL Database** – cloud data storage
- **Power BI** – dashboard and visualization
- **GitHub** – version control and project documentation

---

## Repository Structure

```
insurance-analytics-azure-powerbi
│
├── data/                     # Raw or processed datasets
│   └── dataset_description
│
├── python/                   # Python scripts for preprocessing
│   └── data_preprocessing.py
│
├── sql/                      # SQL queries and views
│   └── views.sql
│
├── powerbi/                  # Power BI dashboard file
│   └── insurance_dashboard.pbix
│
├── images/                   # Dashboard screenshots used in README
│   ├── portfolio_overview.png
│   ├── customer_risk.png
│   └── vehicle_risk.png
│
└── README.md                 # Project documentation
```

### Folder description

- **data/** : dataset or dataset description  
- **python/** : data preprocessing scripts  
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

**Loïc Mwana Nteba**  



