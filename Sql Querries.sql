create database superstore;
use superstore;
create table store
(
    `Row ID` INT primary key not null auto_increment,
    `Order ID` VARCHAR(20),
    `Order Date` date,
    `Ship Date` date,
    `Ship Mode` VARCHAR(50),
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    `Segment` VARCHAR(50),
    `Country` VARCHAR(50),
    `City` VARCHAR(50),
    `State` VARCHAR(50),
    `Postal Code` VARCHAR(20),
    `Region` VARCHAR(50),
    `Product ID` VARCHAR(20),
    `Category` VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` VARCHAR(255),
    `Sales` DECIMAL(10, 2),
    `Quantity` INT,
    `Discount` DECIMAL(4, 2),
    `Profit` DECIMAL(10, 2)
);
SHOW VARIABLES LIKE 'secure_file_priv';

load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\final project 1.csv"
into table store
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
select * from store;
-- Total Sales and Profit--
select round(sum(Sales),2) as Total_sales,round(sum(Profit),2) as Total_profit from Store;
-- Average Sales and Profit Per Order--
select `Order ID` ,round(avg(Sales),2) as Average_sales,round(avg(profit),2) as average_profit from store group by `Order ID`;
--  State-wise Sales, Profit, and Profit Margin
with new_tab as (select State,sum(Sales) as Sales_sum,sum(Profit) as Profit_sum from store group by State )
select State,Sales_Sum,Profit_sum,round((Profit_sum/Sales_sum)*100,2)  as profit_margin from new_tab order by profit_margin desc;

-- Top 10 profitable Product
with new_tab as(select `Product Name`,round(sum(Sales),2) as tot_Sale,round(sum(Profit),2) as tot_profit from store group by `Product Name`)
select `Product Name`,tot_profit, round((tot_profit/tot_sale)*100,2) as Profit_margin from new_tab order by tot_profit desc;
-- top  3  Highest Sales months--
with new_tab as (select *,monthname(`Order Date`) as mon from store)
select	mon as 'Month',round(sum(Sales),2) as sale,round(sum(Profit),2) as total_profit from new_tab group by mon
order by sale desc limit 3;