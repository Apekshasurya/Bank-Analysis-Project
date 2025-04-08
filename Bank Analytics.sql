use bankproject;

-- Year wise loan amount Stats
SELECT 
    YEAR(issue_d) AS issue_year,
    SUM(loan_amnt) AS total_loan_amount
FROM 
    finan_1
GROUP BY 
    issue_year;

-- Grade and sub grade wise revol_bal
SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM 
    finan_1 f1
JOIN 
    finance_2 f2 ON f1.id = f2.id
GROUP BY 
    f1.grade, f1.sub_grade;

-- Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT 
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payment
FROM 
    finan_1 f1
JOIN 
    finance_2 f2 ON f1.id = f2.id
GROUP BY 
    f1.verification_status;

-- State wise and month wise loan status
SELECT 
    f1.addr_state,
    MONTH(f1.issue_d) AS issue_month,
    f1.loan_status,
    COUNT(*) AS loan_count
FROM 
    finan_1 f1
GROUP BY 
    f1.addr_state, issue_month, f1.loan_status
ORDER BY
    f1.addr_state, issue_month;

-- Home ownership Vs last payment date stats
SELECT
    f1.home_ownership,
    MIN(f2.last_pymnt_d) AS min_last_payment_date,
    MAX(f2.last_pymnt_d) AS max_last_payment_date,
    AVG(TIMESTAMPDIFF(DAY, f2.last_pymnt_d, CURDATE())) AS avg_days_since_last_payment
FROM
    finan_1 f1
JOIN
    finance_2 f2 ON f1.id = f2.id
WHERE f2.last_pymnt_d IS NOT NULL
GROUP BY
    f1.home_ownership;
    
    SELECT 
    SUM(f1.loan_amnt) AS total_loan_amount,
    SUM(f1.funded_amnt) AS total_funded_amount,
    SUM(f2.revol_bal) AS total_revol_amount,
    AVG(f1.int_rate) AS average_interest_rate,
    COUNT(DISTINCT f1.member_id) AS total_customers
FROM 
    finan_1 f1
JOIN 
    finance_2 f2 ON f1.id = f2.id;