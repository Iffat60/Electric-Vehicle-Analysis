/*Estimate the revenue growth rate of 4-wheeler and 2-wheelers EVs in India for
 2022 vs 2024 and 2023 vs 2024, assuming an average unit price. H*/
 -- Calculate the total number of 4-wheeler and 2-wheeler EV sales for each year (2022, 2023, 2024).
 select vehicle_category,
	    sum(electric_vehicles_sold) as total_evs_sold
from new_state_pent_rate
group by vehicle_category ;

-- ===============================================================================

-- total electric vehicles sold in 2022
SET @2_wheelers_p = 85000;
SET @4_wheelers_p = 1500000;

WITH evs_sold_22 AS (
  SELECT vehicle_category,
         SUM(electric_vehicles_sold) AS ev_sold_2022,
         CASE 
           WHEN vehicle_category = '2-Wheelers' THEN SUM(electric_vehicles_sold) * @2_wheelers_p
           WHEN vehicle_category = '4-Wheelers' THEN SUM(electric_vehicles_sold) * @4_wheelers_p
         END AS revenue_2022
  FROM new_state_pent_rate
  WHERE fiscal_year = 2022
  GROUP BY vehicle_category
), 
evs_sold_23 AS (
  SELECT vehicle_category,
         SUM(electric_vehicles_sold) AS ev_sold_2023,
         CASE 
           WHEN vehicle_category = '2-Wheelers' THEN SUM(electric_vehicles_sold) * @2_wheelers_p
           WHEN vehicle_category = '4-Wheelers' THEN SUM(electric_vehicles_sold) * @4_wheelers_p
         END AS revenue_2023
  FROM new_state_pent_rate
  WHERE fiscal_year = 2023
  GROUP BY vehicle_category
), 
evs_sold_24 AS (
  SELECT vehicle_category,
         SUM(electric_vehicles_sold) AS ev_sold_2024,
         CASE 
           WHEN vehicle_category = '2-Wheelers' THEN SUM(electric_vehicles_sold) * @2_wheelers_p
           WHEN vehicle_category = '4-Wheelers' THEN SUM(electric_vehicles_sold) * @4_wheelers_p
         END AS revenue_2024
  FROM new_state_pent_rate
  WHERE fiscal_year = 2024
  GROUP BY vehicle_category
),
final_table as ( 
SELECT e24.vehicle_category,
       (e22.revenue_2022)/1000000000 as revenue_22_bil,
       (e23.revenue_2023)/1000000000 as revenue_23_bil,
       (e24.revenue_2024)/1000000000 as revenue_24_bil,
       (e24.revenue_2024 - e22.revenue_2022) / e22.revenue_2022 AS growth_rate_2022_vs_24,
       (e24.revenue_2024 - e23.revenue_2023) / e23.revenue_2023 AS growth_rate_2023_vs_24
FROM evs_sold_24 e24
JOIN evs_sold_22 e22
  ON e24.vehicle_category = e22.vehicle_category
JOIN evs_sold_23 e23
  ON e23.vehicle_category = e24.vehicle_category)

select vehicle_category,
		growth_rate_2023_vs_24
        
from final_table;
