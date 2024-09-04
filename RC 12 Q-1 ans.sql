SELECT * FROM electric_vehicle.electric_vehicle_sales_by_makers;
select distinct maker from electric_vehicle_sales_by_makers;
-- resume project challenge start--------------
-- q-1
-- top 3 fy = 2023
select maker,sum(electric_vehicles_sold) as total_vehicle_sold_23
from electric_vehicle_sales_by_makers m
join dim_date d
on m.date = d.date
where vehicle_category = '2-Wheelers'
and d.fiscal_year = 2023
group by maker
order by total_vehicle_sold_23 desc 
limit 3

;
-- top 3 fy 2024
select maker,sum(electric_vehicles_sold) as total_vehicle_sold_24
from electric_vehicle_sales_by_makers m
join dim_date d
on m.date = d.date
where vehicle_category = '2-Wheelers'
and d.fiscal_year = 2024
group by maker
order by total_vehicle_sold_24 desc 
limit 3;

-- bottom 3
-- fy = 2023

select maker,sum(electric_vehicles_sold) as total_vehicle_sold_23
from electric_vehicle_sales_by_makers m
join dim_date d
on m.date = d.date
where vehicle_category = '2-Wheelers'
and d.fiscal_year in (2023)
group by maker
order by total_vehicle_sold_23 
limit 3  ;

-- bottom 3 fy 2024
select maker,sum(electric_vehicles_sold) as total_vehicle_sold_24
from electric_vehicle_sales_by_makers m
join dim_date d
on m.date = d.date
where vehicle_category = '2-Wheelers'
and d.fiscal_year in (2024)
group by maker
order by total_vehicle_sold_24 
limit 3;

