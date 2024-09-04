
select 
maker, d.quarter ,sum( electric_vehicles_sold) as total_ev_sold_2022
 from electric_vehicle_sales_by_makers m
 JOIN dim_date d
 on d.date = m.date
where vehicle_category = '4-Wheelers'
and
fiscal_year = 2022
group by maker, d.quarter
having total_ev_sold_2022 > 0
order by d.quarter, total_ev_sold_2022 desc;
-- ============================================
WITH Top5Makers AS (
    SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    WHERE vehicle_category = '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
)
SELECT 
    m.maker, 
    d.quarter, 
    SUM(m.electric_vehicles_sold) AS total_ev_sold_2022
FROM 
    electric_vehicle_sales_by_makers m
JOIN 
    dim_date d ON d.date = m.date
JOIN 
    Top5Makers t ON t.maker = m.maker
WHERE 
    d.fiscal_year = 2022
GROUP BY 
    m.maker, d.quarter
HAVING 
    total_ev_sold_2022 > 0
ORDER BY 
    d.quarter, total_ev_sold_2022 DESC;

-- =================
-- 2023

WITH Top5Makers AS (
    SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    WHERE vehicle_category = '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
)
SELECT 
    m.maker, 
    d.quarter, 
    SUM(m.electric_vehicles_sold) AS total_ev_sold_2023
FROM 
    electric_vehicle_sales_by_makers m
JOIN 
    dim_date d ON d.date = m.date
JOIN 
    Top5Makers t ON t.maker = m.maker
WHERE 
    d.fiscal_year = 2023
GROUP BY 
    m.maker, d.quarter
HAVING 
    total_ev_sold_2023 > 0
ORDER BY 
    d.quarter, total_ev_sold_2023 DESC;

-- ========================
-- 2024

WITH Top5Makers AS (
    SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    WHERE vehicle_category = '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
)
SELECT 
    m.maker, 
    d.quarter, 
    SUM(m.electric_vehicles_sold) AS total_ev_sold_2024
FROM 
    electric_vehicle_sales_by_makers m
JOIN 
    dim_date d ON d.date = m.date
JOIN 
    Top5Makers t ON t.maker = m.maker
WHERE 
    d.fiscal_year = 2024
GROUP BY 
    m.maker, d.quarter
HAVING 
    total_ev_sold_2024 > 0
ORDER BY 
    d.quarter, total_ev_sold_2024 DESC;
-- ================================

-- using row number

WITH quarterly_sales AS (
    SELECT 
        maker, 
        d.quarter,
        SUM(electric_vehicles_sold) AS total_ev_sold_22
    FROM 
        electric_vehicle_sales_by_makers m
    JOIN 
        dim_date d ON d.date = m.date
    WHERE 
        vehicle_category = '4-Wheelers'
	and fiscal_year = 2022
    GROUP BY 
        maker, d.quarter
)
SELECT 
    maker, 
    quarter,
    total_ev_sold_22
FROM (
    SELECT 
        maker, 
        quarter,
        total_ev_sold_22,
        ROW_NUMBER() OVER (PARTITION BY quarter ORDER BY total_ev_sold_22 DESC) AS rn
    FROM 
        quarterly_sales
) ranked_sales
WHERE 
    rn <= 5
ORDER BY 
    quarter, total_ev_sold_22 DESC;
-- 2023
WITH quarterly_sales AS (
    SELECT 
        maker, 
        d.quarter,
        SUM(electric_vehicles_sold) AS total_ev_sold_23
    FROM 
        electric_vehicle_sales_by_makers m
    JOIN 
        dim_date d ON d.date = m.date
    WHERE 
        vehicle_category = '4-Wheelers'
	and fiscal_year = 2023
    GROUP BY 
        maker, d.quarter
)
SELECT 
    maker, 
    quarter,
    total_ev_sold_23
FROM (
    SELECT 
        maker, 
        quarter,
        total_ev_sold_23,
        ROW_NUMBER() OVER (PARTITION BY quarter ORDER BY total_ev_sold_23 DESC) AS rn
    FROM 
        quarterly_sales
) ranked_sales
WHERE 
    rn <= 5
ORDER BY 
    quarter, total_ev_sold_23 DESC;
-- 2024

WITH quarterly_sales AS (
    SELECT 
        maker, 
        d.quarter,
        SUM(electric_vehicles_sold) AS total_ev_sold_24
    FROM 
        electric_vehicle_sales_by_makers m
    JOIN 
        dim_date d ON d.date = m.date
    WHERE 
        vehicle_category = '4-Wheelers'
	and fiscal_year = 2024
    GROUP BY 
        maker, d.quarter
)
SELECT 
    maker, 
    quarter,
    total_ev_sold_24
FROM (
    SELECT 
        maker, 
        quarter,
        total_ev_sold_24,
        ROW_NUMBER() OVER (PARTITION BY quarter ORDER BY total_ev_sold_24 DESC) AS rn
    FROM 
        quarterly_sales
) ranked_sales
WHERE 
    rn <= 5
ORDER BY 
    quarter, total_ev_sold_24 DESC;
-- ==============================

SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    where vehicle_category= '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
-- ===============
WITH Top5Makers AS (
    SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    WHERE vehicle_category = '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
)
SELECT 
    m.maker, 
    d.quarter, 
    SUM(m.electric_vehicles_sold) AS total_ev_sold
FROM 
    electric_vehicle_sales_by_makers m
JOIN 
    dim_date d ON d.date = m.date
JOIN 
    Top5Makers t ON t.maker = m.maker
GROUP BY 
    m.maker, d.quarter
HAVING 
    total_ev_sold > 0
ORDER BY 
    d.quarter, total_ev_sold DESC;
-- ==========================
WITH Top5Makers AS (
    SELECT maker, SUM(electric_vehicles_sold) AS ev_sold
    FROM electric_vehicle_sales_by_makers
    WHERE vehicle_category = '4-Wheelers'
    GROUP BY maker
    ORDER BY ev_sold DESC
    LIMIT 5
)
SELECT 
    m.maker, 
    d.quarter, 
    SUM(m.electric_vehicles_sold) AS total_ev_sold_2022
FROM 
    electric_vehicle_sales_by_makers m
JOIN 
    dim_date d ON d.date = m.date
JOIN 
    Top5Makers t ON t.maker = m.maker

GROUP BY 
    m.maker, d.quarter
HAVING 
    total_ev_sold_2022 > 0
ORDER BY 
    d.quarter, total_ev_sold_2022 DESC;











