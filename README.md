# 🧾 Revenue Leakage & Default Risk Analytics System

SQL • Python • Machine Learning • Tableau

A complete end-to-end analytics project designed to identify revenue leakage, detect billing/refund anomalies, and predict invoice default risk using a unified SQL → Python → ML → BI workflow.

---

## 🚀 1. Project Overview

Most businesses lose revenue due to late payments, uncollected invoices, incorrect refunds, or operational inefficiencies.
This project simulates a real-world financial operations environment by:

- Building a clean, reliable data pipeline
- Analyzing revenue, payments, returns, and refunds
- Detecting leakage & financial anomalies
- Training a machine learning model to predict invoice default
- Creating interactive dashboards to support decision-making

This project demonstrates data engineering, analytics, machine learning, and business intelligence in one unified solution.

---

## 🏗️ 2. Tech Stack

- Languages: Python, SQL
- Libraries: Pandas, NumPy, Scikit-Learn
- Database: MySQL
- Visualization: Tableau
- Tools: Jupyter Notebook, Git

---

## 🗂️ 3. Project Architecture
Raw Data → SQL Staging Tables → Cleaned Tables → Analytical Base Table (ABT)
             → Python ML Pipeline → Default Risk Scores → Tableau Dashboards

✔ SQL

Used to clean, transform, and aggregate 7+ raw data sources (orders, invoices, payments, customers, products, returns, sales reps).

✔ Python ML

- Built a classification model to predict invoice default risk using:
- Financial ratios
- Customer behaviour metrics
- Payment/overdue history
- Refund and return patterns
- Invoice-level signals

✔ Tableau

- Created dashboards for:
- Revenue & leakage overview
- Customer risk analysis
- ML explainability
- Outstanding aging and refund anomalies

---

## 📊 4. Key Insights (Business Impact)
🔹 Revenue Leakage Overview

- Total Revenue Analyzed: ₹847,000+
- Total Outstanding / Leakage: ₹79,600
- Leakage Rate: 9.39%
- 89% of leakage stuck in 90+ day ageing, indicating high default risk

🔹 Refund & Billing Anomalies

- Total Refunds: ₹77,800
- 9 invoices refunded >80% of order value
- 7 invoices refunded >100% (impossible → data/process error)
- Indicates over-refunding, incorrect billing, or fraud signals

🔹 Customer-Level Risk Patterns

- Small group of customers contributed ~70% of outstanding dues
- High-risk customer cohort identified using:
- Late payment behaviour
- Refund patterns
- Low credit score

High invoice-to-lifetime spend ratios

🔹 Machine Learning Model Performance

- Algorithm: RandomForestClassifier
- Accuracy: 87%
- ROC-AUC: 0.639
- 15+ engineered features capturing financial + behavioural signals
- Generated invoice-level default probability scores

---

## 5. Machine Learning Features (Examples)

- paid_ratio
- refund_ratio
- overdue_ratio
- lifetime_amount
- credit_score
- inv_to_lifetime_ratio
- customer_tenure_days
- One-hot encoded region & segment indicators

These features capture financial behaviour, payment discipline, and customer value, making the model business-relevant and explainable.

---

## 📉 6. Visual Dashboards



- KPI Overview (Revenue, Paid, Outstanding)
- Invoice Aging Distribution
- Customer Risk Scores
- Refund Anomaly Detection
- ML Feature Importance

These dashboards help finance, operations, and collections teams prioritize recovery.

---

## 🚀 7. Future Enhancements

- Add SHAP explainability to the ML model
- Build a Streamlit app for invoice risk scoring
- Integrate real-time payment refresh via APIs
- Build automated alerts for high-risk invoices
