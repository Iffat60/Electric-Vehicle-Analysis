/* List down the compounded annual growth rate (CAGR) in 4-wheeler units for the top 5 makers
 from 2022 to 2024*/
with cte_2022 as(
select maker, sum(electric_vehicles_sold) as total_ev_sold_2022
from electric_vehicle_sales_by_makers m
join dim_date d
on d.date = m.date
where vehicle_category = '4-Wheelers' and fiscal_year = 2022
group by maker
order by total_ev_sold_2022 desc limit 5),
cte_2024 as(
select maker, sum(electric_vehicles_sold) as total_ev_sold_2024
from electric_vehicle_sales_by_makers m
join dim_date d
on d.date = m.date
where vehicle_category = '4-Wheelers' and fiscal_year = 2024
group by maker
order by total_ev_sold_2024 desc limit 5)

select c2.maker,
total_ev_sold_2022,
total_ev_sold_2024,
round(
((power(
(COALESCE(total_ev_sold_2024,0)/COALESCE(total_ev_sold_2022,0))
,(1.0/2))-1)*100,2)) AS CAGR
from cte_2022 c2
left join cte_2024 c4
on c2.maker = c4.maker

union

select c4.maker, total_ev_sold_2022, total_ev_sold_2024
from cte_2022 c2
right join cte_2024 c4
on c2.maker = c4.maker;

-- ==========================
-- by chat gpt
WITH cte_2022 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2022
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2022
    GROUP BY maker
    ORDER BY total_ev_sold_2022 DESC
    LIMIT 5
),
cte_2024 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2024
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2024
    GROUP BY maker
    ORDER BY total_ev_sold_2024 DESC
    LIMIT 5
)

SELECT 
    c2.maker,
    total_ev_sold_2022,
    total_ev_sold_2024,
    ROUND(
        (POWER(
            (COALESCE(total_ev_sold_2024, 0) / COALESCE(total_ev_sold_2022, 0)), 
            (1.0 / 2)
        ) - 1) * 100, 2
    ) AS CAGR
FROM cte_2022 c2
LEFT JOIN cte_2024 c4 ON c2.maker = c4.maker

UNION

SELECT 
    c4.maker, 
    total_ev_sold_2022, 
    total_ev_sold_2024,
    ROUND(
        (POWER(
            (COALESCE(total_ev_sold_2024, 0) / COALESCE(total_ev_sold_2022, 1)), 
            (1.0 / 2)
        ) - 1) * 100, 2
    ) AS CAGR_percent
FROM cte_2022 c2
RIGHT JOIN cte_2024 c4 ON c2.maker = c4.maker;

-- ===================
WITH cte_2022 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2022
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2022
    GROUP BY maker
    ORDER BY total_ev_sold_2022 DESC
    LIMIT 5
),
cte_2024 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2024
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2024
    GROUP BY maker
    ORDER BY total_ev_sold_2024 DESC
    LIMIT 5
)

SELECT 
    COALESCE(c2.maker, c4.maker) AS maker,
    COALESCE(c2.total_ev_sold_2022, 0) AS total_ev_sold_2022,
    COALESCE(c4.total_ev_sold_2024, 0) AS total_ev_sold_2024,
    CONCAT(
        ROUND(
            (POWER(
                (COALESCE(total_ev_sold_2024, 1) / COALESCE(total_ev_sold_2022, 1)), 
                (1.0 / 2)
            ) - 1) * 100, 2
        ), '%'
    ) AS CAGR_percentage
FROM cte_2022 c2
left JOIN cte_2024 c4 ON c2.maker = c4.maker

UNION

SELECT 
    c4.maker, 
    COALESCE(c2.total_ev_sold_2022, 0), 
    total_ev_sold_2024,
    CONCAT(
        ROUND(
            (POWER(
                (COALESCE(total_ev_sold_2024, 1) / COALESCE(total_ev_sold_2022, 1)), 
                (1.0 / 2)
            ) - 1) * 100, 2
        ), '%'
    ) AS CAGR_percentage
FROM cte_2022 c2
RIGHT JOIN cte_2024 c4 ON c2.maker = c4.maker;

-- ==========================================
-- after value verification with case when

WITH cte_2022 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2022
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2022
    GROUP BY maker
    ORDER BY total_ev_sold_2022 DESC
    LIMIT 5
),
cte_2024 AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_ev_sold_2024
    FROM electric_vehicle_sales_by_makers m
    JOIN dim_date d ON d.date = m.date
    WHERE vehicle_category = '4-Wheelers' AND fiscal_year = 2024
    GROUP BY maker
    ORDER BY total_ev_sold_2024 DESC
    LIMIT 5
)

SELECT 
    COALESCE(c2.maker, c4.maker) AS maker,
    COALESCE(c2.total_ev_sold_2022, 0) AS total_ev_sold_2022,
    COALESCE(c4.total_ev_sold_2024, 0) AS total_ev_sold_2024,
    CONCAT(
        ROUND(
            CASE
                WHEN COALESCE(c2.total_ev_sold_2022, 0) = null THEN 0
                ELSE (POWER(
                    (COALESCE(c4.total_ev_sold_2024, 0) / COALESCE(c2.total_ev_sold_2022, 0)), 
                    (1.0 / 2)
                ) - 1) * 100
            END, 2
        ), '%'
    ) AS CAGR_percentage
FROM cte_2022 c2
left JOIN cte_2024 c4 ON c2.maker = c4.maker
ORDER BY maker;


-- yearly evs sales
select fiscal_year,
sum(electric_vehicles_sold) as yearly_sales
from electric_vehicle_sales_by_makers m
join dim_date d
on m.date = d.date
group by fiscal_year;


