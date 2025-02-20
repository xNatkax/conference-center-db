/*
    Database Demonstration Script
    ----------------------------------------
    This script contains sample queries, stored procedures, and triggers 
    to demonstrate the functionality of the database.
*/


USE ConferenceCenterDB;
GO

/* returns number of reservations
   for a specific conference room 
   (eg. Sapphire Suite, Crystal Hall, Skyline Room) */
SELECT COUNT(*) AS ReservationsNumber                           
FROM Reservations.Customers AS c, 
     Reservations.booked, 
     Reservations.Reservations AS r, 
     Reservations.includes, 
     Reservations.Services AS s
WHERE MATCH (c-(booked)->r-(includes)->s)
AND s.ServiceName = 'Sapphire Suite';

/* returns all reservations 
   with specific service 
   (eg. Basic Buffet, Espresso Delight) */
SELECT c.CompanyName, r.ReservationID       
FROM Reservations.Customers AS c, 
     Reservations.booked, 
     Reservations.Reservations AS r, 
     Reservations.includes, 
     Reservations.Services AS s
WHERE MATCH (c-(booked)->r-(includes)->s)
AND s.ServiceName = 'Basic Buffet';

/* returns all reservations 
   where TotalPrice for reservation > 700 */
SELECT c.CompanyName, r.ReservationID, r.TotalPrice
FROM Reservations.Customers AS c, Reservations.Reservations AS r, Reservations.booked
WHERE MATCH (c-(booked)->r)
AND r.TotalPrice > 700;

/* returns all customers 
   who have booked a conference room 
   with a capacity of more than 100 people */
SELECT c.CustomerID, c.CompanyName, r.ReservationID, s.ServiceName, s.RoomCapacity
FROM Reservations.Customers AS c, 
     Reservations.Reservations AS r, 
     Reservations.Services AS s, 
     Reservations.booked, 
     Reservations.includes
WHERE MATCH (c-(booked)->r-(includes)->s)
AND s.RoomCapacity > 100;

/* returns a list of services
   sorted by popularity */
SELECT s.ServiceName, COUNT(*) AS TotalBookings
FROM Reservations.Services AS s, Reservations.includes, Reservations.Reservations AS r
WHERE MATCH (r-(includes)->s)
GROUP BY s.ServiceName
ORDER BY TotalBookings DESC;

/* returns all services booked
   by the selected customer */
SELECT r.ReservationDate, s.ServiceName, s.Description, s.ServiceType
FROM Reservations.Reservations AS r, 
     Reservations.Services AS s, 
     Reservations.booked, 
     Reservations.includes, 
     Reservations.Customers AS c
WHERE MATCH (c-(booked)->r-(includes)->s)
AND c.CustomerID = 5;

/* returns all events that take place
   in the selected time period */
SELECT r.ReservationID, booked.EventDate
FROM Reservations.Customers AS c, Reservations.Reservations AS r, Reservations.booked
WHERE MATCH (c-(booked)->r)
AND booked.EventDate BETWEEN '2025-02-01' AND '2025-02-03';

/* return all events that take place 
   in the same day */
SELECT r.ReservationID, booked.EventDate, s.ServiceName
FROM Reservations.Customers AS c, 
     Reservations.Reservations AS r, 
     Reservations.booked, 
     Reservations.includes, 
     Reservations.Services AS s
WHERE MATCH (c-(booked)->r-(includes)->s)
AND booked.EventDate = '2025-02-01' AND s.ServiceType = 'conference room';


/*
    Stored Procedure: Reservations.usp_GetReservationHistory
    ----------------------------------------
    This procedure retrieves the reservation history from the Reservations table, 
    including customer company names. It allows filtering by date range or specific reservation ID. 
    The result can be used for reporting and exported to a CSV file manually or via an external script.

    Parameters:
    - @StartDate (DATETIME, NULL): Filters reservations from this date onward.
    - @EndDate (DATETIME, NULL): Filters reservations up to this date.
    - @ReservationID (INT, NULL): Filters by a specific reservation ID.

    Usage:
    EXEC Reservations.GetReservationHistory;
    EXEC Reservations.GetReservationHistory @StartDate = '2025-01-01', @EndDate = '2025-01-31';
    EXEC Reservations.GetReservationHistory @ReservationID = 1001;
*/

CREATE PROCEDURE Reservations.usp_GetReservationHistory
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL,
    @ReservationID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT r.ReservationID,
           c.CompanyName,
           r.ReservationDate,
           r.TotalPrice,
           r.Discount,
           r.ReservationDetails
    FROM Reservations.Reservations AS r, 
         Reservations.booked, 
         Reservations.Customers AS c
    WHERE MATCH (c-(booked)->r)
    AND 
        (@StartDate IS NULL OR r.ReservationDate >= @StartDate)
        AND (@EndDate IS NULL OR r.ReservationDate <= @EndDate)
        AND (@ReservationID IS NULL OR r.ReservationID = @ReservationID)
    ORDER BY r.ReservationDate DESC;
END;

EXEC Reservations.usp_GetReservationHistory;

EXEC Reservations.usp_GetReservationHistory 
    @StartDate = '2025-01-23', 
    @EndDate = '2025-01-31';

EXEC Reservations.usp_GetReservationHistory 
    @ReservationID = 5;


/* returns the number of participants for each event 
           the number of consumed coffee portions
           the number of consumed basic servings */
SELECT ce.EventID,
       ce.EventDate,
       TRY_CAST(SUBSTRING(ce.Description, 1, CHARINDEX(' participants', ce.Description) - 1) AS INT) AS Participants,
       TRY_CAST(SUBSTRING(ce.Description, CHARINDEX(',', ce.Description) + 2, 
                CHARINDEX(' coffee servings', ce.Description) - CHARINDEX(',', ce.Description) - 2) AS INT) AS CoffeeServings,
       TRY_CAST(SUBSTRING(ce.Description, CHARINDEX(',', ce.Description, CHARINDEX(',', ce.Description) + 1) + 2, 
                CHARINDEX(' basic servings', ce.Description) - CHARINDEX(',', ce.Description, CHARINDEX(',', ce.Description) + 1) - 2) AS INT) AS BasicServings
FROM Events.CompletedEvents ce
ORDER BY ce.EventDate DESC;


/*
    Stored Procedure: Inventory.usp_AddNewMaterial
    ----------------------------------------
    This procedure adds a new material to the inventory catalog. 
    It allows specifying the material name, initial stock level, 
    minimum required stock, unit of measurement, conversion factor 
    and the suggested quantity in the order.

    Parameters:
    - @MaterialName (VARCHAR(100), REQUIRED): The name of the material.
    - @CurrentStock (DECIMAL(10, 2), REQUIRED): The current stock quantity of the material.
    - @MinimumLevel (INT, REQUIRED): The minimum stock level before reordering.
    - @Unit (VARCHAR(10), REQUIRED): The unit of measurement (e.g., kg, pack).
    - @ConversionFactor (INT, REQUIRED): The conversion factor for unit-to-consumption calculations.
    - @SuggestedOrderQuantity (INT, REQUIRED): The suggested quantity of material in the order.

    Usage:
    EXEC Inventory.usp_AddNewMaterial 
        @MaterialName = 'Candy', 
        @CurrentStock = 300.00, 
        @MinimumLevel = 100, 
        @Unit = 'pack', 
        @ConversionFactor = 100,
        @SuggestedOrderQuantity = 50;
*/

CREATE OR ALTER PROCEDURE Inventory.usp_AddNewMaterial
    @MaterialName VARCHAR(100),
    @CurrentStock DECIMAL(10, 2),
    @MinimumLevel INT,
    @Unit VARCHAR(10),
    @ConversionFactor INT,
    @SuggestedOrderQuantity INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Inventory.Inventory (MaterialName, CurrentStock, MinimumLevel, Unit, ConversionFactor, SuggestedOrderQuantity)
    VALUES (@MaterialName, @CurrentStock, @MinimumLevel, @Unit, @ConversionFactor, @SuggestedOrderQuantity);

    PRINT 'New material added successfully.';
END;

EXEC Inventory.usp_AddNewMaterial 
    @MaterialName = 'Candy', 
    @CurrentStock = 50.00, 
    @MinimumLevel = 10, 
    @Unit = 'pack', 
    @ConversionFactor = 4,
    @SuggestedOrderQuantity = 50;


/*
    Stored Procedure: Inventory.usp_UpdateMaterial
    ----------------------------------------
    This procedure updates an existing material in the inventory catalog. 
    It allows modifying the material name, minimum stock level, unit of measurement, 
    conversion factor, and the suggested quantity in the order while keeping 
    unchanged values if NULL is provided.

    Parameters:
    - @MaterialID (INT, REQUIRED): The unique identifier of the material to update.
    - @MaterialName (VARCHAR(100), NULL): The new name of the material (optional).
    - @CurrentStock (DECIMAL(10, 2), NULL): The current quantity in stock (optional).
    - @MinimumLevel (INT, NULL): The new minimum stock level (optional).
    - @Unit (VARCHAR(10), NULL): The new unit of measurement (optional).
    - @ConversionFactor (INT, NULL): The new conversion factor (optional).
    - @SuggestedOrderQuantity (INT, NULL): The suggested quantity of material in the order.

    Usage:
    EXEC Inventory.usp_UpdateMaterial 
        @MaterialID = 1, 
        @MinimumLevel = 3;
*/

CREATE OR ALTER PROCEDURE Inventory.usp_UpdateMaterial
    @MaterialID INT,
    @MaterialName VARCHAR(100) = NULL,
    @CurrentStock DECIMAL(10, 2) = NULL,
    @MinimumLevel INT = NULL,
    @Unit VARCHAR(10) = NULL,
    @ConversionFactor INT = NULL,
    @SuggestedOrderQuantity INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Inventory.Inventory
    SET 
        MaterialName = COALESCE(@MaterialName, MaterialName),
        CurrentStock = COALESCE(@CurrentStock, CurrentStock),
        MinimumLevel = COALESCE(@MinimumLevel, MinimumLevel),
        Unit = COALESCE(@Unit, Unit),
        ConversionFactor = COALESCE(@ConversionFactor, ConversionFactor),
        SuggestedOrderQuantity = COALESCE(@SuggestedOrderQuantity, SuggestedOrderQuantity)
    WHERE MaterialID = @MaterialID;

    PRINT 'Material updated successfully.';
END;

EXEC Inventory.usp_UpdateMaterial 
    @MaterialID = 7, 
    @CurrentStock = 100.00;


/*
    Stored Procedure: Events.usp_AddCompletedEvent
    ----------------------------------------
    This procedure inserts a new completed event into the `Events.CompletedEvents` table 
    and automatically processes material usage based on the event description.

    Parameters:
    - @ReservationID (INT, REQUIRED): The reservation associated with the completed event.
    - @EventDate (DATETIME, REQUIRED): The date and time of the completed event.
    - @Description (NVARCHAR(MAX), REQUIRED): A textual description of the event, 
      which includes the number of participants, coffee servings, and basic servings.

    Functionality:
    - Inserts a new row into `Events.CompletedEvents` with the provided reservation details.
    - Retrieves the newly created `EventID`.
    - Calls `Events.usp_ProcessMaterialUsage` to automatically deduct materials from stock 
      based on the event description.

    Usage:
    EXEC Events.usp_AddCompletedEvent 
        @ReservationID = 18, 
        @EventDate = '2025-02-19 15:00:00', 
        @Description = '100 participants, 100 coffee servings, 0 basic servings';
*/

CREATE OR ALTER PROCEDURE Events.usp_AddCompletedEvent
    @ReservationID INT,
    @EventDate DATETIME,
    @Description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EventID INT;

    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Reservations.Reservations WHERE ReservationID = @ReservationID)
    BEGIN
        PRINT 'Error: The specified ReservationID does not exist.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    INSERT INTO Events.CompletedEvents (ReservationID, EventDate, Description)
    VALUES (@ReservationID, @EventDate, @Description);

    SET @EventID = SCOPE_IDENTITY();

    EXEC Events.usp_ProcessMaterialUsage @EventID, @Description;

    COMMIT TRANSACTION;

    PRINT 'Event and materials usage added successfully.';
END;


/*
    Stored Procedure: Events.usp_ProcessMaterialUsage
    ----------------------------------------
    This procedure extracts material usage details from an event's description 
    and inserts records into the `Events.EventMaterials` table.

    Parameters:
    - @EventID (INT, REQUIRED): The identifier of the completed event.
    - @Description (NVARCHAR(MAX), REQUIRED): A textual description containing 
      the number of participants, coffee servings, and basic servings.

    Functionality:
    - Parses `@Description` to extract numerical values for coffee servings and basic servings.
    - Based on extracted values, inserts corresponding entries into `Events.EventMaterials`:
      - If `coffee servings` > 0 → Inserts `MaterialID` (1, 2, 3, 4, 5, 6, 7, 8, 11, 12).
      - If `basic servings` > 0 → Inserts `MaterialID` (4, 5, 6, 7, 8, 11).
    - Ensures correct stock deductions by inserting material consumption records.
*/

CREATE OR ALTER PROCEDURE Events.usp_ProcessMaterialUsage
    @EventID INT,
    @Description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CoffeeServings INT, @CateringServings INT;

    BEGIN TRANSACTION;

    SET @CoffeeServings = TRY_CAST(
        SUBSTRING(
            @Description, 
            CHARINDEX(',', @Description) + 2, 
            CHARINDEX(' coffee servings', @Description) - CHARINDEX(',', @Description) - 2
        ) 
    AS INT);

    SET @CateringServings = TRY_CAST(
        SUBSTRING(
            @Description, 
            CHARINDEX(',', @Description, CHARINDEX(',', @Description) + 1) + 2, 
            CHARINDEX(' basic servings', @Description) - CHARINDEX(',', @Description, CHARINDEX(',', @Description) + 1) - 2
        ) 
    AS INT);

    BEGIN TRY
        IF @CoffeeServings > 0
        BEGIN
            INSERT INTO Events.EventMaterials (EventID, MaterialID, UsedQuantity)
            VALUES 
                (@EventID, 1, @CoffeeServings),
                (@EventID, 2, @CoffeeServings),
                (@EventID, 3, @CoffeeServings),
                (@EventID, 4, @CoffeeServings),
                (@EventID, 5, @CoffeeServings),
                (@EventID, 6, @CoffeeServings),
                (@EventID, 7, @CoffeeServings),
                (@EventID, 8, @CoffeeServings),
                (@EventID, 11, @CoffeeServings),
                (@EventID, 12, @CoffeeServings);
        END;

        IF @CateringServings > 0
        BEGIN
            INSERT INTO Events.EventMaterials (EventID, MaterialID, UsedQuantity)
            VALUES 
                (@EventID, 4, @CateringServings),
                (@EventID, 5, @CateringServings),
                (@EventID, 6, @CateringServings),
                (@EventID, 7, @CateringServings),
                (@EventID, 8, @CateringServings),
                (@EventID, 11, @CateringServings);
        END;

        COMMIT TRANSACTION;
        PRINT 'Materials usage added successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: Failed to add material usage.';
    END CATCH
END;


/*
    Stored Procedure: Events.usp_AddVariableMaterialUsage
    ----------------------------------------
    This procedure allows manual insertion of material usage records for 
    `MaterialID = 9` and `MaterialID = 10` in the `Events.EventMaterials` table. 
    Unlike other materials, these do not have predefined consumption rules 
    and must be specified explicitly.

    Parameters:
    - @EventID (INT, REQUIRED): The identifier of the completed event.
    - @UsedQuantity9 (INT, NULL): The quantity of `MaterialID = 9` used during the event (optional).
    - @UsedQuantity10 (INT, NULL): The quantity of `MaterialID = 10` used during the event (optional).

    Functionality:
    - Verifies if the provided `@EventID` exists in the `Events.CompletedEvents` table.
    - Inserts a record into `Events.EventMaterials` if `@UsedQuantity9` is provided and greater than 0.
    - Inserts a record into `Events.EventMaterials` if `@UsedQuantity10` is provided and greater than 0.
    - Prevents inserting values when `NULL` or `0` is passed.
    - Ensures that only valid events receive material usage records.

    Usage:
    EXEC Events.usp_AddVariableMaterialUsage 
        @EventID = 25, 
        @UsedQuantity9 = 5, 
        @UsedQuantity10 = 8;

    EXEC Events.usp_AddVariableMaterialUsage 
        @EventID = 25, 
        @UsedQuantity9 = 3;
*/

CREATE OR ALTER PROCEDURE Events.usp_AddVariableMaterialUsage
    @EventID INT,
    @UsedQuantity9 INT = NULL,
    @UsedQuantity10 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Events.CompletedEvents WHERE EventID = @EventID)
    BEGIN
        PRINT 'Error: The specified EventID does not exist.';
        RETURN;
    END;

    IF @UsedQuantity9 IS NOT NULL AND @UsedQuantity9 > 0
    BEGIN
        INSERT INTO Events.EventMaterials (EventID, MaterialID, UsedQuantity)
        VALUES (@EventID, 9, @UsedQuantity9);
    END;

    IF @UsedQuantity10 IS NOT NULL AND @UsedQuantity10 > 0
    BEGIN
        INSERT INTO Events.EventMaterials (EventID, MaterialID, UsedQuantity)
        VALUES (@EventID, 10, @UsedQuantity10);
    END;

    PRINT 'Variable material usage added successfully.';
END;

EXEC Events.usp_AddVariableMaterialUsage 
    @EventID = 17, 
    @UsedQuantity10 = 1;


/*
    Trigger: Events.trg_ReduceStockAfterEvent
    ----------------------------------------
    
    - This trigger automatically reduces inventory levels whenever a new material usage 
      record is inserted into `Events.EventMaterials`.
    - Ensures that stock levels are updated in real-time after an event is completed.

    - Reduces `CurrentStock` based on `UsedQuantity`, taking into account conversion factors:
      - If stock reduction results in a negative value, it is set to zero (preventing negative stock levels).
      - Otherwise, `CurrentStock` is reduced proportionally using `ConversionFactor`.
*/

CREATE OR ALTER TRIGGER Events.trg_ReduceStockAfterEvent
ON Events.EventMaterials
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Inventory.Inventory
    SET CurrentStock = 
        CASE 
            WHEN CurrentStock - (em.UsedQuantity * 1.0 / i.ConversionFactor) < 0 
            THEN 0
            ELSE CurrentStock - (em.UsedQuantity * 1.0 / i.ConversionFactor) 
        END
    
    FROM Inventory.Inventory i
    JOIN inserted em ON i.MaterialID = em.MaterialID;

    PRINT 'Stock updated after material usage in an event.';
END;


------------------------------------------------------------------------------------
--                                Tests                                           --
------------------------------------------------------------------------------------
-- check the current amount in inventory
SELECT * FROM Inventory.Inventory
WHERE MaterialID IN (1, 2, 3, 4, 5, 6, 7, 8, 11, 12);

-- add a new completed event (Events.CompletedEvents) and the amount of materials used (100 servings) (Events.EventMaterials)
EXEC Events.usp_AddCompletedEvent 
    @ReservationID = 18, 
    @EventDate = '2025-02-17 12:00:00', 
    @Description = '10 participants, 10 coffee servings, 0 basic servings';

-- check the current amount in inventory
SELECT * FROM Inventory.Inventory
WHERE MaterialID IN (1, 2, 3, 4, 5, 6, 7, 8, 11, 12);

------------------------------------------------------------------------------------
--                                                                                --
------------------------------------------------------------------------------------


/*
    Stored Procedure: Inventory.usp_GenerateDailyOrders
    ----------------------------------------
    This procedure generates a daily inventory replenishment order when stock levels 
    fall below the minimum threshold. It ensures that all required materials are ordered 
    in bulk at the end of the day, rather than triggering multiple individual orders.

    Functionality:
    - Checks for low stock materials in the `Inventory.LowStockRecords` table.
    - Creates a new order in `Orders.Orders` with a status of 'New'.
    - Adds all required materials to `Orders.OrdersDetails` using `SuggestedOrderQuantity` from `Inventory.Inventory`.
    - Marks materials as processed in `Inventory.LowStockRecords`, preventing duplicate orders.

    Execution Time:
    - This procedure is typically scheduled to run daily at 15:00 via SQL Server Agent.
*/  

CREATE OR ALTER PROCEDURE Inventory.usp_GenerateDailyOrders
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OrderID INT;

    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Inventory.LowStockRecords WHERE IsProcessed = 0)
    BEGIN
        PRINT 'No new low stock records found. No orders created.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    BEGIN TRY
        INSERT INTO Orders.Orders (OrderDate, OrderStatus)
        VALUES (GETDATE(), 'New');

        SET @OrderID = SCOPE_IDENTITY();

        INSERT INTO Orders.OrdersDetails (OrderID, MaterialID, MaterialName, Quantity)
        SELECT @OrderID,
                lr.MaterialID,
                lr.MaterialName,
                i.SuggestedOrderQuantity
        FROM Inventory.LowStockRecords lr
        JOIN Inventory.Inventory i ON lr.MaterialID = i.MaterialID
        WHERE lr.IsProcessed = 0;

        UPDATE Inventory.LowStockRecords
        SET IsProcessed = 1
        WHERE IsProcessed = 0;

        COMMIT TRANSACTION;
        PRINT 'Daily order successfully created at 15:00.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: Failed to generate daily orders.';
    END CATCH
END;


------------------------------------------------------------------------------------
--                           SQL Agent Job                                        --
------------------------------------------------------------------------------------
USE msdb;
GO

EXEC dbo.sp_add_job 
    @job_name = N'Daily Order Generation';
GO

EXEC sp_add_jobstep
    @job_name = N'Daily Order Generation',
    @step_name = N'Generate Daily Orders',
    @subsystem = N'TSQL',
    @command = N'EXEC Inventory.usp_GenerateDailyOrders;';
GO

EXEC sp_add_jobschedule  
    @job_name = N'Daily Order Generation',  
    @name = N'Daily at 15:00',  
    @freq_type = 4,
    @freq_interval = 1,  
    @freq_subday_type = 1, 
    @active_start_time = 150000;
GO

EXEC dbo.sp_add_jobserver @job_name = N'Daily Order Generation';
GO

------------------------------------------------------------------------------------
--                                                                                --
------------------------------------------------------------------------------------


/*
    Stored Procedure: Inventory.usp_CheckLowStock
    ----------------------------------------
    This procedure identifies materials in the inventory that have fallen below or reached
    the minimum level and require replenishment. It provides a list of low-stock materials 
    along with their current stock levels and suggested order quantities.

    Functionality:
    - Scans the `Inventory.Inventory` table to find materials where `CurrentStock <= MinimumLevel`.
    - Returns key details: 
      - `MaterialID`: Unique identifier of the material.
      - `MaterialName`: Name of the material.
      - `CurrentStock`: Current available quantity in stock.
      - `SuggestedOrderQuantity`: Recommended quantity to reorder.

    Intended Use:
    - This procedure is useful for manual stock reviews.
    - Can be executed independently for quick stock checks.

    Usage:
    EXEC Inventory.usp_CheckLowStock;
*/  

CREATE OR ALTER PROCEDURE Inventory.usp_CheckLowStock
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MaterialID, 
           MaterialName, 
           CurrentStock, 
           SuggestedOrderQuantity
    FROM Inventory.Inventory
    WHERE CurrentStock <= MinimumLevel;
END;

EXEC Inventory.usp_CheckLowStock;


/*
    Trigger: Inventory.trg_RecordLowStock
    ----------------------------------------

    - This trigger automatically detects low stock levels in the `Inventory.Inventory` table
      and logs the shortage in the `Inventory.LowStockRecords` table.
    - Ensures that materials reaching or falling below the minimum level (`MinimumLevel`)
      are recorded for automated order processing at 15:00.

    Functionality:
    - Checks the `inserted` table (which holds updated rows) for materials where:
      - `CurrentStock <= MinimumLevel`
      - The material is **not already recorded as low stock (`IsProcessed = 0` in `LowStockRecords`).
    - Inserts a new record into `LowStockRecords` with:
      - `MaterialID` and `MaterialName`
      - `DetectedDate` as the current timestamp (`GETDATE()`)
      - `IsProcessed = 0` to indicate that the material still needs ordering.
*/

CREATE OR ALTER TRIGGER Inventory.trg_RecordLowStock
ON Inventory.Inventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Inventory.LowStockRecords (MaterialID, MaterialName, DetectedDate, IsProcessed)
    SELECT 
        i.MaterialID, 
        i.MaterialName,
        GETDATE(),
        0
    FROM inserted i
    WHERE i.CurrentStock <= i.MinimumLevel
    AND NOT EXISTS (
        SELECT 1 FROM Inventory.LowStockRecords lr 
        WHERE lr.MaterialID = i.MaterialID AND lr.IsProcessed = 0
    );

    PRINT 'Low stock recorded. Order will be generated at 15:00.';
END;


/*
    Stored Procedure: Feedback.usp_AddReview
    ----------------------------------------
    This procedure allows customers to submit a review for a completed event.
    This procedure ensures that only customers who reserved an event can review it and
    prevents duplicate reviews for the same customer and event.

    Functionality:
    - Validates input**: Ensures `Review` is between 1-5 and `Comment` is not empty.
    - **Checks data integrity**:
      - Confirms that `CustomerID` exists in `Reservations.Customers`.
      - Confirms that `EventID` exists in `Events.CompletedEvents`.
      - Ensures that `CustomerID` is associated with the `EventID` via `MATCH (c-(booked)->r)`.
    - **Prevents duplicate reviews** for the same `CustomerID` and `EventID`.
    - **Uses transaction handling**:
      - If any validation fails, the transaction is rolled back, preventing partial inserts.
      - Ensures data consistency by committing only if all checks pass.

    **Error Handling:**
    - Rejects missing or invalid `Review` values.
    - Rejects empty or null `Comment` inputs.
    - Prevents customers from reviewing events they did not reserve.

    **Usage:**
    EXEC Feedback.usp_AddReview 
        @CustomerID = 5, 
        @EventID = 12, 
        @Review = 4, 
        @Comment = 'Excellent service and well-organized event!';
*/

CREATE OR ALTER PROCEDURE Feedback.usp_AddReview
    @CustomerID INT,
    @EventID INT,
    @Review INT,
    @Comment NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Review IS NULL OR @Comment IS NULL OR LTRIM(RTRIM(@Comment)) = ''
    BEGIN
        PRINT 'Error: Review score and comment are required.';
        RETURN;
    END;

    BEGIN TRANSACTION;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Reservations.Customers WHERE CustomerID = @CustomerID)
        BEGIN
            PRINT 'Error: The specified CustomerID does not exist.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        IF NOT EXISTS (SELECT 1 FROM Events.CompletedEvents WHERE EventID = @EventID)
        BEGIN
            PRINT 'Error: The specified EventID does not exist.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        IF NOT EXISTS (SELECT c.CustomerID 
                       FROM Reservations.Customers AS c, 
                            Reservations.booked, 
                            Reservations.Reservations AS r, 
                            Events.CompletedEvents AS ce
                        WHERE MATCH (c-(booked)->r) 
                        AND r.ReservationID = ce.ReservationID
                        AND c.CustomerID = @CustomerID
                        AND ce.EventID = @EventID
        )
        BEGIN
            PRINT 'Error: The customer can only review events they have reserved.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        IF EXISTS (SELECT 1 FROM Feedback.Reviews WHERE CustomerID = @CustomerID AND EventID = @EventID)
        BEGIN
            PRINT 'Error: A review already exists for this customer and event.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        IF @Review NOT BETWEEN 1 AND 5
        BEGIN
            PRINT 'Error: The review score must be between 1 and 5.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        INSERT INTO Feedback.Reviews (CustomerID, EventID, Review, Comment)
        VALUES (@CustomerID, @EventID, @Review, @Comment);

        COMMIT TRANSACTION;

        PRINT 'Review added successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: Failed to add review.';
    END CATCH;
END;

EXEC Feedback.usp_AddReview 
    @CustomerID = 1, 
    @EventID = 1, 
    @Review = 4, 
    @Comment = 'Excellent service and well-organized event!';