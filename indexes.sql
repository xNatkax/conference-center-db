/*
    Indexing and Full-Text Search Setup Script
    ----------------------------------------
    This script enhances database performance by creating necessary indexes and full-text search components.

    Components Created:
    - Standard Indexes:
      - Created on tables: `Inventory`, `LowStockRecords`, `CompletedEvents`, `EventMaterials`, `Reviews`, `Orders`, `OrderDetails`.
    - Full-Text Indexes:
      - Applied to `Reservations.Services.Equipment`, `Reservations.Services.Description`, `Events.CompletedEvents.Description` and 
        `Feedback.Reviews.Comment` to enable fast keyword-based searches.
*/

USE ConferenceCenterDB;
GO

CREATE FULLTEXT STOPLIST SQLStopList;
GO
ALTER FULLTEXT STOPLIST SQLStopList
   ADD 'SQL' LANGUAGE 'English';
GO

CREATE FULLTEXT CATALOG FT_Catalog AS DEFAULT;


--- `Reservations` schema

CREATE FULLTEXT INDEX ON Reservations.Services
(
    Equipment LANGUAGE 1033,
    Description LANGUAGE 1033
)
KEY INDEX GRAPH_UNIQUE_INDEX_F4C5AC48729C408B8BA92F73D7CA0186
ON FT_Catalog
WITH STOPLIST = SQLStopList;
GO


--- `Inventory` schema

CREATE NONCLUSTERED INDEX IX_Inventory_CurrentStock_MinLevel ON Inventory.Inventory (CurrentStock, MinimumLevel);
CREATE NONCLUSTERED INDEX IX_Inventory_MaterialID ON Inventory.Inventory (MaterialID);
CREATE NONCLUSTERED INDEX IX_Inventory_MaterialName ON Inventory.Inventory (MaterialName);
CREATE NONCLUSTERED INDEX IX_Inventory_SuggestedOrderQuantity ON Inventory.Inventory (MaterialID, SuggestedOrderQuantity);

CREATE NONCLUSTERED INDEX IX_LowStockRecords_IsProcessed ON Inventory.LowStockRecords (IsProcessed);
CREATE NONCLUSTERED INDEX IX_LowStockRecords_IsProcessed_MaterialID ON Inventory.LowStockRecords (IsProcessed, MaterialID);


--- `Events` schema

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

CREATE NONCLUSTERED INDEX IX_EventMaterials_EventID ON Events.EventMaterials(EventID);
CREATE NONCLUSTERED INDEX IX_EventMaterials_MaterialID ON Events.EventMaterials(MaterialID);
CREATE NONCLUSTERED INDEX IX_EventMaterials_UsedQuantity ON Events.EventMaterials(UsedQuantity);


--- `Feedback` schema

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


--- `Orders` schema

CREATE NONCLUSTERED INDEX IX_Orders_OrderStatus ON Orders.Orders(OrderStatus);
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_OrderStatus ON Orders.Orders(OrderDate, OrderStatus);

CREATE NONCLUSTERED INDEX IX_OrderDetails_MaterialName ON Orders.OrderDetails(MaterialName);
CREATE NONCLUSTERED INDEX IX_OrderDetails_Quantity ON Orders.OrderDetails(Quantity);


-- Returns all indexes for the selected table (eg. `Inventory.Inventory`)
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Inventory.Inventory', 'u');