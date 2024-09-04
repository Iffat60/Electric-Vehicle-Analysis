-- List the states with negative penetration (decline) in EV sales from 2022 to 2024?

select 
  s.date,
  fiscal_year,
  quarter,
  state,
  vehicle_category,
 sum( electric_vehicles_sold) as electric_vehicles_sold,
 sum(total_vehicles_sold)as total_vehicles_sold,
 sum(round((electric_vehicles_sold / total_vehicles_sold)*100,2)) as penetration_rate
 from electric_vehicle_sales_by_state s
 join dim_date d
 on d.date = s.date
 group by vehicle_category,state,s.date,
  fiscal_year,
  quarter
 order by penetration_rate;
 ;
 
 -- =========================================================
 with cte as 
 ( SELECT state, sum(penetration_rate) as penetration_rate_2022
 from penetration_rate_by_state
 where fiscal_year = 2022
 group by state
 order by state),
 
cte1 as (
 SELECT state, sum(penetration_rate) as penetration_rate_2024 
 from penetration_rate_by_state
 where fiscal_year = 2024
 group by state
 order by state)
 select cte1.state, cte1.penetration_rate_2024, cte.penetration_rate_2022,
penetration_rate_2024 - penetration_rate_2022 as chg_pent_rate
 from cte
 join cte1 on cte.state = cte1.state
 
 where penetration_rate_2024 < penetration_rate_2022
 ;
 
-- =========================================================================================
WITH penetration_2022 AS (
    SELECT
        state,
       -- vehicle_category,
       penetration_rate AS rate_2022
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2022

),
penetration_2024 AS (
    SELECT
        state,
      --  vehicle_category,
       penetration_rate AS rate_2024
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2024
),
rate_comparison AS (
    SELECT
        p2022.state,
       -- p2022.vehicle_category,
        p2022.rate_2022,
        p2024.rate_2024,
        (p2024.rate_2024 - p2022.rate_2022) AS rate_change
    FROM
        penetration_2022 p2022
    JOIN
        penetration_2024 p2024 ON p2022.state = p2024.state
        -- AND p2022.vehicle_category = p2024.vehicle_category
)
SELECT
    state,
  max(rate_2022),
  max(rate_2024),
  max(rate_change)
FROM
    rate_comparison 
WHERE
    rate_2024 < rate_2022
group by state    
;


-- ===========================================================
WITH penetration_2022 AS (
    SELECT
        state,
        vehicle_category,
        penetration_rate AS rate_2022
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2022
),
penetration_2024 AS (
    SELECT
        state,
        vehicle_category,
        penetration_rate AS rate_2024
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2024
),
rate_comparison AS (
    SELECT
        p2022.state,
        p2022.vehicle_category,
        p2022.rate_2022,
        p2024.rate_2024,
        (p2024.rate_2024 - p2022.rate_2022) AS rate_change
    FROM
        penetration_2022 p2022
    JOIN
        penetration_2024 p2024 ON p2022.state = p2024.state
        AND p2022.vehicle_category = p2024.vehicle_category
)
SELECT
    state,
    vehicle_category,
    rate_2022,
    rate_2024,
    rate_change
FROM
    rate_comparison
WHERE
    rate_change < 0;
-- ===============================================================================
-- got the output without duplicates
WITH penetration_2022 AS (
    SELECT
        state,
        vehicle_category,
        MAX(penetration_rate) AS rate_2022
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2022
    GROUP BY
        state,
        vehicle_category
),
penetration_2024 AS (
    SELECT
        state,
        vehicle_category,
        MAX(penetration_rate) AS rate_2024
    FROM
        penetration_rate_by_state
    WHERE
        fiscal_year = 2024
    GROUP BY
        state,
        vehicle_category
),
rate_comparison AS (
    SELECT
        p2022.state,
        p2022.vehicle_category,
        p2022.rate_2022,
        p2024.rate_2024,
        (p2024.rate_2024 - p2022.rate_2022) AS rate_change
    FROM
        penetration_2022 p2022
    JOIN
        penetration_2024 p2024 ON p2022.state = p2024.state
        AND p2022.vehicle_category = p2024.vehicle_category
)
SELECT
    state,
    vehicle_category,
    rate_2022,
    rate_2024,
    rate_change
FROM
    rate_comparison
WHERE
    rate_change < 0;
-- ==================
with cte as 
 ( SELECT state, sum(penetration_rate) as penetration_rate_2022
 from new_state_pent_rate
 where fiscal_year = 2022
 group by state
 order by state),
 
cte1 as (
 SELECT state, sum(penetration_rate) as penetration_rate_2024 
 from new_state_pent_rate
 where fiscal_year = 2024
 group by state
 order by state)
 select cte1.state, cte1.penetration_rate_2024, cte.penetration_rate_2022,
penetration_rate_2024 - penetration_rate_2022 as chg_pent_rate
 from cte
 join cte1 on cte.state = cte1.state
 
 where penetration_rate_2024 < penetration_rate_2022
 ;
 -- ==================
  with cte as 
 ( SELECT state, sum(penetration_rate) as penetration_rate_2022
 from penetration_rate_by_state
 where fiscal_year = 2022
 group by state
 order by state),
 
cte1 as (
 SELECT state, sum(penetration_rate) as penetration_rate_2024 
 from penetration_rate_by_state
 where fiscal_year = 2024
 group by state
 order by state)
 select cte1.state, cte1.penetration_rate_2024, cte.penetration_rate_2022,
penetration_rate_2024 - penetration_rate_2022 as chg_pent_rate
 from cte
 join cte1 on cte.state = cte1.state
 
 where penetration_rate_2024 < penetration_rate_2022
 ;