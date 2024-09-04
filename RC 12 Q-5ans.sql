SELECT * FROM electric_vehicle.electric_vehicle_sales_by_state;
with delhi_karna_pene_rt as (
SELECT d.fiscal_year,state , electric_vehicles_sold,total_vehicles_sold,penetration_rate
FROM electric_vehicle_sales_by_state s
left join dim_date d
on d.date = s.date
where 
state in ( "Delhi" , "Karnataka") and
d.fiscal_year = 2024)
select state, sum(electric_vehicles_sold) as ev_sold,
sum(total_vehicles_sold) as total_vehicle_sold, round(sum(penetration_rate),2) as pent_rate
from delhi_karna_pene_rt
group by state


