USE master;
GO
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name='DBMS_G10')
BEGIN
    CREATE DATABASE DBMS_G10;
END
GO
IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='Members')
			
		CREATE TABLE Members(
			member_id INT NOT NULL PRIMARY KEY,
			username VARCHAR(50) UNIQUE,
			[password] VARCHAR(50) UNIQUE,
			email VARCHAR(100) UNIQUE,
			role VARCHAR(20)
			);
			
	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='MemberDetails')	
			
		CREATE TABLE MemberDetails (
			member_id INT NOT NULL PRIMARY KEY,
			full_name VARCHAR(100),
			contact_number VARCHAR(20),
			address TEXT,
			FOREIGN KEY (member_id) REFERENCES Members(member_id)
			);

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='FoodCategories')
			
		CREATE TABLE FoodCategories (
			category_id INT PRIMARY KEY,
			Category_name VARCHAR(100)
			);

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='FoodItems')	

		CREATE TABLE FoodItems (
			item_id INT NOT NULL PRIMARY KEY,
			item_name VARCHAR(100),
			description TEXT,
			price DECIMAL(10,2),
			availability BIT,---> 0 or 1
			category_id INT,
			FOREIGN KEY (category_id) REFERENCES FoodCategories (category_id)
			);

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='orders')

		CREATE TABLE orders (
			order_id INT NOT NULL PRIMARY KEY,
			member_id INT,
			order_date DATE,
			total_cost DECIMAL(10,2),
			payment_status VARCHAR(20),
			FOREIGN KEY (member_id) REFERENCES Members(member_id)
			);

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='OrderDetails')

		CREATE TABLE OrderDetails (
			order_detail_id INT NOT NULL PRIMARY KEY,
			order_id INT,
			item_id INT,
			quantity INT,
			FOREIGN KEY (order_id) REFERENCES Orders(order_id),
			FOREIGN KEY (item_id) REFERENCES FoodItems(item_id)
			);

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='PaymentDetails')

		CREATE TABLE PaymentDetails(
			payment_id INT NOT NULL PRIMARY KEY,
			order_id INT,
			Payment_method VARCHAR(50),
			Payment_amount DECIMAL(10, 2),
			payment_date DATE,
			FOREIGN KEY (order_id) REFERENCES Orders(order_id)
			);

	IF NOT EXISTS(SELECT 1
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE='BASE TABLE'
		AND TABLE_NAME='PaymentGateway')

		CREATE TABLE PaymentGateway (
    		gateway_id INT PRIMARY KEY IDENTITY(1,1),
    		gateway_name VARCHAR(50) NOT NULL,
   		    gateway_type VARCHAR(50) NOT NULL,
    		gateway_status BIT DEFAULT 1
);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='Chef')

		CREATE TABLE Chef(
			chef_id INT PRIMARY KEY ,
			chef_name VARCHAR(100),
			contact_number VARCHAR(20),
		);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='DispatchWorker')

		CREATE TABLE DispatchWorker(
			dispatch_worker_id INT PRIMARY KEY ,
			dispatch_worker_name VARCHAR(100),
			contact_number VARCHAR(20),
		);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='CafeManager')

		CREATE TABLE CafeManager(
			cafe_manager_id INT PRIMARY KEY ,
			cafe_manager_name VARCHAR(100),
			contact_number VARCHAR(20),
		);
		

	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='DeliveryDetails')

		CREATE TABLE DeliveryDetails(
			delivery_id INT NOT NULL PRIMARY KEY,
			order_id INT,
			delivery_address TEXT,
			delivery_time DATETIME,
			FOREIGN KEY (order_id) REFERENCES Orders(order_id)
			);
	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='ShoppingCart')

		CREATE TABLE ShoppingCart (
			cart_id INT PRIMARY KEY IDENTITY(1,1),
			member_id INT,
			total_cost DECIMAL(10,2) DEFAULT 0,
			FOREIGN KEY (member_id) REFERENCES Members(member_id)
			);
	IF NOT EXISTS(SELECT 1 
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_TYPE='BASE TABLE' 
			AND TABLE_NAME='CartDetails')

		CREATE TABLE CartDetails (
		    cart_detail_id INT PRIMARY KEY IDENTITY(1,1),
		    cart_id INT,
		    item_id INT,
		    quantity INT DEFAULT 1,
		    FOREIGN KEY (cart_id) REFERENCES ShoppingCart(cart_id),
		    FOREIGN KEY (item_id) REFERENCES FoodItems(item_id)
			);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='CookingRequest')

		CREATE TABLE CookingRequest (
			meal_request_id INT PRIMARY KEY ,
			order_remark NVARCHAR(255),
			order_detail_id INT FOREIGN KEY REFERENCES OrderDetails(order_detail_id),
			request_id INT,
			request_date_time DATETIME DEFAULT GETDATE(),
			);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='Feedback')

		CREATE TABLE Feedback (
			Feedback_id INT PRIMARY KEY ,
			Feedback_remark NVARCHAR(MAX),
			order_detail_id INT FOREIGN KEY REFERENCES OrderDetails(order_detail_id),
			Feedback_date_time DATETIME DEFAULT GETDATE(),
			member_id INT,
			rating INT
		);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='PlannedMeals')

		CREATE TABLE PlannedMeals (
			planned_meal_id INT PRIMARY KEY ,
			item_id INT,
			planned_date DATE,
			planned_time TIME,
			FOREIGN KEY(item_id) REFERENCES FoodItems(item_id)
		);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='PreparingMeals')

		CREATE TABLE PreparingMeals (
			preparing_meal_id INT PRIMARY KEY ,
			item_id INT,
			preparing_date DATE,
			preparing_time TIME,
			FOREIGN KEY(item_id) REFERENCES FoodItems(item_id)
		);

	IF	NOT	EXISTS(SELECT 1
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE= 'BASE TABLE'
			AND TABLE_NAME='DelayedMeals')

		CREATE TABLE DelayedMeals(
			Delayed_meal_id INT PRIMARY KEY ,
			item_id INT,
			Delayed_date DATE,
			Delayed_time TIME,
			Delayed_reason VARCHAR(255),
			FOREIGN KEY(item_id) REFERENCES FoodItems(item_id)
		);

USE DBMS_G10;
GO