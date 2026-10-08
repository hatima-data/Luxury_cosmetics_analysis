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












































