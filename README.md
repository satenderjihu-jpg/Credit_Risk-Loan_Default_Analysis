 # Credit Risk & Loan Default Analysis

## 📌 Project Overview

This project focuses on analyzing loan and customer data to identify patterns associated with loan defaults and understand the factors linked to higher credit risk.

The project uses **MySQL, Python, and Power BI** to perform data cleaning, exploratory data analysis (EDA), business analysis, and interactive dashboard development.

The goal is to turn raw financial data into actionable insights that can support better credit risk assessment and informed lending decisions.

## 🎯 Business Objectives

* Analyze overall loan performance and default rates.
* Identify customer segments with higher default rates.
* Understand the relationship between credit scores, delinquency history, interest rates, and loan defaults.
* Compare default rates across loan purposes, income groups, age groups, education levels, and regions.
* Build an interactive dashboard to monitor important credit risk indicators.
* Develop data-driven business recommendations to support risk management.

## 🛠️ Tools & Technologies

| Tool                 | Purpose                                                            |
| -------------------- | ------------------------------------------------------------------ |
| MySQL                | Data cleaning, data validation, table joins, and business analysis |
| Python               | Data integration, exploratory data analysis, and visualizations    |
| Pandas               | Data manipulation and analysis                                     |
| Matplotlib & Seaborn | Data visualization                                                 |
| MySQL Connector      | Connecting Python to MySQL                                         |
| Power BI             | Interactive dashboard, KPI cards, charts, and slicers              |
| Jupyter Notebook     | Python analysis environment                                        |
| GitHub               | Project documentation and version-controlled portfolio             |

## 📂 Dataset Description

The project uses two relational tables stored in a MySQL database.

### 1. Customers Table

Contains customer-related information, including:

* Customer ID
* Annual Income
* Education Level
* Employment Type
* Age
* Region
* Credit Score

### 2. Loans Table

Contains loan-related information, including:

* Loan ID
* Customer ID
* Loan Amount
* Interest Rate
* Loan Term
* Issue Date
* Debt-to-Income Ratio
* Delinquency Count
* Loan Purpose
* Loan Status
* Default Flag

**Database:** `credit risk`

**Tables used:** `customers` and `loans`

The two tables were joined using `customer_id` to create a combined dataset for analysis.

### Dataset Size

| Metric                                  |  Count |
| --------------------------------------- | -----: |
| Total loan records analyzed             | 30,000 |
| Loans matched with customer records     | 30,000 |
| Loans without matching customer records |      0 |
| Defaulted loans                         |  1,466 |
| Non-defaulted loans                     | 28,534 |

The final analysis covered 30,000 loan records, with all loan records successfully matched to customer records.

## 🧹 Data Cleaning & Preparation — MySQL

MySQL was used to inspect, clean, and validate the source tables before performing business analysis.

### Key Cleaning Activities

* Checked for missing and invalid values.
* Investigated invalid customer IDs.
* Checked missing annual income values.
* Handled missing education-level values.
* Investigated missing interest rate and debt-to-income values.
* Validated customer and loan relationships.
* Used SQL joins to combine customer and loan information.
* Checked the final dataset for missing values and data consistency.

### Data Quality Checks

* Validated customer-to-loan matching.
* Checked missing values in important numerical and categorical columns.
* Investigated inconsistent or invalid values.
* Reviewed key columns used for credit risk analysis.

**Note:** Missing values were evaluated based on the relevant column and analysis requirements. Not every missing value was automatically deleted.

## Exploratory Data Analysis (EDA) — Python

Python was used to perform EDA on the combined dataset imported directly from MySQL.

The workflow included:

1. Connecting Python to MySQL.
2. Loading the `customers` and `loans` tables using MySQL Connector and Pandas.
3. Joining the datasets using `customer_id`.
4. Inspecting data types and missing values.
5. Analyzing distributions and summary statistics.
6. Creating analytical categories for income, loan amounts, interest rates, and debt-to-income ratios.
7. Comparing default rates across different customer and loan characteristics.
8. Creating visualizations to identify patterns and communicate findings.

### Key Analysis Areas

* Credit score category vs. default rate
* Delinquency category vs. default rate
* Interest rate category vs. default rate
* Debt-to-income category vs. default rate
* Loan purpose vs. default rate
* Employment type vs. default rate
* Income group vs. default rate
* Age group vs. default rate
* Education level vs. default rate
* Regional default patterns

## 📊 Key Findings

### 1. Credit Score and Loan Defaults

The Poor credit score category had a default rate of approximately **13.05%**, compared with **2.26%** for the Good credit score category.

This indicates a substantial difference in observed default rates across credit score groups.

### 2. Delinquency History

Borrowers with three or more delinquencies had a default rate of approximately **59.08%**, compared with **1.34%** for borrowers with no delinquencies.

Delinquency history emerged as an important indicator for further credit risk assessment.

### 3. Interest Rate and Default Rate

Loans with interest rates between 15% and 20% had a default rate of approximately **16.28%**, while loans below 10% had a default rate of **2.72%**.

The category with interest rates of 20% and above had only 18 loans, so its default rate should be interpreted cautiously due to the small sample size.

### 4. Debt-to-Income Ratio

Borrowers with a debt-to-income ratio above 50% had a default rate of approximately **9.63%**, compared with **2.82%** for borrowers with a ratio of 20% or less.

This highlights the importance of evaluating borrowers' existing debt obligations and repayment capacity.

### 5. Loan Purpose

Small Business loans had a default rate of approximately **5.65%**, compared with **5.27%** for Debt Consolidation loans.

Debt Consolidation represented the largest loan-purpose category by loan volume, while Small Business loans showed the higher default rate between these two categories.

### 6. Employment and Income Groups

* Contract employees had a default rate of approximately **6.56%**.
* Salaried employees had a default rate of approximately **4.37%**.
* The Low Income group had a default rate of approximately **6.02%**.
* The Upper-Middle Income group had a default rate of approximately **4.04%**.

These patterns can help identify segments for further investigation, but they should not be used as the sole basis for lending decisions.

### Overall Portfolio Performance

The final dataset contained 30,000 loans, including 1,466 defaulted loans.

The overall default rate was approximately **4.89%**.

## 📈 Power BI Dashboard

An interactive Power BI dashboard was developed to present key credit risk metrics and make the findings easier to explore.

### KPI Cards

* Total Loans
* Total Loan Amount
* Default Rate
* Defaulted Loans
* Average Annual Income
* Average Age

### Visualizations

* Default Rate by Credit Score Category
* Default Rate by Delinquency Category
* Default Rate by Loan Purpose
* Default Rate by Interest Rate Category
* Default Rate by Debt-to-Income Category
* Default Rate by Age Group
* Default Rate by Education Level
* Default Rate by Region

### Interactive Filters

* Region
* Age Group
* Education Level

The dashboard allows users to explore portfolio performance and compare default rates across customer segments and loan characteristics.

## 🖼️ Dashboard Preview

<img width="1184" height="663" alt="image" src="https://github.com/user-attachments/assets/12846932-112e-468f-af46-ff07f88531ba" />


## 💡 Business Recommendations

### 1. Strengthen Credit Risk Assessment

Use credit scores alongside repayment history, income, existing debt obligations, and other relevant information when assessing loan applications.

The higher observed default rate among borrowers with Poor credit scores suggests that this segment deserves closer review.

### 2. Prioritize Delinquency History

Give appropriate attention to previous delinquencies during credit risk assessment.

The substantially higher default rate among borrowers with three or more delinquencies suggests that repayment history can be an important component of risk evaluation.

### 3. Improve Affordability Checks

Evaluate debt-to-income ratios and repayment capacity before approving loans.

Additional affordability checks may help identify borrowers whose existing debt obligations could make repayments more difficult.

### 4. Monitor Higher-Risk Loan Segments

Monitor Small Business loans and higher-interest-rate categories to understand their default patterns.

Review these segments regularly and assess whether additional underwriting checks, risk monitoring, or changes to lending criteria are justified by further evidence.

**Important:** These recommendations are based on observed patterns in the analyzed dataset. They should be validated using additional data and appropriate risk assessment before being implemented as lending policies.

## 🧠 Key Learnings

Through this project, I strengthened my practical understanding of:

* SQL-based data cleaning and validation.
* Relational database joins.
* Python-based exploratory data analysis.
* Data manipulation using Pandas.
* Identifying patterns in financial data.
* Creating visualizations to communicate insights.
* Designing interactive Power BI dashboards.
* Translating analytical findings into business recommendations.

## 🏁 Conclusion

This project demonstrates an end-to-end data analytics workflow, from relational data preparation and exploratory analysis to interactive dashboard development and business recommendations.

By combining MySQL, Python, and Power BI, the project identifies important patterns associated with loan defaults and presents them in a format that can support further credit risk investigation.

---

**Project Domain:** Finance & Credit Risk Analytics
**Dataset Size:** 30,000 loan records
**Tools:** MySQL | Python | Pandas | Matplotlib | Seaborn | Power BI
**Project Type:** End-to-End Data Analytics Portfolio Project
