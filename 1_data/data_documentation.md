# Data Documentation

## 1. Data Source

**Original file:** `amazon_sales.csv`  
**Source:** Kaggle  
**Type:** Synthetic dataset  

This dataset contains 100,000 synthetic Amazon-style e-commerce sales transactions, designed to closely resemble real-world online retail behavior.

With 20 clean and well-structured columns, the dataset captures detailed information about:

- Customers  
- Products  
- Pricing  
- Discounts and taxes  
- Payment methods  
- Logistics  
- Order outcomes  

Although artificially generated, the dataset reflects realistic e-commerce patterns such as:

- Dynamic product pricing  
- Varying discounts and taxes  
- Multiple product categories and brands  
- Seasonal order trends  
- Payment method diversity  
- Realistic customer names and locations  
- Order statuses (Delivered, Cancelled, Shipped, Returned)  

⚠️ **Important:**  
The dataset is synthetic and created for educational purposes.  
It does not represent real Amazon data or any actual Amazon seller.

---

## 2. Data Cleaning & Transformation

Data preparation was performed using Python.

The following steps were applied:

- Data type corrections (dates, numeric fields)
- Validation of key identifiers (OrderID, CustomerID, ProductID)
- Basic consistency checks
- Structural transformation to simulate a normalized relational schema

To better reflect a real-world transactional system, the original flat dataset was transformed into separate structured tables:

- `customers_clean.csv`
- `orders_clean.csv`
- `products_clean.csv`

This restructuring allowed the project to simulate a realistic e-commerce database design rather than relying on a single denormalized file.

---

## 3. Data Modeling & Storage

The cleaned and structured data files were imported into PostgreSQL.

A relational schema was designed to simulate a production-like transactional database structure, including:

- Customers table  
- Orders table  
- Products table  

Primary and foreign key relationships were modeled to reflect typical e-commerce data architecture.

This structure enabled SQL-based KPI validation and business metric calculations prior to dashboard development.

---

## 4. Business Context Simulation

The company name **Westbrook** and the associated business case were created specifically for portfolio purposes.

Westbrook represents a fictional mid-sized private label brand selling on Amazon US.  
The business scenario (revenue stagnation in 2024 and stakeholder-driven performance analysis) was designed to simulate a realistic executive reporting environment.

This project does not represent any real company and is intended solely for educational and portfolio demonstration purposes.

---

## 5. Project Workflow Overview

The project followed a structured analytics workflow:

1. Data acquisition (synthetic dataset from Kaggle)  
2. Data cleaning and transformation in Python  
3. Relational modeling in PostgreSQL  
4. SQL-based KPI validation  
5. Dashboard development in Tableau  
6. Executive-level business case framing  

This end-to-end approach demonstrates practical data analytics skills across data preparation, modeling, analysis, and visualization.
