DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Manager CASCADE;
DROP TABLE IF EXISTS Store CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Updates CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Warehouse CASCADE;
DROP TABLE IF EXISTS Supplies CASCADE;
DROP TABLE IF EXISTS Requests CASCADE;

CREATE TABLE Users (UserID INTEGER NOT NULL,
		   Password CHAR(11) NOT NULL,
		   Name CHAR(50) NOT NULL,
		   Email CHAR(50),
		   PRIMARY KEY(UserID));

CREATE TABLE Customer (UserID INTEGER NOT NULL,
		       CreditScore INTEGER,
		       Latitude DECIMAL(8,6) NOT NULL,
		       Longitude DECIMAL(9,6) NOT NULL,
		       PRIMARY KEY(UserID),
		       FOREIGN KEY (UserID) REFERENCES Users(UserID));

CREATE TABLE Manager (UserID INTEGER NOT NULL,
		      Degree CHAR(20),
		      Salary INTEGER NOT NULL,
		      PRIMARY KEY(UserID),
		      FOREIGN KEY (UserID) REFERENCES Users(UserID));

CREATE TABLE Store (StoreID INTEGER NOT NULL,
		    UserID INTEGER NOT NULL,
		    Name CHAR(30) NOT NULL,
		    Latitude DECIMAL(8,6) NOT NULL,
		    Longitude DECIMAL(9,6) NOT NULL,
		    DateEstablished DATE,
		    PRIMARY KEY(StoreID),
		    FOREIGN KEY(UserID) REFERENCES Manager(UserID));
	
CREATE TABLE Product (ProductName CHAR(30) NOT NULL,
		      StoreID INTEGER NOT NULL UNIQUE,
		      NumberOfUnits INTEGER NOT NULL,
	              PricePerUnit INTEGER NOT NULL,
		      Description CHAR(100),
		      ImageURL CHAR(30),
		      PRIMARY KEY(ProductName),
		      FOREIGN KEY(StoreID) REFERENCES Store(StoreID));

CREATE TABLE Updates (StoreID INTEGER NOT NULL,
		     ProductName CHAR(30) NOT NULL,
		     UserID INTEGER NOT NULL,
		     PRIMARY KEY(StoreID, ProductName, UserID),
		     FOREIGN KEY(ProductName) REFERENCES Product(ProductName),
		     FOREIGN KEY(StoreID) REFERENCES Product(StoreID),
		     FOREIGN KEY(UserID) REFERENCES Manager(UserID));
				
			
CREATE TABLE Orders (UserID INTEGER NOT NULL,
		     StoreID INTEGER NOT NULL,
		     ProductName CHAR(30) NOT NULL,
		     UnitsOrdered INTEGER NOT NULL,
		     OrderDate CHAR(8) NOT NULL,
		     PRIMARY KEY(StoreID, ProductName, UserID),
		     FOREIGN KEY(ProductName) REFERENCES Product(ProductName),
		     FOREIGN KEY(StoreID) REFERENCES Product(StoreID),
		     FOREIGN KEY(UserID) REFERENCES Customer(UserID));

CREATE TABLE Warehouse (WarehouseID INTEGER NOT NULL, 
		        Area INTEGER NOT NULL,
			Longitude DECIMAL(9,6) NOT NULL,
			Latitude DECIMAL(8,6) NOT NULL,
			PRIMARY KEY (WarehouseID));

CREATE TABLE Supplies (WarehouseID INTEGER NOT NULL, 
        	       StoreID INTEGER NOT NULL,
        	       ProductName CHAR(30) NOT NULL,
        	       PRIMARY KEY (WarehouseID, StoreID, ProductName),
        	       FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
        	       FOREIGN KEY (StoreID) REFERENCES Product(StoreID),
        	       FOREIGN KEY (ProductName) REFERENCES Product(ProductName));

CREATE TABLE Requests (UserID INTEGER NOT NULL,
         	       StoreID INTEGER NOT NULL,
         	       ProductName CHAR(30) NOT NULL,
         	       WarehouseID INTEGER NOT NULL,
         	       UnitsRequested INTEGER NOT NULL,
         	       PRIMARY KEY (UserID, StoreID, ProductName, WarehouseID),
         	       FOREIGN KEY (UserID) REFERENCES Manager(UserID),
         	       FOREIGN KEY (StoreID) REFERENCES Product(StoreID),
         	       FOREIGN KEY (ProductName) REFERENCES Product(ProductName),
         	       FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID));
