-- create database online_store2;
-- use online_store2;
DROP TABLE IF EXISTS `company`;
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
LOCK TABLES `company` WRITE;
INSERT INTO `company` VALUES (201,'Anvi','Jamkhande','anvijamkhande@gmail.com','7020862131','12345678'),(202,'Krishnam','Omar','krishnam20309@iiitd.ac.in','9205458676','krishnam!309'),(203,'Sanjay','Singh','sanjays@gmail.com','9876543210','ssingh#07'),(204,'Daksh','Sethi','sethidaksh02@gmail.com','9079676872','02oct@daksh'),(205,'Nakshatra','Yadav','yadavnk@gmail.com','6367918004','nick@05june'),(206,'Dhroovi','Poswal','dhrooviposwal@gmail.com','7021145249','apr29dh@05'),(207,'Madhvendra','Shaktawat','madhavsingh@gmail.com','9116849560','mahavjln@2001'),(208,'Suryakant','Rawat','srawat1961@gmail.com','9784647931','gaurav@2000'),(209,'Devesh','Mishra','deveshmanit@gmail.com','8004473290','devesh@ayodhya'),(210,'Jaya','Rawat','jaya1996@gmail.com','9785344167','rawatj@20'),(211,'Harsh','Raj','harshgaya@rediffmail.com','9876543211','harsh@bitm2001'),(212,'Himanshi','Fagna','fagnahimanshi@yahoomail.com','9930844798','himanshi@2005'),(213,'Harshit','R','raviharshit@gmail.com','9448722521','araviharshit@02'),(214,'Palak','Jain','jainpalakksg@gmail.com','9462270427','palakllb@muj'),(215,'Bajrang','Sharma','bsharmamayoor@gmail.com','9829110069','sharma@bajrangajmer'),(216,'Prachi','Chouhan','prachi2001@gmail.com','9928905860','prachi@geetanjali'),(217,'Krishandev',NULL,'kdevajmer@gmail.com','9664030892','devajmer@raj'),(218,'Ghisalal','Rawat','rawat1935@gmail.com','9782522343','gl@rawatdausa'),(219,'Madhav','Vyas','madhav20310@iiitd.ac.in','9625793053','vyasiiitd@madhav'),(220,'Ruchir','Agarwal','ruchir2607iitb@gmail.com','9434376643','agarwaliitb@2001'),(221,'Prateek','Apurva','prateekiiitn@gmail.com','8306573385','papurvaajmer@cse'),(222,'Shubham','Gautam','shubhamudce@gmail.com','9950746862','gautam@2002'),(223,'Prashant','Ramnani','prashant@iitkgp.ac.in','8443454531','ramnani@csekgp'),(224,'Mimansa','Bharadwaj','mimansamayoor@gmail.com','9214444174','art@bharadwaj'),(225,'Dharam','Pratap','dpratap@bitsp.ac.in','7343434342','dharam@1basketball'),(226,'Ojasva','Singh','osingh@gmail.com','7838067886','singh@iiitd1'),(227,'Kairvee','Rastogi','rastogikairvee@gmail.com','9732423442','rastogi@2002'),(228,'Yash','Rariya','yashcuraj@gmail.com','9660011878','rariyabjp@ajmer'),(229,'Shubham','Singh','bitmshubham@gmail.com','9105862131','shubham@kota2001'),(230,'Rajendra','Singh','rajendrakanha@gmail.com','9878945793','kanha@ajmer1');
UNLOCK TABLES;
-- ------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS `select`;
-- CREATE TABLE `select` (
--   `Company_ID` int NOT NULL,
--   `Category_ID` int NOT NULL,
--   PRIMARY KEY (`Company_ID`,`Category_ID`),
--   KEY `select_category_Category_ID_fk` (`Category_ID`),
--   CONSTRAINT `select_category_Category_ID_fk` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`) ON DELETE CASCADE,
--   CONSTRAINT `select_company_Company_ID_fk` FOREIGN KEY (`Company_ID`) REFERENCES `company` (`Company_ID`) ON DELETE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- -------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) DEFAULT NULL,
  `Admin_Password` varchar(20) NOT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `admin` WRITE;
INSERT INTO `admin` VALUES (1,'Anvi','Jamkhande','12345678'),(2,'Manas','Jorvekar','manasj@294'),(3,'Pritish','Poswal','pposwal@321'),(4,'Aarya','Agarwal','vibhorag@349');
UNLOCK TABLES;
-- ------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `Cart_ID` int NOT NULL AUTO_INCREMENT,
  `Total_Value` int DEFAULT NULL,
  `Total_Count` int DEFAULT NULL,
  `Final_Amount` int NOT NULL,
  PRIMARY KEY (`Cart_ID`),
  KEY `totalcount` (`Total_Count`),
  KEY `finalvalue` (`Final_Amount`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `cart` WRITE;
INSERT INTO `cart` VALUES (1,230,3,130),(2,254,5,134),(3,954,10,954),(4,655,1,655);
UNLOCK TABLES;
-- ----------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `orders`;
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

LOCK TABLES `orders` WRITE;
INSERT INTO `orders` VALUES (1,'COD',130,'Delhi','Delhi','10:00:00','304','110020',1,'20-03-2022'),(2,'UPI',134,'Delhi','Delhi','11:05:00','100','110001',2,'25-03-2022'),(3,'Card',954,'Noida','UP','09:05:00','200','201301',3,'28-03-2022'),(4,'Netbanking',655,'Gurgaon','Haryana','14:30:00','300','122011',4,'31-03-2022');
UNLOCK TABLES;
-- ----------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category` WRITE;
INSERT INTO `category` VALUES (1,'Pots & Vases'),(2,'Warli paintings'),(3,'Diyas & Lanterns'),(4,'Knitted Items'),(5,'Crochet'),(6,'Clay Idols'),(7,'Scluptures'),(8,'Hand loom work'),(9,'Wool Scarfs'),(10,'Silk Sarees'),(11,'Bamboo Baskets'),(12,'Lanterns'),(13,'Accessories'),(14,'Jewllery'),(15,'3D Art');
UNLOCK TABLES;
-- ----------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `Product_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(35) NOT NULL,
  `Price` int NOT NULL,
  `Admin_ID` int DEFAULT NULL,
  `Category_ID` int DEFAULT NULL,
  `Description` varchar(255),
  `Artisan_name` varchar(255),
  PRIMARY KEY (`Product_ID`),
  KEY `product_admin_Admin_ID_fk` (`Admin_ID`),
  KEY `product_category_Category ID_fk` (`Category_ID`),
  KEY `priceindex` (`Price`),
  CONSTRAINT `product_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE SET NULL,
  CONSTRAINT `product_category_Category ID_fk` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `product` WRITE;
INSERT INTO `product` VALUES (1, "Ceramic pots", 500, 1, 1, "12x5in, Flower Pot, Blue/Red colours", 'Anvi Jamkhande'),
(2, "Hand-Painted Silk Saree", 2500, 1, 10, "Hand-painted, Pure Silk, Floral design", 'Ritika Sharma'),
(3, "Wooden Elephant Statue", 1200, 1, 6, "Hand-carved, Teak Wood, Intricate design", 'Karadminan Singh'),
(4, "Madhubani Painting", 800, 1, 2, "Traditional, Handmade, Natural colors", 'Priya Devi'),
(5, "Terracotta Jewelry Set", 1500, 1, 14, "Handcrafted, Eco-friendly, Necklace & Earrings", 'Manoj Kumar'),
(6, "Rajasthani Wall Hanging", 1800, 1, 1, "Handmade, Patchwork, Vibrant Colors", 'Anita Joshi'),
(7, "Brass Oil Lamp", 900, 1, 3, "Traditional, Antique finish, Religious", 'Rakesh Sharma'),
(8, "Kalamkari Cotton Fabric", 600, 1, 8, "Hand-painted, 100% Cotton, Natural Dyes", 'Aruna Reddy'),
(9, "Bamboo Handbag", 2000, 1, 11, "Handwoven, Eco-friendly, Stylish design", 'Vikram Singh'),
(10, "Phulkari Dupatta", 1800, 1, 9, "Embroidered, Georgette fabric, Traditional", 'Kavita Kaur'),
(11, "Clay Tea Set", 1200, 1, 7, "Handcrafted, Set of 6 cups and teapot", 'Suman Verma'),
(12, "Pattachitra Art", 1500, 1, 15, "Scroll painting, Mythological themes", 'Nitin Patel'),
(13, "Banarasi Silk Stole", 1000, 1, 10, "Woven, Intricate designs, Premium Silk", 'Sadhana Mishra'),
(14, "Warli Wall Clock", 800, 1, 12, "Hand-painted, Ethnic design, Wooden base", 'Neha Shah'),
(15, "Copper Water Bottle", 1500, 1, 13, "Handmade, Ayurvedic benefits, Leak-proof", 'Rajesh Tiwari'),
(16, "Kutch Embroidery Pillow", 1200, 1, 4, "Handcrafted, Colorful threadwork", 'Veena Patel');
UNLOCK TABLES;

-- ----------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `associatedWith`;
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

LOCK TABLES `associatedwith` WRITE;
INSERT INTO `associatedWith` (`Company_ID`, `Cart_ID`, `Product_ID`) VALUES 
    (201, 1, 1), (201, 1, 16), -- Associating Company 201, Cart 1 with Products 1 and 16
    (203, 2, 3), (203, 2, 6), (203, 2, 8), (203, 2, 10), (203, 2, 20), -- Associating Company 203, Cart 2 with Products 3, 6, 8, 10, and 20
    (205, 3, 27), (205, 3, 28), (205, 3, 29), -- Associating Company 205, Cart 3 with Products 27, 28, and 29
    (211, 6, 49), (211, 6, 55)	;
UNLOCK TABLES;
-- ----------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `admin_views`;
CREATE TABLE `admin_views` (
  `Admin_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  `No_Of_Orders_Viewed` int DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Admin_ID`),
  KEY `admin_views_admin_Admin_ID_fk` (`Admin_ID`),
  CONSTRAINT `admin_views_admin_Admin_ID_fk` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`) ON DELETE CASCADE,
  CONSTRAINT `admin_views_orders_Order_ID_fk` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `admin_views` WRITE;
INSERT INTO `admin_views` VALUES (1,1,3),(1,2,3),(1,3,3),(2,4,1);
UNLOCK TABLES;
-- --------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `artisan`;
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
LOCK TABLES `artisan` WRITE;
INSERT INTO `artisan` VALUES (11,'Shyam','Jadhav','sj@gmail.com','8765432109','saverbazar@123','New Delhi',1),(12,'Anvi ','Jamkhande','anvijamkhande@gmail.com','7020862131','12345678','New Delhi',1),(13,'Xpress ','Mart','xpressm@gmail.com','8901234567','xpress@123','Mumbai',1),(14,'OneStop','Grocery','onestopgrocery@gmail.com','9999999998','onestop@one','New Delhi',1);
UNLOCK TABLES;
 -- -------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `retails`;
 CREATE TABLE `retails` (
  `Artisan_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  `No_of_Product_Sold` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`,`Artisan_ID`),
  KEY `retails_seller_Seller_ID_fk` (`Artisan_ID`),
  CONSTRAINT `retails_product_Product_ID_fk` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`) ON DELETE CASCADE,
  CONSTRAINT `retails_seller_Seller_ID_fk` FOREIGN KEY (`Artisan_ID`) REFERENCES `artisan` (`Artisan_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `retails` WRITE;
INSERT INTO `retails` VALUES (1,2,2),(2,3,1),(4,6,1),(3,8,2);
UNLOCK TABLES;
-- -----------------------------------------------------------------------------------------------------------

SELECT retails.Artisan_ID, artisan.First_Name, Artisan.Last_Name, count(product.Category_ID) AS
No_Of_Categories_Sold, SUM(retails.No_of_Product_Sold) as
Total_Products_Sold, SUM(Product.price * retails.No_of_Product_Sold) AS Total_Sales_Done,
AVG(Product.price * retails.No_of_Product_Sold) AS Average_Sale_Per_Order
FROM retails
JOIN artisan
JOIN product
WHERE retails.Artisan_ID=artisan.Artisan_ID AND product.Product_ID=retails.Product_ID
GROUP BY Artisan_ID
ORDER BY Artisan_ID;