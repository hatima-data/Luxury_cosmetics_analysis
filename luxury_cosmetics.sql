create table luxury_cosmetics(
				event_id varchar PRIMARY KEY,
				brand varchar,
				region varchar,
				city varchar,
				location_type varchar,
				event_type varchar,
				start_date date,
				end_date date,
				lease_length_days int,
				sku varchar,
				product_name varchar,
				price_usd decimal,
				avg_daily_footfall int,
				units_sold int,
				sell_through_pct decimal(5,2)
				
                ) 

select * from luxury_cosmetics

select
	brand,
	city,
	region
	from luxury_cosmetics
	where region='North America'


select 
	event_type,
	sum(units_sold)
	from luxury_cosmetics
	group by event_type;

select 
	brand,
	price_usd,
	product_name
	from luxury_cosmetics
	order by price_usd desc
	limit 1

select 
	sum(price_usd)
	from luxury_cosmetics
	
select sum(units_sold)
	from luxury_cosmetics;


select
	brand,
	region,
	city,
	lease_length_days
	from luxury_cosmetics
	where region ='Europe'
	and lease_length_days>30;

select
	brand,
	sum(units_sold),
	avg(units_sold),
	min(units_sold)
	from luxury_cosmetics
	group by brand
	having sum(units_sold)>10
	limit 10;

select 
	brand,price_usd,
	case 
		when price_usd>100 then 'Luxury'
		else 'Standard'
		end as category
		from luxury_cosmetics;

select
		count(
			case
				when price_usd>100 
					then 'Luxury' end) as luxury_count,
		count(
			case
			when price_usd<=100 
				then 'Standard' end) as standard_count
		from luxury_cosmetics;


select 
	product_name,
	count(*)
	from luxury_cosmetics
	group by product_name;

select
	city,
	region
	from luxury_cosmetics
	group by region,city;
	
select
	brand,
	city
	from luxury_cosmetics
	group by brand,city;

select 
	brand,
	product_name
	from luxury_cosmetics
	where product_name like'%Beauty%';

select
	city,
	avg(avg_daily_footfall)
	from luxury_cosmetics
	group by city;

select 
	start_date
	from luxury_cosmetics
	where start_date >'2024-03-01'
	order by start_date asc;


select 
	brand,
	sum(units_sold)
	from luxury_cosmetics
	group by brand
	having sum(units_sold)>5;

select 
	location_type,
	price_usd
	from luxury_cosmetics
	where location_type like'%Duty-Free%'
	order by price_usd desc;
	
select
	brand,
	city,
	product_name,
	region,
	price_usd
	from luxury_cosmetics
	where(region='Europe' or region='North America') and price_usd>50;

select count(*)from luxury_cosmetics;
	
select
	max(price_usd),
	avg(price_usd),
	min(price_usd)
	from luxury_cosmetics

select
	distinct city from luxury_cosmetics;

select
	distinct product_name from luxury_cosmetics;

select 
	distinct region from luxury_cosmetics;

select 
	distinct brand from luxury_cosmetics;

select 
	distinct location_type from luxury_cosmetics;

select
	region,
	brand,
	product_name,
	price_usd,
	row_number() over(partition by region order by price_usd desc) as row_num
	from luxury_cosmetics;

select
	region,
	brand,
	product_name,
	price_usd,
	rank() over(partition by brand order by price_usd desc) as price_rank
	from luxury_cosmetics;

with rakend_product as(
select
						region,
						brand,
						product_name,
						price_usd,
						rank() over(partition by brand order by price_usd desc) as price_rank
						from luxury_cosmetics
)


select 
	region,
	brand,
	product_name,
	price_usd
	price_rank
	from rakend_product
	where price_rank=1;
	
select
	product_name,
	brand,
	price_usd
	from luxury_cosmetics
	where  price_usd>(select avg(price_usd) from luxury_cosmetics)


select 
	count(*)-count(brand) as brand_null,
	count(*)-count(region) as region_null,
	count(*)-count(city) as city_null,
	count(*)-count(location_type) as loc_null,
	count(*)-count(event_type) as event_null,
	count(*)-count(start_date) as start_date_null,
	count(*)-count(end_date) as end_date_null,
	count(*)-count(lease_length_days) as days_null,
	count(*)-count(sku) as sku_null,
	count(*)-count(product_name) as name_null,
	count(*)-count(price_usd) as price_usd_null,
	count(*)-count(avg_daily_footfall) as daily_footfall_null,
	count(*)-count(units_sold) as units_sold_null,
	count(*)-count(sell_through_pct)  as sell_through_pct_null
from luxury_cosmetics;

	
select city from luxury_cosmetics
where city is null;

update luxury_cosmetics
set city='Unkown'
where city is null;

select end_date from luxury_cosmetics
where end_date is null;

update luxury_cosmetics
set end_date=start_date
where end_date is null;

select 
	brand,
	min(price_usd) as min_price_usd,
	round(avg(price_usd),2) as avg_price_usd,
	max(price_usd) as max_price_usd
	from luxury_cosmetics
	group by brand;

select
	product_name,
	brand,
	price_usd,
	units_sold
	from luxury_cosmetics
	where price_usd>(select avg(price_usd) from luxury_cosmetics)
	order by units_sold desc
	limit 10;

select
	brand,
	round(sum(price_usd*units_sold), 2) as total_revenue,
	round((sum(price_usd*units_sold)/sum(sum(price_usd*units_sold)) over())*100,
	2)	
	as revenue_share_pct
	from luxury_cosmetics
	group by brand
	order by total_revenue desc

select
	region,
	location_type,
	sum(units_sold) as total_units_sold,
	round(sum(price_usd*units_sold), 2) as total_revenue
	from luxury_cosmetics
	group by region, location_type
	having sum(price_usd*units_sold)>100000
	order by total_revenue;

select
	date_trunc('month', start_date) as sales_month,
	sum(units_sold) as total_units,
	round(sum(price_usd*units_sold), 2) as total_revenue
	from luxury_cosmetics
	group by date_trunc('month', start_date)
	order by sales_month;

with monthly_sales as(
				select
					date_trunc('month', start_date) as sales_month,
					round(sum(price_usd*units_sold), 2)as current_month_revenue
				from luxury_cosmetics
				group by date_trunc('month', start_date)
)
select 
	sales_month,
	current_month_revenue,
	lag(current_month_revenue) over(order by sales_month) as previous_month_revenue
	from monthly_sales
	order by sales_month asc;









