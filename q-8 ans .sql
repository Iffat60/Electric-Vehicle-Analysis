/*What are the peak and low season months for EV sales based on the data from 2022 to 2024?*/
with cte22 as(
SELECT SUBSTRING(date, 4, 3) as months,
sum(electric_vehicles_sold) as monthly_evs_sold_2022
FROM new_state_pent_rate
where fiscal_year=2022
group by months
),
cte23 as(
SELECT SUBSTRING(date, 4, 3) as months,
sum(electric_vehicles_sold) as monthly_evs_sold_2023
FROM new_state_pent_rate
where fiscal_year=2023
group by months
),
cte24 as(
SELECT SUBSTRING(date, 4, 3) as months,
sum(electric_vehicles_sold) as monthly_evs_sold_2024
FROM new_state_pent_rate
where fiscal_year=2024
group by months
)

select cte22.months,
		monthly_evs_sold_2022,
        monthly_evs_sold_2023,
        monthly_evs_sold_2024
from 
    cte22
join cte23
 on cte22.months = cte23.months
join cte24
on cte22.months = cte24.months ;
-- ==============================================================
-- with order by
WITH cte22 AS (
    SELECT 
        SUBSTRING(date, 4, 3) AS months,
        SUM(electric_vehicles_sold) AS monthly_evs_sold_2022
    FROM new_state_pent_rate
    WHERE fiscal_year = 2022
    GROUP BY months
),
cte23 AS (
    SELECT 
        SUBSTRING(date, 4, 3) AS months,
        SUM(electric_vehicles_sold) AS monthly_evs_sold_2023
    FROM new_state_pent_rate
    WHERE fiscal_year = 2023
    GROUP BY months
),
cte24 AS (
    SELECT 
        SUBSTRING(date, 4, 3) AS months,
        SUM(electric_vehicles_sold) AS monthly_evs_sold_2024
    FROM new_state_pent_rate
    WHERE fiscal_year = 2024
    GROUP BY months
)
SELECT 
    cte22.months,
    COALESCE(cte22.monthly_evs_sold_2022, 0) AS monthly_evs_sold_2022,
    COALESCE(cte23.monthly_evs_sold_2023, 0) AS monthly_evs_sold_2023,
    COALESCE(cte24.monthly_evs_sold_2024, 0) AS monthly_evs_sold_2024
FROM cte22
JOIN cte23 ON cte22.months = cte23.months
JOIN cte24 ON cte22.months = cte24.months
ORDER BY 
    (COALESCE(cte22.monthly_evs_sold_2022, 0) + COALESCE(cte23.monthly_evs_sold_2023, 0) + COALESCE(cte24.monthly_evs_sold_2024, 0)) DESC;
