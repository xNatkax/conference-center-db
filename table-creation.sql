USE ConferenceCenterDB;
GO

-- graph database part (with document elements)
-- NODE: Customers, Services, Reservations
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1, 1) PRIMARY KEY,
    CompanyName VARCHAR(50) NOT NULL,
    TIN CHAR(10) NOT NULL,
    RegistrationDate DATETIME NOT NULL,
    ContactDetails XML,
    AdditionalInfo XML
) AS NODE;

CREATE TABLE Services (
    ServiceID INT IDENTITY(1, 1) PRIMARY KEY,
    ServiceType VARCHAR(50) NOT NULL,
    ServiceName VARCHAR(50) NOT NULL,
    RoomCapacity INT,
    Equipment NVARCHAR(MAX),    -- Full-text indeks
    Description NVARCHAR(MAX),  -- Full-text indeks
    Price DECIMAL(10, 2) NOT NULL
) AS NODE;

CREATE TABLE Reservations (
    ReservationID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationDate DATETIME NOT NULL,
    ReservationDetails XML,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    Discount INT NOT NULL
) AS NODE;


-- EDGE: booked, includes
CREATE TABLE booked (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    EventDate DATETIME NOT NULL
) AS EDGE;

CREATE TABLE includes (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Quantity INT NOT NULL
) AS EDGE;


-- relational database part
CREATE TABLE Inventory (
    MaterialID INT IDENTITY(1, 1) PRIMARY KEY,
    MaterialName VARCHAR(100) NOT NULL,
    CurrentStock INT NOT NULL,
    MinimumLevel INT NOT NULL,
    Unit VARCHAR(10) NOT NULL,
    ConversionFactor INT NOT NULL
);

CREATE TABLE CompletedEvents (
    EventID INT IDENTITY(1, 1) PRIMARY KEY,
    ReservationID INT NOT NULL,
    EventDate DATETIME NOT NULL DEFAULT GETDATE(),
    Description NVARCHAR(MAX),
    CONSTRAINT FK_CompletedEvents_Reservations FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    EventID INT NOT NULL,
    Review INT CHECK (Review BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),  -- Full-text indeks
    CONSTRAINT FK_Reviews_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Reviews_CompletedEvents FOREIGN KEY (EventID) REFERENCES CompletedEvents(EventID)
);

CREATE TABLE EventMaterials (
    EventMaterialID INT IDENTITY(1, 1) PRIMARY KEY,
    EventID INT NOT NULL,
    MaterialID INT NOT NULL,
    UsedQuantity INT NOT NULL,
    CONSTRAINT FK_EventMaterials_CompletedEvents FOREIGN KEY (EventID) REFERENCES CompletedEvents(EventID),
    CONSTRAINT FK_EventMaterials_Inventory FOREIGN KEY (MaterialID) REFERENCES Inventory(MaterialID)
);