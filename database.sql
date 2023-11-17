-- mine 
use ecommerceprojmine;
-- Artisans Table
CREATE TABLE Artisans (
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT,
    Product VARCHAR(50)
);

-- Location Table
CREATE TABLE Location (
    ID INT PRIMARY KEY,
    State VARCHAR(50),
    Country VARCHAR(50),
    Zipcode INT,
    FOREIGN KEY (ID) REFERENCES Artisans(ID)
);

-- Transactions Table
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Items_sold INT,
    Type VARCHAR(50),
    ID INT,
    Company_ID INT,
    Price_per_type DECIMAL(10, 2),
    Date DATE,
    FOREIGN KEY (ID) REFERENCES Artisans(ID),
    FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID)
);

-- Products Table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Type VARCHAR(50),
    ID INT,
    FOREIGN KEY (ID) REFERENCES Artisans(ID)
);

-- Company Table
CREATE TABLE Company (
    Company_ID INT PRIMARY KEY,
    Company_name VARCHAR(100),
    Location VARCHAR(255)
);

-- Items Table
CREATE TABLE Items (
    Product_ID INT,
    Item_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Price DECIMAL(10, 2),
    Item_description varchar(255),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Employee Table
CREATE TABLE Contract (
    Company_ID INT,
    ID INT,
    Item_ID INT,
    PRIMARY KEY (Company_ID, ID, Item_ID),
    FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID),
    FOREIGN KEY (ID) REFERENCES Artisans(ID),
    FOREIGN KEY (Item_ID) REFERENCES Items(Item_ID)
);
