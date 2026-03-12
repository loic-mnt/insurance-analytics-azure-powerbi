CREATE TABLE insurance_policies (
    row_id INT IDENTITY(1,1) PRIMARY KEY,
    id BIGINT,
    driving_children INT,
    dob DATE,
    age INT,
    home_children INT,
    years_on_job INT,
    income INT,
    single_parent INT,
    home_value FLOAT,
    marital_status VARCHAR(20),
    gender VARCHAR(10),
    education VARCHAR(50),
    occupation VARCHAR(50),
    travel_time INT,
    car_use VARCHAR(20),
    vehicle_value FLOAT,
    time_in_force INT,
    car_type VARCHAR(30),
    red_car INT,
    total_claims_5y INT,
    claims_frequency_5y INT,
    license_revoked INT,
    vehicle_points INT,
    claims_amount INT,
    car_age INT,
    claims_flag_crash INT,
    city_population VARCHAR(20)
);


CREATE VIEW portfolio_kpis AS 
SELECT
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)), 3) AS claim_rate,
	ROUND(AVG(CAST(claims_frequency_5_years AS FLOAT) / NULLIF(time_in_force, 0)),3) AS avg_annual_claim_frequency
	
FROM insurance_policies;

CREATE VIEW claim_rate_by_car_type AS
SELECT
	car_type,
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
FROM insurance_policies
GROUP BY car_type;

CREATE VIEW claim_rate_by_city_population AS
SELECT
	city_population,
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
FROM insurance_policies
GROUP BY city_population;

CREATE VIEW claim_rate_by_age_group AS
SELECT
	CASE
		WHEN age < 25 THEN 'Under 25'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 49 THEN '35-49'
		WHEN age BETWEEN 50 AND 64 THEN '50-64'
		ELSE '65+'
	END AS age_group,
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
FROM insurance_policies
GROUP BY
	CASE
		WHEN age < 25 THEN 'Under 25'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 49 THEN '35-49'
		WHEN age BETWEEN 50 AND 64 THEN '50-64'
		ELSE '65+'
	END;


	

CREATE VIEW claim_rate_by_income_group AS
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
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
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


SELECT DISTINCT
    MIN(income) OVER () AS min_income,
    MAX(income) OVER () AS max_income,
    AVG(income) OVER () AS avg_income,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY income) OVER () AS median_income
FROM insurance_policies;
	


SELECT 
    COUNT(*) AS total_policies,
    SUM(CASE WHEN income = 0 THEN 1 ELSE 0 END) AS unknown_income,
    100.0 * SUM(CASE WHEN income = 0 THEN 1 ELSE 0 END) / COUNT(*) AS pct_unknown
FROM insurance_policies;


CREATE VIEW claim_rate_by_education AS
SELECT
	education,
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
FROM insurance_policies
GROUP BY education;

CREATE VIEW claim_rate_by_car_age AS
SELECT
	CASE
		WHEN car_age <=3 THEN '0-3 years'
		WHEN car_age BETWEEN 4 AND 7 THEN '4-7 years'
		WHEN car_age BETWEEN 8 AND 12 THEN '8-12 years'
		ELSE '12+ years'
	END AS car_age_group,
	COUNT(*) AS total_policies,
	SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
	ROUND(AVG(CAST(claims_flag_crash AS FLOAT)),3) AS claim_rate
FROM insurance_policies
GROUP BY
	CASE
		WHEN car_age <=3 THEN '0-3 years'
		WHEN car_age BETWEEN 4 AND 7 THEN '4-7 years'
		WHEN car_age BETWEEN 8 AND 12 THEN '8-12 years'
		ELSE '12+ years'
	END;


CREATE VIEW claim_rate_by_car_use AS
SELECT
    car_use,
    COUNT(*) AS total_policies,
    SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
    AVG(CAST(claims_flag_crash AS FLOAT)) AS claim_rate
FROM insurance_policies
GROUP BY car_use;


CREATE VIEW claim_rate_by_vehicle_value_group AS
SELECT
    CASE
        WHEN vehicle_value < 10000 THEN 'Under 10k'
        WHEN vehicle_value BETWEEN 10000 AND 20000 THEN '10k-20k'
        WHEN vehicle_value BETWEEN 20001 AND 30000 THEN '20k-30k'
        ELSE '30k+'
    END AS vehicle_value_group,
    COUNT(*) AS total_policies,
    SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
    AVG(CAST(claims_flag_crash AS FLOAT)) AS claim_rate
FROM insurance_policies
GROUP BY
    CASE
        WHEN vehicle_value < 10000 THEN 'Under 10k'
        WHEN vehicle_value BETWEEN 10000 AND 20000 THEN '10k-20k'
        WHEN vehicle_value BETWEEN 20001 AND 30000 THEN '20k-30k'
        ELSE '30k+'
    END;

CREATE VIEW claim_rate_by_vehicle_points AS
SELECT
    vehicle_points,
    COUNT(*) AS total_policies,
    SUM(CAST(claims_flag_crash AS INT)) AS total_claims,
    AVG(CAST(claims_flag_crash AS FLOAT)) AS claim_rate
FROM insurance_policies
GROUP BY vehicle_points;

