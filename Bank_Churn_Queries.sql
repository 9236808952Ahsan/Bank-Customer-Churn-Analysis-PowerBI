1. Basic Data Check (The Foundation)
SELECT COUNT(*) AS Total_Customers FROM Bank_Churn;


2. Churn Rate Calculation 
SELECT 
    Exited, 
    COUNT(*) AS Customer_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Bank_Churn), 2) AS Churn_Percentage
FROM Bank_Churn
GROUP BY Exited;


3. Churn by Geography 
SELECT 
    Geography, 
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Bank_Churn
GROUP BY Geography
ORDER BY Churn_Rate DESC;


4. Using CTE for Age Groups
WITH AgeBuckets AS (
    SELECT *,
           CASE 
               WHEN Age < 30 THEN 'Under 30'
               WHEN Age BETWEEN 30 AND 50 THEN '30-50'
               ELSE 'Over 50'
           END AS Age_Group
    FROM Bank_Churn
)
SELECT Age_Group, COUNT(*) AS Total, SUM(Exited) AS Churned,
       ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM AgeBuckets
GROUP BY Age_Group;


5. Rank Customers by Balance (Window Functions)
SELECT 
    CustomerId, Surname, Balance,
    RANK() OVER (ORDER BY Balance DESC) AS Balance_Rank
FROM Bank_Churn
LIMIT 10;
