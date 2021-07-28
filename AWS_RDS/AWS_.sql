/**Script for AWS database  creation **/
CREATE database aws_northwind;
USE aws_northwind;

CREATE TABLE DimDate (
  CurrentDate date NOT NULL,
  EuropeanDate CHAR(10),
  AmericanDate CHAR(10),
  NumberDay TINYINT,
  NumberDayOfWeek TINYINT, 
  TitleOfDay VARCHAR(15),    
  NumberDayOfYear SMALLINT,
  NumberWeekInYear TINYINT,
  NumberWeekInMonth TINYINT,
  NumberMonth TINYINT,
  NameMonth VARCHAR(15),
  NumberQuarter TINYINT,
  CurrentYear SMALLINT,
  
  CONSTRAINT PK_SK_CTD PRIMARY KEY(CurrentDate)
  );
  
  
CREATE TABLE DimProduct(
	SKProduct int AUTO_INCREMENT NOT NULL,
    ProductID int NOT NULL,
	ProductName varchar(40) NOT NULL,
	QuantityPerUnit varchar(20) NULL,
	UnitPrice decimal(6,2) NULL,
	ReorderLevel smallint NULL,
    CategoryName varchar(15) NOT NULL,
    CategoryDescription text NULL,
    Datefrom datetime NOT NULL,
    DateTo datetime NULL,
    
	CONSTRAINT PK_SK_PRD PRIMARY KEY(SKProduct)
    );
    
CREATE TABLE DimShipper(
    SKShipper int AUTO_INCREMENT NOT NULL,
    ShipperID int NOT NULL,
	CompanyName varchar(40) NOT NULL,
	Phone varchar(24) NULL,
    DateFrom datetime NOT NULL,
    DateTo datetime NULL,
    CONSTRAINT PK_SK_SHP PRIMARY KEY(SKShipper)
    );
    
CREATE TABLE DimSupplier(
    SKSupplier int AUTO_INCREMENT NOT NULL,
	SupplierID int NOT NULL,
	CompanyName varchar(40) NOT NULL,
	ContactName varchar(30) NULL,
	ContactTitle varchar(30) NULL,
	Address varchar(60) NULL,
	City varchar(15) NULL,
	Region varchar(15) NULL,
	Country varchar(15) NULL,
    DateFrom datetime NOT NULL,
    DateTo datetime NULL,
    
    CONSTRAINT PK_SK_PRD PRIMARY KEY(SKSupplier)
);

CREATE TABLE DimCustomer(
    SKCustomer int AUTO_INCREMENT NOT NULL,
    CustomerID char(5) NOT NULL,
	CompanyName varchar(40) NOT NULL,
	ContactName varchar(30) NULL,
	ContactTitle varchar(30) NULL,
	Address varchar(60) NULL,
	City varchar(15) NULL,
	Region varchar(15) NULL,
	Country varchar(15) NULL,
	DateFrom datetime NOT NULL,
    DateTo datetime NULL,
    
    CONSTRAINT PK_SK_CST PRIMARY KEY(SKCustomer)
);

CREATE TABLE DimEmployee(
    EmployeeID int NOT NULL,
	LastName varchar(20) NOT NULL,
	FirstName varchar(10) NOT NULL,
	Title varchar(30) NULL,
	TitleOfCourtesy varchar(25) NULL,
	Address varchar(60) NULL,
	City varchar(15) NULL,
	Region varchar(15) NULL,
	Country varchar(15) NULL,
	Extensions varchar(4) NULL,

    
    CONSTRAINT PK_EMP_ID PRIMARY KEY(EmployeeID)
    );
    
    
CREATE TABLE FactOrder(
    OrderID int NOT NULL,
    SKCustomer int NOT NULL,
    SKSupplier int NOT NULL,
    SKShipper int not NULL,
    SKProduct int NOT NULL,
	EmployeeID int not NULL,
    OrderDate date NOT NULL,
    RequireDate date NOT NULL,
    ShipperDate date NOT NULL,
    Freight decimal(8,2) NULL ,
    ShipName varchar(40) NULL,
    ShipAddress varchar(60) NULL,
    ShipCity varchar(15) NULL,
    ShipRegion varchar(15) NULL,
    ShipCountry varchar(15) NULL,
    ActualPrice decimal(8,2) NULL,
    Quantity smallint NOT NULL,
    Discount real NOT NULL,
    
    CONSTRAINT PK_ORD_ID PRIMARY KEY(OrderID,SKCustomer,SKSupplier,SKShipper,SKProduct,EmployeeID,OrderDate,RequireDate,ShipperDate),
    CONSTRAINT FK_CST_ID FOREIGN KEY(SKCustomer) REFERENCES DimCustomer(SKCustomer),
    CONSTRAINT FK_SUP_ID FOREIGN KEY(SKSupplier) REFERENCES DimSupplier(SKSupplier),
    CONSTRAINT FK_SHP_ID FOREIGN KEY(SKShipper) REFERENCES DimShipper(SKShipper),
    CONSTRAINT FK_PRD_ID FOREIGN KEY(SKProduct) REFERENCES DimProduct(SKProduct),
    CONSTRAINT FK_EMP_ID FOREIGN KEY(EmployeeID) REFERENCES DimEmployee(EmployeeID),
    CONSTRAINT FK_ORT_ID FOREIGN KEY(OrderDate) REFERENCES DimDate(CurrentDate),
    CONSTRAINT FK_REQ_ID FOREIGN KEY(RequireDate) REFERENCES DimDate(CurrentDate),
    CONSTRAINT FK_SHD_ID FOREIGN KEY(ShipperDate) REFERENCES DimDate(CurrentDate)
    );
    
    
    drop database aws_northwind;



select * from DimSupplier;

select * from DimProduct;

select * from DimEmployee;

select * from FactOrder;

