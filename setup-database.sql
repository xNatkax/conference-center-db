/*
    Database Creation Script: ConferenceCenterDB
    ----------------------------------------
    This script creates the `ConferenceCenterDB` database, which is used to manage conference center operations.
    The database is a hybrid model, incorporating graph-based structures for Reservations and relational tables for Inventory, Orders, and Reviews.

    Schemas and Their Tables:
    - Reservations – manages customer reservations (Graph-based)
        - `Customers` (NODE) – stores customer details.
        - `Services` (NODE) – defines available services.
        - `Reservations` (NODE) – contains reservation information.
        - `booked` (EDGE) – links customers to their reservations.
        - `includes` (EDGE) – links reservations to services.

    - Feedback – manages customer reviews
        - `Reviews` – stores event reviews, including ratings and comments.

    - Events – tracks event execution and resource usage
        - `CompletedEvents` – logs completed events.
        - `EventMaterials` – tracks materials used for events.

    - Inventory – manages stock levels and low-stock alerts
        - `Inventory` – stores all available materials.
        - `LowStockRecords` – logs materials that require restocking.

    - Orders – handles purchase orders for materials
        - `Orders` – stores order details.
        - `OrdersDetails` – stores specific items within orders.
*/

CREATE DATABASE ConferenceCenterDB;
GO

USE ConferenceCenterDB;
GO


CREATE SCHEMA Reservations;
GO
CREATE SCHEMA Feedback;
GO
CREATE SCHEMA Events;
GO
CREATE SCHEMA Inventory;
GO
CREATE SCHEMA Orders;
GO


CREATE TABLE Reservations.Customers (
    CustomerID INT IDENTITY(1, 1) PRIMARY KEY,
    CompanyName VARCHAR(50) NOT NULL,
    TIN CHAR(10) NOT NULL,
    RegistrationDate DATETIME NOT NULL,
    ContactDetails XML,
    AdditionalInfo XML
) AS NODE;

CREATE TABLE Reservations.Services (
    ServiceID INT IDENTITY(1, 1) PRIMARY KEY,
    ServiceType VARCHAR(50) NOT NULL,
    ServiceName VARCHAR(50) NOT NULL,
    RoomCapacity INT NOT NULL,
    Equipment NVARCHAR(MAX),
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL
) AS NODE;

CREATE TABLE Reservations.Reservations (
    ReservationID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationDate DATETIME NOT NULL,
    ReservationDetails XML NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    Discount INT NOT NULL
) AS NODE;

CREATE TABLE Reservations.booked (
    EventDate DATETIME NOT NULL
) AS EDGE;

CREATE TABLE Reservations.includes (
    Quantity INT NOT NULL
) AS EDGE;

CREATE TABLE Inventory.Inventory (
    MaterialID INT IDENTITY(1, 1) PRIMARY KEY,
    MaterialName VARCHAR(100) NOT NULL,
    CurrentStock DECIMAL(10, 2) NOT NULL,
    MinimumLevel INT NOT NULL,
    Unit VARCHAR(10) NOT NULL,
    ConversionFactor INT NOT NULL,
    SuggestedOrderQuantity INT NOT NULL
);

CREATE TABLE Inventory.LowStockRecords (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    MaterialID INT NOT NULL,
    MaterialName VARCHAR(100) NOT NULL,
    DetectedDate DATETIME DEFAULT GETDATE(),
    IsProcessed BIT DEFAULT 0,
    CONSTRAINT FK_LowStockRecords_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory.Inventory(MaterialID)
);

CREATE TABLE Events.CompletedEvents (
    EventID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationID INT NOT NULL,
    EventDate DATETIME DEFAULT GETDATE(),
    Description NVARCHAR(MAX),
    CONSTRAINT FK_CompletedEvents_Reservations FOREIGN KEY (ReservationID) REFERENCES Reservations.Reservations(ReservationID)
);

CREATE TABLE Feedback.Reviews (
    ReviewID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    EventID INT NOT NULL,
    Review INT CHECK (Review BETWEEN 1 AND 5) NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_Reviews_Customers FOREIGN KEY (CustomerID) REFERENCES Reservations.Customers(CustomerID),
    CONSTRAINT FK_Reviews_CompletedEvents FOREIGN KEY (EventID) REFERENCES Events.CompletedEvents(EventID)
);

CREATE TABLE Events.EventMaterials (
    EventID INT NOT NULL,
    MaterialID INT NOT NULL,
    UsedQuantity INT NOT NULL,
    CONSTRAINT PK_EventMaterials PRIMARY KEY CLUSTERED (EventID, MaterialID),
    CONSTRAINT FK_EventMaterials_CompletedEvents FOREIGN KEY (EventID) REFERENCES Events.CompletedEvents(EventID),
    CONSTRAINT FK_EventMaterials_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory.Inventory(MaterialID)
);

CREATE TABLE Orders.Orders(
    OrderID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(20) DEFAULT 'New'
);

CREATE TABLE Orders.OrderDetails(
    OrderID INT NOT NULL,
    MaterialID INT NOT NULL,
    MaterialName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY CLUSTERED (OrderID, MaterialID),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders.Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory.Inventory(MaterialID)
);