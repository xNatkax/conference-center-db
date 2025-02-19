-- Create database for conference center
CREATE DATABASE ConferenceCenterDB;
GO

USE ConferenceCenterDB;
GO

-- Create schemas
CREATE SCHEMA Reservations;     -- includes tables: Customers, booked, Reservations, includes, Services
GO
CREATE SCHEMA Feedback;         -- includes table: Reviews
GO
CREATE SCHEMA Events;           -- includes tables: CompletedEvents, EventMaterials
GO
CREATE SCHEMA Inventory;        -- includes table: Inventory
GO
CREATE SCHEMA Orders;           -- includes tables: Orders, OrdersDetails
GO

-- Create tables
-- graph database part (with document elements)
-- NODE: Customers, Services, Reservations
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
    RoomCapacity INT,
    Equipment NVARCHAR(MAX),
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL
) AS NODE;

CREATE TABLE Reservations.Reservations (
    ReservationID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationDate DATETIME NOT NULL,
    ReservationDetails XML,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    Discount INT NOT NULL
) AS NODE;


-- EDGE: booked, includes
CREATE TABLE Reservations.booked (
    EventDate DATETIME NOT NULL
) AS EDGE;

CREATE TABLE Reservations.includes (
    Quantity INT NOT NULL
) AS EDGE;


-- relational database part
CREATE TABLE Inventory.Inventory (
    MaterialID INT IDENTITY(1, 1) PRIMARY KEY,
    MaterialName VARCHAR(100) NOT NULL,
    CurrentStock INT NOT NULL,
    MinimumLevel INT NOT NULL,
    Unit VARCHAR(10) NOT NULL,
    ConversionFactor INT NOT NULL
);

CREATE TABLE Events.CompletedEvents (
    EventID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationID INT NOT NULL,
    EventDate DATETIME NOT NULL DEFAULT GETDATE(),
    Description NVARCHAR(MAX),
    CONSTRAINT FK_CompletedEvents_Reservations FOREIGN KEY (ReservationID) REFERENCES Reservations.Reservations(ReservationID)
);

CREATE TABLE Feedback.Reviews (
    ReviewID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    EventID INT NOT NULL,
    Review INT CHECK (Review BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CONSTRAINT FK_Reviews_Customers FOREIGN KEY (CustomerID) REFERENCES Reservations.Customers(CustomerID),
    CONSTRAINT FK_Reviews_CompletedEvents FOREIGN KEY (EventID) REFERENCES Events.CompletedEvents(EventID)
);

CREATE TABLE Events.EventMaterials (
    EventMaterialID INT IDENTITY(1, 1) PRIMARY KEY,
    EventID INT NOT NULL,
    MaterialID INT NOT NULL,
    UsedQuantity INT NOT NULL,
    CONSTRAINT FK_EventMaterials_CompletedEvents FOREIGN KEY (EventID) REFERENCES Events.CompletedEvents(EventID),
    CONSTRAINT FK_EventMaterials_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory.Inventory(MaterialID)
);

CREATE TABLE Orders.Orders(
    OrderID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(20) DEFAULT 'New'
);

CREATE TABLE Orders.OrdersDetails(
    OrderDetailID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID INT NOT NULL,
    MaterialID INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders.Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory.Inventory(MaterialID)
);