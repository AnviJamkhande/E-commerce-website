use online_store;

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

-- ------------------------------------------------------------------------------------------------------
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

CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) DEFAULT NULL,
  `Admin_Password` varchar(20) NOT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------------------------------------------------------------------------------------

CREATE TABLE `admin_views` (
  `Admin_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  `No_Of_Orders_Viewed` int DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Admin_ID`),
  KEY `admin_views_admin_Admin_ID_fk` (`Admin_ID`),
  CONSTRAINT `admin_views_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE CASCADE,
  CONSTRAINT `admin_views_orders_Order_ID_fk` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------------------------

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

-- ----------------------------------------------------------------------------------------------------

CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Mode` varchar(15) DEFAULT NULL,
  `Amount` int DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `State` varchar(25) DEFAULT NULL,
  `Order_Time` varchar(20) DEFAULT NULL,
  `House_Flat_No` varchar(30) DEFAULT NULL,
  `Pincode` varchar(10) DEFAULT NULL,
  `Cart_ID` int DEFAULT NULL,
  `Date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `orders_cart_Cart_ID_fk` (`Cart_ID`),
  KEY `ordermode` (`Mode`),
  CONSTRAINT `orders_cart_Cart_ID_fk` FOREIGN KEY (`Cart_ID`) REFERENCES `cart` (`Cart_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------------------------------------------------------

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

-- -------------------------------------------------------------------------------------------

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

 -- -------------------------------------------------------------------------------------------------------------------------------------

 CREATE TABLE `retails` (
  `Artisan_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  `No_of_Product_Sold` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`,`Artisan_ID`),
  KEY `retails_seller_Seller_ID_fk` (`Artisan_ID`),
  CONSTRAINT `retails_product_Product_ID_fk` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`) ON DELETE CASCADE,
  CONSTRAINT `retails_seller_Seller_ID_fk` FOREIGN KEY (`Artisan_ID`) REFERENCES `artisan` (`Artisan_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -----------------------------------------------------------------------------------------------------------

CREATE TABLE `category` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------------------------

CREATE TABLE `product` (
  `Product_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(35) NOT NULL,
  `Price` int NOT NULL,
  `Brand` varchar(15) DEFAULT NULL,
  `Description` varchar(255),
  `Admin_ID` int DEFAULT NULL,
  `Category_ID` int DEFAULT NULL,
  `Artisan_name` varchar(255),
  PRIMARY KEY (`Product_ID`),
  KEY `product_admin_Admin_ID_fk` (`Admin_ID`),
  KEY `product_category_Category ID_fk` (`Category_ID`),
  KEY `priceindex` (`Price`),
  CONSTRAINT `product_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE SET NULL,
  CONSTRAINT `product_category_Category ID_fk` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
