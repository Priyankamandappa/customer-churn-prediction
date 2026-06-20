sql_path = os.path.join(project_path, "sql")

sql_content = """-- ================================================
-- Customer Churn Analysis - SQL Queries
-- Author: Priyanka M M
-- Dataset: Telco Customer Churn
-- ================================================

-- Q1: Overall churn rate
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn;

-- Q2: Churn by contract type
SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;

-- Q3: Churn by internet service
SELECT 
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn
GROUP BY InternetService
ORDER BY Churn_Rate_Pct DESC;

-- Q4: Churn by payment method
SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Pct DESC;

-- Q5: Average charges - churned vs stayed
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges), 2) AS Avg_Total_Charges,
    ROUND(AVG(tenure), 1) AS Avg_Tenure_Months
FROM telco_churn
GROUP BY Churn;

-- Q6: Senior citizen churn rate
SELECT 
    CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Non-Senior' END AS Customer_Type,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn
GROUP BY SeniorCitizen;

-- Q7: High risk customers
SELECT 
    customerID,
    Contract,
    InternetService,
    PaymentMethod,
    MonthlyCharges,
    tenure,
    Churn
FROM telco_churn
WHERE Contract = 'Month-to-month'
    AND InternetService = 'Fiber optic'
    AND PaymentMethod = 'Electronic check'
    AND tenure < 12
ORDER BY MonthlyCharges DESC;

-- Q8: Churn by tenure group
SELECT 
    CASE 
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Churn_Rate_Pct
FROM telco_churn
GROUP BY Tenure_Group
ORDER BY Churn_Rate_Pct DESC;
"""

with open(os.path.join(sql_path, "churn_queries.sql"), "w") as f:
    f.write(sql_content)

print("✅ SQL file saved!")