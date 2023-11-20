use online_store;

-- company table
-- customer -> company
CREATE TABLE `company` (
  `Company_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) DEFAULT NULL,
  `Email` varchar(35) NOT NULL,
  `Mobile_No` varchar(14) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`Company_ID`),
  KEY `companypassword` (`Password`)
);
select * from company;

drop table customer;
drop table product_feedback;
drop table associated_with;
drop table rates_order_delivery;
drop table selects;
DROP VIEW IF EXISTS rating_table;

-- ------------------------------------------------------------------------------------------------------
-- selects_customer_Customer_ID_fk-> select_company_Company_ID_fk
-- selects_category_Category_ID_fk->select_category_Category_ID_fk
-- select tableadmin
CREATE TABLE `select` (
  `Company_ID` int NOT NULL,
  `Category_ID` int NOT NULL,
  PRIMARY KEY (`Company_ID`,`Category_ID`),
  KEY `select_category_Category_ID_fk` (`Category_ID`),
  CONSTRAINT `select_category_Category_ID_fk` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`) ON DELETE CASCADE,
  CONSTRAINT `select_company_Company_ID_fk` FOREIGN KEY (`Company_ID`) REFERENCES `company` (`Company_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- -------------------------------------------------------------------------------------------------
-- admin table
CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) DEFAULT NULL,
  `Admin_Password` varchar(20) NOT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------------------------------------------------------------------------------------
-- associatedwith table
-- associated_with -> associatedWith
-- `associated_with_cart_Cart_ID_fk` -> `associatedWith_cart_Cart_ID_fk`
-- `Associated_With_customer_Customer_ID_fk` -> `associatedWith_customer_Customer_ID_fk`
-- `Associated_With_product_Product_ID_fk` -> `associatedWith_product_Product_ID_fk`
CREATE TABLE `associatedWith` (
  `Company_ID` int NOT NULL,
  `Cart_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  PRIMARY KEY (`Company_ID`,`Cart_ID`,`Product_ID`),
  KEY `Associated_With_cart_Cart_ID_fk` (`Cart_ID`),
  KEY `Associated_With_product_Product_ID_fk` (`Product_ID`),
  CONSTRAINT `associatedWith_cart_Cart_ID_fk` FOREIGN KEY (`Cart_ID`) REFERENCES `cart` (`Cart_ID`) ON DELETE CASCADE,
  CONSTRAINT `associatedWith_customer_Customer_ID_fk` FOREIGN KEY (`Company_ID`) REFERENCES `company` (`Company_ID`) ON DELETE CASCADE,
  CONSTRAINT `associatedWith_product_Product_ID_fk` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- drop table associated_with

-- ----------------------------------------------------------------------------------------------------
-- drop delivery_boy table
drop table delivery_boy;
-- alter foreign key in orders table
ALTER TABLE `orders` DROP FOREIGN KEY `orders_delivery_boy_Delivery_Boy_ID_fk`;
ALTER TABLE `orders` DROP INDEX `orders_delivery_boy_Delivery_Boy_ID_fk`;
ALTER TABLE `orders` DROP Delivery_Boy_ID;
-- --------------------------------------------------------------------------------------------------------
-- drop offers
drop table offer;
-- alter admin and cart
CREATE TABLE `cart` (
  `Cart_ID` int NOT NULL AUTO_INCREMENT,
  `Total_Value` int DEFAULT NULL,
  `Total_Count` int DEFAULT NULL,
  `Offer_ID` int DEFAULT NULL,
  `Final_Amount` int NOT NULL,
  PRIMARY KEY (`Cart_ID`),
  KEY `cart_offer_Offer_ID_fk` (`Offer_ID`),
  KEY `totalcount` (`Total_Count`),
  KEY `finalvalue` (`Final_Amount`),
  CONSTRAINT `cart_offer_Offer_ID_fk` FOREIGN KEY (`Offer_ID`) REFERENCES `offer` (`Offer_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE cart DROP FOREIGN KEY cart_offer_Offer_ID_fk; -- Drop the foreign key constraint

ALTER TABLE cart DROP COLUMN Offer_ID; -- Drop the column referencing Offer_ID from the cart table

-- -----------------------------------------------------------------------------------------------------------
-- product table
CREATE TABLE `product` (
  `Product_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(35) NOT NULL,
  `Price` int NOT NULL,
  `Brand` varchar(15) DEFAULT NULL,
  `Measurement` varchar(15) DEFAULT NULL,
  `Admin_ID` int DEFAULT NULL,
  `Category_ID` int DEFAULT NULL,
  `Unit` varchar(15) NOT NULL,
  PRIMARY KEY (`Product_ID`),
  KEY `product_admin_Admin_ID_fk` (`Admin_ID`),
  KEY `product_category_Category ID_fk` (`Category_ID`),
  KEY `priceindex` (`Price`),
  CONSTRAINT `product_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE SET NULL,
  CONSTRAINT `product_category_Category ID_fk` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

alter table product drop Measurement;
alter table product add Description varchar(255);


-- -------------------------------------------------------------------------------------------
-- artisan table
-- seller -> artisan
-- seller_ID ->Artisan_ID
-- change adds and sells table


-- Seller_admin_Admin_ID_fk -> artisan_admin_Admin_ID_fk
CREATE TABLE `artisan` (
  `Artisan_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) DEFAULT NULL,
  `Email` varchar(35) NOT NULL,
  `Phone_Number` varchar(15) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Place_Of_Operation` varchar(30) DEFAULT NULL,
  `Admin_ID` int DEFAULT NULL,
  PRIMARY KEY (`Artisan_ID`),
  KEY `artisan_admin_Admin_ID_fk` (`Admin_ID`),
  CONSTRAINT `artisan_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 -- drop seller table
 drop table seller;
 drop table sells;
 -- -------------------------------------------------------------------------------------------------------------------------------------
 -- sells -> retails
 -- `sells_product_Product_ID_fk`-> `retails_product_Product_ID_fk` 
 -- `sells_seller_Seller_ID_fk` -> `retails_seller_Seller_ID_fk`
 CREATE TABLE `retails` (
  `Artisan_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  `No_of_Product_Sold` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`,`Artisan_ID`),
  KEY `retails_seller_Seller_ID_fk` (`Artisan_ID`),
  CONSTRAINT `retails_product_Product_ID_fk` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`) ON DELETE CASCADE,
  CONSTRAINT `retails_seller_Seller_ID_fk` FOREIGN KEY (`Artisan_ID`) REFERENCES `artisan` (`Artisan_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
-- DROP TABLE sells

-- -----------------------------------------------------------------------------------------------------------
