CREATE OR ALTER VIEW portfolio_kpis AS
SELECT
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate,
    ROUND(
        AVG(CAST(claims_frequency_5_years AS FLOAT) / NULLIF(time_in_force, 0)),
        3
    ) AS avg_annual_claim_frequency
FROM insurance_policies;

CREATE OR ALTER VIEW claim_rate_by_car_type AS
SELECT
    car_type,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY car_type;

CREATE OR ALTER VIEW claim_rate_by_city_population AS
SELECT
    city_population,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY city_population;

CREATE OR ALTER VIEW claim_rate_by_age_group AS
SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 49 THEN '35-49'
        WHEN age BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 49 THEN '35-49'
        WHEN age BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END;

CREATE OR ALTER VIEW claim_rate_by_income_group AS
SELECT
    CASE
        WHEN income = 0 THEN 'Unknown'
        WHEN income < 25000 THEN '<25k'
        WHEN income < 50000 THEN '25k-50k'
        WHEN income < 80000 THEN '50k-80k'
        WHEN income < 120000 THEN '80k-120k'
        WHEN income < 200000 THEN '120k-200k'
        ELSE '200k+'
    END AS income_group,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY
    CASE
        WHEN income = 0 THEN 'Unknown'
        WHEN income < 25000 THEN '<25k'
        WHEN income < 50000 THEN '25k-50k'
        WHEN income < 80000 THEN '50k-80k'
        WHEN income < 120000 THEN '80k-120k'
        WHEN income < 200000 THEN '120k-200k'
        ELSE '200k+'
    END;

CREATE OR ALTER VIEW claim_rate_by_education AS
SELECT
    education,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY education;

CREATE OR ALTER VIEW claim_rate_by_car_age AS
SELECT
    CASE
        WHEN car_age <= 3 THEN '0-3 years'
        WHEN car_age BETWEEN 4 AND 7 THEN '4-7 years'
        WHEN car_age BETWEEN 8 AND 12 THEN '8-12 years'
        ELSE '12+ years'
    END AS car_age_group,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY
    CASE
        WHEN car_age <= 3 THEN '0-3 years'
        WHEN car_age BETWEEN 4 AND 7 THEN '4-7 years'
        WHEN car_age BETWEEN 8 AND 12 THEN '8-12 years'
        ELSE '12+ years'
    END;


CREATE OR ALTER VIEW claim_rate_by_car_use AS
SELECT
    car_use,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY car_use;


CREATE OR ALTER VIEW claim_rate_by_vehicle_value_group AS
SELECT
    CASE
        WHEN vehicle_value < 10000 THEN 'Under 10k'
        WHEN vehicle_value BETWEEN 10000 AND 20000 THEN '10k-20k'
        WHEN vehicle_value BETWEEN 20001 AND 30000 THEN '20k-30k'
        ELSE '30k+'
    END AS vehicle_value_group,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY
    CASE
        WHEN vehicle_value < 10000 THEN 'Under 10k'
        WHEN vehicle_value BETWEEN 10000 AND 20000 THEN '10k-20k'
        WHEN vehicle_value BETWEEN 20001 AND 30000 THEN '20k-30k'
        ELSE '30k+'
    END;

CREATE OR ALTER VIEW claim_rate_by_vehicle_points AS
SELECT
    vehicle_points,
    COUNT(*) AS total_policies,
    SUM(claims_flag_crash) AS total_claims,
    ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate
FROM insurance_policies
GROUP BY vehicle_points;