/* E-Commerce User Behavior Analysis & Conversion Insights
(SQL + Power BI + HTML Dashboard) */
 Author - Prasanth Sundar 
 DATA ANALYST 
/*Data cleaning using SQL (handling NULL values)
Creation of reusable SQL Views for analytics
User behavior analysis (engagement, bounce rate, session time)
Conversion funnel analysis (Ad Click → Cart → Purchase)
Performance comparison across device types, gender, and user segments */

-- TABLE OVERVIEW --
Select * FROM ecommerce_db

SELECT * FROM ecommerce_db
Where Previous_purchases >=10

-- SAMPLE NULL CHECK --

SELECT * FROM ecommerce_db
WHERE device_type IS NULL 

-- FINDING COLUMNS PRESENT IN THE TABLE --

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ecommerce_db';

-- CLearing NULL VALUES--

SELECT *
INTO ecommerce_clean
FROM ecommerce_db
WHERE user_id IS NOT NULL
AND age IS NOT NULL
AND gender IS NOT NULL
AND device_type IS NOT NULL
AND time_on_site IS NOT NULL
AND pages_viewed IS NOT NULL
AND previous_purchases IS NOT NULL
AND cart_items IS NOT NULL
AND discount_seen IS NOT NULL
AND ad_clicked IS NOT NULL
AND returning_user IS NOT NULL
AND avg_session_time IS NOT NULL
AND bounce_rate IS NOT NULL
AND purchase IS NOT NULL;

-- BASIC OVERVIEW --
SELECT 
    COUNT(*) AS total_users,
    AVG(age) AS avg_age,
    AVG(time_on_site) AS avg_time_spent,
    AVG(pages_viewed) AS avg_pages
FROM ecommerce_clean;

-- GENDER PERFORMANCE --
SELECT 
    gender,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers,
    AVG(time_on_site) AS avg_time,
    AVG(pages_viewed) AS avg_pages
FROM ecommerce_clean
GROUP BY gender;

SELECT * FROM ecommerce_clean

-- DEVICE TYPE ANALYSIS --
SELECT 
    device_type,
    COUNT(*) AS users,
    AVG(time_on_site) AS avg_time,
    AVG(bounce_rate) AS avg_bounce,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers
FROM ecommerce_clean
GROUP BY device_type
ORDER BY buyers DESC;

--CUSTOMER CHURN ANALYSIS - REPEATED CUSTOMERS --
SELECT 
    returning_user,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers,
    AVG(previous_purchases) AS avg_previous_orders
FROM ecommerce_clean
GROUP BY returning_user;

-- NEW vs RETURNING USERS --
SELECT 
    returning_user,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers,
    AVG(previous_purchases) AS avg_previous_orders
FROM ecommerce_clean
GROUP BY returning_user;

--AD PERFORMANCE --
SELECT 
    ad_clicked,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers,
    AVG(time_on_site) AS avg_time
FROM ecommerce_clean
GROUP BY ad_clicked;

--DISCOUNT IMPACT --
SELECT 
    discount_seen,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers,
    AVG(cart_items) AS avg_cart
FROM ecommerce_clean
GROUP BY discount_seen;

-- HIGH PERFORMANCE USERS --
SELECT TOP 10 *
FROM ecommerce_clean
ORDER BY previous_purchases DESC, time_on_site DESC;

-- AGE GROUP ANALYSIS --
SELECT 
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS users,
    SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS buyers
FROM ecommerce_clean
GROUP BY 
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END;

    -- DASHBOARD VIEW --
    CREATE VIEW ecommerce_dashboard AS
SELECT 
    user_id,
    age,
    gender,
    device_type,
    time_on_site,
    pages_viewed,
    previous_purchases,
    cart_items,
    discount_seen,
    ad_clicked,
    returning_user,
    avg_session_time,
    bounce_rate,
    purchase
FROM ecommerce_clean;

SELECT * 
FROM ecommerce_dashboard;