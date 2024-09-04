/*List down the top 10 states that had the highest compounded annual growth rate (CAGR)
 from 2022 to 2024 in total vehicles sold.*/
 with cte_22 as (
 select state,
 sum(electric_vehicles_sold) as total_evs_sold_2022
 from new_state_pent_rate
 where fiscal_year = 2022
 group by state
 ),
 cte_24 as(
  select state,
 sum(electric_vehicles_sold) as total_evs_sold_2024
 from new_state_pent_rate
 where fiscal_year = 2024
 group by state
 )
 select 
 c22.state,
 total_evs_sold_2022,
 total_evs_sold_2024,
concat(round(
(power((total_evs_sold_2024/total_evs_sold_2022),1.0/2)-1)*100
	,2),"%") as CAGR_perc
from cte_22 c22
join cte_24 c24
on c22.state= c24.state
order by CAGR_perc desc
limit 10;

 -- =================================
-- after verificaton
 WITH cte_22 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2022
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2022
  GROUP BY 
    state
),
cte_24 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2024
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2024
  GROUP BY 
    state
)
SELECT 
  c22.state,
  total_evs_sold_2022,
  total_evs_sold_2024,
  ROUND(
    (POWER((total_evs_sold_2024 / total_evs_sold_2022), 1.0 / 2) - 1) * 100, 
    2
  ) AS CAGR_perc
FROM 
  cte_22 c22
JOIN 
  cte_24 c24 ON c22.state = c24.state
ORDER BY 
  CAGR_perc DESC
LIMIT 
  10;
-- ====================

-- afte modulus sign issue resolved
WITH cte_22 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2022
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2022
  GROUP BY 
    state
),
cte_24 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2024
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2024
  GROUP BY 
    state
)
SELECT 
  c22.state,
  total_evs_sold_2022,
  total_evs_sold_2024,
  CONCAT(
    ROUND(
      (POWER((total_evs_sold_2024 / total_evs_sold_2022), 0.5) - 1) * 100, 
      2
    ),
    '%'
  ) AS CAGR_perc
FROM 
  cte_22 c22
JOIN 
  cte_24 c24 ON c22.state = c24.state
ORDER BY 
  ROUND(
    (POWER((total_evs_sold_2024 / total_evs_sold_2022), 0.5) - 1) * 100, 
    2
  ) DESC
LIMIT 
  10;
-- ================
-- making query more readable
WITH cte_22 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2022
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2022
  GROUP BY 
    state
),
cte_24 AS (
  SELECT 
    state,
    SUM(electric_vehicles_sold) AS total_evs_sold_2024
  FROM 
    new_state_pent_rate
  WHERE 
    fiscal_year = 2024
  GROUP BY 
    state
),
cagr_calculated AS (
  SELECT
    c22.state,
    total_evs_sold_2022,
    total_evs_sold_2024,
    ROUND(
      (POWER((total_evs_sold_2024 / total_evs_sold_2022), 0.5) - 1) * 100, 
      2
    ) AS CAGR_value
  FROM 
    cte_22 c22
  JOIN 
    cte_24 c24 ON c22.state = c24.state
)
SELECT 
  state,
  total_evs_sold_2022,
  total_evs_sold_2024,
  CONCAT(CAGR_value, '%') AS CAGR_perc
FROM 
  cagr_calculated
ORDER BY 
  CAGR_value DESC
LIMIT 
  10;
