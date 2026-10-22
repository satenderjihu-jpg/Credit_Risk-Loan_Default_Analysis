-- create database credit risk analysis 
create database credit_risk;
use credit_risk;

-- 1. create table customers 

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    age INT,
    employment_type VARCHAR(50),
    education_level VARCHAR(50),
    annual_income DECIMAL(12,2),
    credit_score INT,
    region VARCHAR(50),
    customer_since DATE
);
-- 2. craete table loans 
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_purpose VARCHAR(100),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    term_months INT,
    issue_date DATE,
    debt_to_income_pct DECIMAL(5,2),
    delinquency_count INT,
    monthly_payment DECIMAL(12,2),
    total_paid_to_date DECIMAL(12,2),
    outstanding_balance DECIMAL(12,2),
    loan_status VARCHAR(30),
    default_flag TINYINT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- insert data into tables ..
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

DESCRIBE customers;
DESCRIBE loans;

ALTER TABLE customers
MODIFY customer_id VARCHAR(20) NOT NULL;

SHOW CREATE TABLE loans;

-- inserting into customers tables


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- inserting data into loans table

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loans.csv'
INTO TABLE loans
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Data Cleaning Start here
-- Note:- there is no duplicate values in both tables

-- checking null values 
SELECT
    SUM(customer_id IS NULL OR customer_id = '') AS null_customer_id,
    SUM(age IS NULL) AS null_age,
    SUM(employment_type IS NULL OR employment_type = '') AS null_employment_type,
    SUM(education_level IS NULL OR education_level = '') AS null_education_level,
    SUM(annual_income IS NULL) AS null_annual_income,
    SUM(credit_score IS NULL) AS null_credit_score,
    SUM(region IS NULL OR region = '') AS null_region,
    SUM(customer_since IS NULL) AS null_customer_since
FROM customers;


-- duplicate check in customers table

select
  customer_id,
  count(*) as duplicate_customer_id
  from customers
  group by customer_id
  having count(*) >1;
  
 -- there is no duplicate valuesin this table 
  
SELECT *
FROM customers
WHERE annual_income < 0;

SELECT
    COUNT(*) AS zero_customer_id
FROM customers
WHERE customer_id = '0';

-- deleting customer id where id is 0 
DELETE FROM customers
WHERE customer_id = '0';

SELECT
    SUM(annual_income = 0) AS zero_income,
    SUM(annual_income IS NULL) AS null_income,
    SUM(annual_income < 0) AS negative_income
FROM customers;

SELECT *
FROM customers
WHERE annual_income = 0
LIMIT 20;

SELECT
    COUNT(*) AS null_education_level
FROM customers
WHERE education_level IS NULL or education_level = '';
select * from customers;


SELECT
    SUM(education_level IS NULL or education_level = '') AS null_education_level,
    SUM(annual_income = 0) AS zero_annual_income,
    SUM(annual_income IS NULL or annual_income = '') AS null_annual_income
FROM customers;

UPDATE customers
SET annual_income = NULL
WHERE annual_income = 0;

-- Updating education_level nulls cells by unknown 
update customers
set education_level = 'Unknown'
where education_level is null or education_level = '';



select * from customers
where annual_income is null or annual_income = '';

select count(*) as total_customers 
from customers;

-- 18000 total customers remain after cleaning table 
-- Note :- There is 45 null values are in annual_income 
-- end of customers table cleaning process
-- data cleaning in loans table

select* from loans;
-- checking entire null values

SELECT
    SUM(loan_id IS NULL OR loan_id = '') AS null_loan_id,
    SUM(customer_id IS NULL OR customer_id = '') AS null_customer_id,
    SUM(loan_purpose IS NULL OR loan_purpose = '') AS null_loan_purpose,
    SUM(loan_amount IS NULL or loan_amount='') AS null_loan_amount,
    SUM(interest_rate IS NULL or interest_rate ='') AS null_interest_rate,
    SUM(term_months IS NULL or term_months='') AS null_term_months,
    SUM(issue_date IS NULL ) AS null_issue_date,
    SUM(debt_to_income_pct IS NULL or debt_to_income_pct='') AS null_dti,
    SUM(delinquency_count IS NULL ) AS null_delinquency_count,
    SUM(monthly_payment IS NULL or monthly_payment='') AS null_monthly_payment,
    SUM(total_paid_to_date IS NULL or total_paid_to_date='') AS null_total_paid,
    SUM(outstanding_balance IS NULL or outstanding_balance='') AS null_outstanding_balance,
    SUM(loan_status IS NULL OR loan_status = '') AS null_loan_status,
    SUM(default_flag IS NULL ) AS null_default_flag
FROM loans;

-- Checkin duplicates values in loans table-- 
SELECT
    loan_id, COUNT(*) AS duplicate_count
FROM loans
GROUP BY loan_id
HAVING COUNT(*) > 1;

-- Note :- There is no duplicate found in loans table

SELECT *FROM loans
WHERE loan_amount <= 0;

SELECT *
FROM loans
WHERE interest_rate < 0
   OR interest_rate > 100;
   
   
   SELECT *
FROM loans
WHERE debt_to_income_pct < 0
   OR debt_to_income_pct > 100;
   
   
   SELECT *
FROM loans
WHERE outstanding_balance < 0;


SELECT COUNT(*) AS unmatched_loans
FROM loans l
LEFT JOIN customers c
    ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


SELECT COUNT(*) AS total_loans
FROM loans;

-- interest rate have 75 null values
-- debt_to_income_pct have 120 null values 

-- 30000 table remains in loans table after cleaning

-- Q1. What is the overall loan portfolio size, and how many loans have defaulted?

select*from loans;
select
  count(*) as total_loans,
  sum(loan_amount) as total_amount,
  sum(case when default_flag = 1 then 1 else 0 end)as default_loans,
     round( sum(case when default_flag = 1 then 1 else 0 end)*100 /count(*),2) as default_rate_pct
     from loans;
     
     
-- Total_loans = 30000
-- Total_loan_amount = 12741023300.00
-- default_loans = 1466
-- default_rate_pct = 4.89%

-- Q2.Which loan purposes have the highest default rate?

select loan_purpose,
         COUNT(*) AS total_loans,
 sum(case when default_flag = 1 then 1 else 0 end) as defaluted_loans,
 round(sum(case when default_flag = 1 then 1 else 0 end)*100/count(*),2) as default_rate_pct
 from loans
 group by loan_purpose 
 order by default_rate_pct desc; 
 
 -- debt consolidation have highest default count but not default pct 
 -- count_defaulted_loans =  394 , defalut_rate_pct = 5.27
 -- small businees have low default_loans as comapre to debt consolidation but default pct is hightest 
 -- small business default loans = 171 and rate = 5.65
 
 -- My Recommendation: Investigate the Small Business segment further by examining credit scores,
 -- debt-to-income ratios, annual income, and delinquency history before making lending-policy decisions.
 
 
 -- Q3.Which loan purposes have the highest number of loans?
 
 select 
   loan_purpose ,
   count(*) as highest_loans
  from loans
  group by loan_purpose
  order by highest_loans desc;
  
  -- Debt Consolidation have the highest number of loans, '7472'

-- Q4. Do customers with lower credit scores have a higher loan default rate than customers with higher credit scores?

SELECT
    CASE
        WHEN c.credit_score < 580 THEN 'Poor (<580)'
        WHEN c.credit_score BETWEEN 580 AND 669 THEN 'Fair (580-669)'
        WHEN c.credit_score BETWEEN 670 AND 739 THEN 'Good (670-739)'
        ELSE 'Very Good (740+)'
    END AS credit_score_range,
     COUNT(l.loan_id) AS total_loans,
    SUM(CASE WHEN l.default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(SUM(CASE WHEN l.default_flag = 1 THEN 1 ELSE 0  END) * 100.0 / COUNT(l.loan_id), 2) AS default_rate_pct
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
WHERE c.credit_score IS NOT NULL
GROUP BY credit_score_range
ORDER BY
    CASE credit_score_range
        WHEN 'Poor (<580)' THEN 1
        WHEN 'Fair (580-669)' THEN 2
        WHEN 'Good (670-739)' THEN 3
        WHEN 'Very Good (740+)' THEN 4
    END;
    
 
-- **Key Finding: Credit Score and Loan Default Risk**

-- The analysis shows that customers in the Poor credit score group have the highest default rate,
 -- while the Fair credit score group accounts for the highest number of loans.

-- This highlights the importance of evaluating both default rates and loan volumes when assessing credit risk.
 -- The Poor credit score segment may require closer risk assessment, while the Fair credit score segment deserves 
 -- attention because of its large share of the loan portfolio.

-- **Recommendation:** Further investigate customer income, debt-to-income ratios, 
-- and repayment history to understand the risk patterns across credit score groups.


-- Q5.Do longer-term loans have a higher default rate than shorter-term loans?

SELECT term_months,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2) AS default_rate_pct
FROM loans
GROUP BY term_months
ORDER BY term_months;

-- term_months = 12 months have 121 default_loans and rate 5.10
-- term_months = 60 months have 388 default loans and rate 5.12 

-- **Key Finding: Loan Term and Default Risk**

-- The analysis shows that 60-month loans recorded 388 defaults, compared with 121 defaults for 12-month loans. 
-- However, their default rates were nearly identical: 5.12% for 60-month loans and 5.10% for 12-month loans.

-- This highlights the importance of comparing default rates alongside default counts.
-- The higher number of defaults for 60-month loans does not necessarily indicate substantially higher default risk,
-- as the default rates are almost the same.

-- **Recommendation:** Compare all available loan terms and their default rates before drawing conclusions about the
-- relationship between loan duration and credit risk...

-- Q6. Do customers with lower annual incomes have a higher loan default rate than
-- customers with higher annual incomes?

SELECT
   CASE
    WHEN c.annual_income <= 500000 THEN 'Low Income'
    WHEN c.annual_income <= 1000000 THEN 'Lower-Middle Income'
    WHEN c.annual_income <= 2000000 THEN 'Upper-Middle Income'
    ELSE 'High Income'
END AS income_group,
COUNT(l.loan_id) AS total_loans,
    SUM(CASE WHEN l.default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(SUM(CASE WHEN l.default_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2) AS default_rate_pct
FROM customers as c
join loans as l
 on c.customer_id = l.customer_id
 group by income_group
 ;

-- **Key Finding: Income Level and Loan Default Risk**

-- The Low Income group recorded the highest loan default rate at 6.02%, while the Upper-Middle Income group had 
-- the lowest rate at 4.04%. The Lower-Middle Income group accounted for the largest number of defaults, with 727 defaults 
-- across 15,194 loans, reflecting its larger loan volume.

-- These results suggest that income level may be associated with loan default risk in this dataset. 
-- However, income alone may not explain default behaviour, so further analysis should consider factors such
--  as credit score, debt-to-income ratio, loan amount, and loan term.

describe customers;



-- Q7. Do loans with higher interest rates have higher default rates?

SELECT
CASE
WHEN interest_rate IS NULL THEN 'Unknown'
WHEN interest_rate < 10 THEN 'Below 10%'
WHEN interest_rate < 15 THEN '10% - 15%'
WHEN interest_rate < 20 THEN '15% - 20%'
ELSE '20% and Above'
END AS interest_rate_group,
COUNT(*) AS total_loans,
SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0
END) AS defaulted_loans,
ROUND(SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2) AS default_rate_pct
FROM loans
GROUP BY interest_rate_group
ORDER BY default_rate_pct DESC;


-- **Key Finding: Higher Interest Rates Are Associated with Higher Default Rates**

-- The analysis shows an increasing default rate across the interest-rate groups.
-- Loans with interest rates below 10% recorded the lowest default rate at 2.72%, while the 10%–15% group had a default
-- rate of 7.02%. The rate increased to 16.18% for loans in the 15%–20% group.

-- Loans with interest rates of 20% and above recorded the highest default rate at 27.78%; however,
-- this group contained only 18 loans, so the result should be interpreted cautiously.

-- These findings indicate an association between interest-rate groups and loan defaults in this dataset.
-- Further analysis is needed to determine whether other factors, such as credit score, income, and debt-to-income ratio, 
-- also contribute to the observed differences.

-- Q8. Which loan purpose has the highest average loan amount?

select loan_purpose,
COUNT(*) as Total_loans,
AVG(loan_amount) as Average_loan_amount,
SUM(loan_amount) as Total_loan_amount
from loans
GROUP BY loan_purpose
ORDER BY Total_loan_amount desc;

-- **Key Finding: Medical Loans Have the Highest Average Loan Amount**
-- Medical loans recorded the highest average loan amount at 437,918.49 across 2,996 loans. 
-- Small Business loans had the lowest average loan amount at 417,999.87 across 3,025 loans.

-- Debt Consolidation represented the largest loan segment, with 7,472 loans and a total loan amount of 3,167,436,500.
-- These findings highlight that the loan purpose with the highest average loan amount is not necessarily the one with 
-- the largest overall lending volume.


