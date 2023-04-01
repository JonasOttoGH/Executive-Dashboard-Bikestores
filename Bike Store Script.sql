--View and check all downloaded tables
SELECT *
FROM BikeStores.production.brands

SELECT *
FROM BikeStores.production.categories

SELECT *
FROM BikeStores.production.products

SELECT *
FROM BikeStores.production.stocks

SELECT *
FROM BikeStores.sales.customers

SELECT *
FROM BikeStores.sales.order_items

SELECT *
FROM BikeStores.sales.orders

SELECT *	
FROM BikeStores.sales.customers

SELECT *	
FROM BikeStores.sales.staffs

SELECT *	
FROM BikeStores.sales.stores

-- Query to exctract useful data from tables above into one table

SELECT ord.order_id, 
		CONCAT(cus.first_name, ' ', cus.last_name) as customer_name,
		cus.city, 
		cus.state,
		ord.order_date,
		SUM(item.quantity) as total_units, 
		SUM(item.quantity * item.list_price) as total_revenue,
		pro.product_name,
		cat.category_name,
		store.store_name,
		CONCAT(staf.first_name, ' ', staf.last_name) as sales_rep,
		brand_name
FROM BikeStores.sales.orders ord
JOIN BikeStores.sales.customers cus
ON cus.customer_id = ord.customer_id
JOIN BikeStores.sales.order_items item
ON ord.order_id = item.order_id
JOIN BikeStores.production.products pro
ON pro.product_id = item.product_id
JOIN BikeStores.production.categories cat
ON cat.category_id = pro.category_id
JOIN BikeStores.sales.stores store
ON store.store_id = ord.store_id
JOIN BikeStores.sales.staffs staf
ON staf.staff_id = ord.staff_id
JOIN BikeStores.production.brands bra
ON bra.brand_id = pro.brand_id
GROUP BY ord.order_id, 
		CONCAT(cus.first_name, ' ', cus.last_name),
		cus.city, 
		cus.state,
		ord.order_date,
		pro.product_name,
		cat.category_name,
		store.store_name,
		CONCAT(staf.first_name, ' ', staf.last_name),
		brand_name


