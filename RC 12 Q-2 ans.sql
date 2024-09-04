-- Q2
/*Identify the top 5 states with the highest penetration rate in 2-wheeler and 4-wheeler
EV sales in FY 2024*/

SELECT * FROM electric_vehicle.electric_vehicle_sales_by_state;

select sum(total_vehicles_sold) from electric_vehicle_sales_by_state;

select 
(sum(electric_vehicles_sold)/
(select sum(total_vehicles_sold) from electric_vehicle_sales_by_state))*100 as total_penetration
from electric_vehicle_sales_by_state;
-- 2-wheelar category
select sum(electric_vehicles_sold) 
from electric_vehicle_sales_by_state
where vehicle_category = "2-Wheelers";

select sum(total_vehicles_sold) 
from electric_vehicle_sales_by_state
where vehicle_category = "2-Wheelers"

;
-- =========================================================================================
-- penetration of 2 wheeler electric vehicles by state for fy=2024
select state,sum(electric_vehicles_sold/total_vehicles_sold)*100 as state_pen_rt
from electric_vehicle_sales_by_state s
join dim_date d
on d.date = s.date
where fiscal_year = 2024 and vehicle_category = '2-Wheelers'
group by state
order by state_pen_rt desc
limit 5;

-- ------------------------------------------------------------------------------
-- penetration of 4 wheeler electric vehicles by state for fy=2024
select state,sum(electric_vehicles_sold/total_vehicles_sold)*100 as state_pen_rt
from electric_vehicle_sales_by_state s
join dim_date d
on d.date = s.date
where fiscal_year = 2024 and vehicle_category = '4-Wheelers'
group by state
order by state_pen_rt desc
limit 5;

-- penetration rate of electric vehicle by state
select state,sum(electric_vehicles_sold/total_vehicles_sold)*100 as state_pen_rt
from electric_vehicle_sales_by_state s
join dim_date d
on d.date = s.date
where fiscal_year = 2024 
group by state
order by state_pen_rt desc
limit 5;