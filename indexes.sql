-- create indexes for tables

USE ConferenceCenterDB;
GO

SET STATISTICS IO ON;

-- stoplist
CREATE FULLTEXT STOPLIST SQLStopList;
GO
ALTER FULLTEXT STOPLIST SQLStopList
   ADD 'SQL' LANGUAGE 'English';
GO

CREATE FULLTEXT CATALOG FT_Catalog AS DEFAULT;


---

SELECT * FROM Feedback.Reviews;
EXEC sp_spaceused 'Feedback.Reviews';

CREATE UNIQUE NONCLUSTERED INDEX UX_Reviews_ReviewID ON Feedback.Reviews(ReviewID);    -- required for full-text index  
CREATE NONCLUSTERED INDEX IX_Reviews_Customer ON Feedback.Reviews (CustomerID);
CREATE NONCLUSTERED INDEX IX_Reviews_Event ON Feedback.Reviews (EventID);

CREATE FULLTEXT INDEX ON Feedback.Reviews
(
    Comment LANGUAGE 1033
)
KEY INDEX UX_Reviews_ReviewID
ON FT_Catalog
WITH STOPLIST = SQLStopList;
GO

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Feedback.Reviews', 'u');

---

SELECT * FROM Events.CompletedEvents;
EXEC sp_spaceused 'Events.CompletedEvents';

CREATE UNIQUE NONCLUSTERED INDEX UX_CompletedEvents_EventID ON Events.CompletedEvents(EventID);    -- required for full-text index
CREATE NONCLUSTERED INDEX IX_CompletedEvents_EventDate ON Events.CompletedEvents(EventDate);

CREATE FULLTEXT INDEX ON Events.CompletedEvents
(
    Description LANGUAGE 1033

)
KEY INDEX UX_CompletedEvents_EventID
ON FT_Catalog
WITH STOPLIST = SQLStopList;
GO

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Events.CompletedEvents', 'u');

--- 

SELECT * FROM Inventory.Inventory;
EXEC sp_spaceused 'Inventory.Inventory';

CREATE NONCLUSTERED INDEX IX_Inventory_StockCheck ON Inventory.Inventory(CurrentStock, MinimumLevel);

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Inventory.Inventory', 'u');

--- 

SELECT * FROM Orders.Orders;
EXEC sp_spaceused 'Orders.Orders';

CREATE NONCLUSTERED INDEX IX_Orders_OrderStatus ON Orders.Orders(OrderStatus);

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Orders.Orders', 'u');

---

SELECT * FROM Orders.OrdersDetails;
EXEC sp_spaceused 'Orders.OrdersDetails';

CREATE NONCLUSTERED INDEX IX_OrdersDetails_OrderMaterial_Quantity ON Orders.OrdersDetails(OrderID, MaterialID, Quantity);

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Orders.OrdersDetails', 'u');

---

SELECT * FROM Reservations.Services;

CREATE FULLTEXT INDEX ON Reservations.Services
(
    Equipment LANGUAGE 1033,
    Description LANGUAGE 1033
)
KEY INDEX GRAPH_UNIQUE_INDEX_F4C5AC48729C408B8BA92F73D7CA0186
ON FT_Catalog
WITH STOPLIST = SQLStopList;
GO