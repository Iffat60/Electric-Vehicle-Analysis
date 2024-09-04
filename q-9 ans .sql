/*9.
What is the projected number of EV sales (including 2-wheelers and 4-wheelers)
for the top 10 states by penetration rate in 2030, based on the compounded annual
growth rate (CAGR) from previous years?*/

-- cte_top_10_state: Identifies the top 10 states by penetration rate.
with cte_top_10_state as(
SELECT state,
       round(sum(penetration_rate),2) as state_pent_rt
FROM new_state_pent_rate
group by state
order by state_pent_rt desc limit 10),

-- cte_top_10_sales_22: Calculates total EV sales for 2022 for the top 10 states.
cte_top_10_pent_rt_22 as (
SELECT c10.state,
       round(sum(penetration_rate),2) as state_pent_rt_22
FROM cte_top_10_state c10
join penetration_rate_by_state ps
on c10.state = ps.state
where fiscal_year = 2022
group by state
order by state_pent_rt_22 desc limit 10
),

-- cte_top_10_sales_24: Calculates total EV sales for 2024 for the top 10 states.
cte_top_10_pent_rt_24 as (
SELECT c10.state,
       round(sum(penetration_rate),2) as state_pent_rt_24
FROM cte_top_10_state c10
join penetration_rate_by_state ps
on c10.state = ps.state
where fiscal_year = 2024
group by state
order by state_pent_rt_24 desc limit 10
),

-- cte_cagr_value: Computes the CAGR based on sales data from 2022 to 2024
cte_cagr_value as(
select c10.state,
	state_pent_rt,
    state_pent_rt_22,
    state_pent_rt_24,
    ROUND(
      (POWER((state_pent_rt_24 / state_pent_rt_22), 0.5) - 1), 
      2
    ) AS CAGR_value
from cte_top_10_state c10
join cte_top_10_pent_rt_22 c22
on c10.state = c22.state
join cte_top_10_pent_rt_24 c24
on c10.state = c24.state
order by CAGR_value  desc),

-- Final SELECT: Projects the sales in 2030 using the CAGR.
final_table as (
select state,
	state_pent_rt,
    state_pent_rt_22,
    state_pent_rt_24,
   concat( CAGR_value, '%') as CAGR_PERC,
    round(state_pent_rt_24 * power((1+CAGR_value),6),2) as projected_sales
from cte_cagr_value)
select state,state_pent_rt_24,
		projected_sales
from 
final_table

-- ==========
