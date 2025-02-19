USE ConferenceCenterDB;
GO

/*
Disaster recovery

RPO: 1h
RTO: 3h

The database is mixed (contains transactional (OLTP) and analytical (OLAP) elements.)

FULL copy every 24h / LOG copy every day after loading data - loaded data is valid
(information about new bookings, new orders for materials used during events, 
    updates on events that have already taken place)
*/

-- base recovery model - FULL
SELECT database_id,
       name,
       recovery_model,
       recovery_model_desc
FROM sys.databases
WHERE name = 'ConferenceCenterDB';

-- full backup (every day)
DECLARE @FullBackupFileName NVARCHAR(100);
SET @FullBackupFileName = N'/var/opt/mssql/backups/ConferenceCenterDB_Full_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmm') + N'.bak';

BACKUP DATABASE ConferenceCenterDB
    TO DISK = @FullBackupFileName
    WITH NAME = 'Full Backup of ConferenceCenterDB', CHECKSUM;
GO

-- transaction log backup (every day after loading data)
DECLARE @LogBackupFileName NVARCHAR(100);
SET @LogBackupFileName = N'/var/opt/mssql/backups/ConferenceCenterDB_Log_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmm') + N'.bak';

BACKUP LOG ConferenceCenterDB
    TO DISK = @LogBackupFileName
    WITH NAME = 'Transaction Log Backup of ConferenceCenterDB';
GO

-- backup file structure
EXEC xp_dirtree '/var/opt/mssql/backups', 1, 1;

-- restore database
RESTORE DATABASE ConferenceCenterDB FROM DISK = '/var/opt/mssql/backups/ConferenceCenterDB_Full_20250217_0937.bak'
WITH MOVE 'ConferenceCenterDB' TO '/var/opt/mssql/data/CCDB.mdf',
     MOVE 'ConferenceCenterDB_log' TO '/var/opt/mssql/data/CCDB_log.ldf';


-- User Agent Jobs
USE msdb;
GO

-- Full Backup Agent Job
EXEC dbo.sp_add_job 
    @job_name = N'Daily Full ConferenceCenterDB Backup';
GO

EXEC sp_add_jobstep
    @job_name = N'Daily Full ConferenceCenterDB Backup',
    @step_name = N'Full Backup Step',
    @subsystem = N'TSQL',
    @command = N'
    DECLARE @FullBackupFileName NVARCHAR(200);
    SET @FullBackupFileName = N''/var/opt/mssql/backups/ConferenceCenterDB_Full_'' + 
                              FORMAT(GETDATE(), ''yyyyMMdd_HHmm'') + N''.bak'';

    BACKUP DATABASE ConferenceCenterDB
        TO DISK = @FullBackupFileName
        WITH NAME = ''Full Backup of ConferenceCenterDB'', CHECKSUM;
    ',
    @retry_attempts = 3,
    @retry_interval = 5;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'DailyBackup',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 000000;
GO

EXEC sp_attach_schedule
    @job_name = N'Daily Full ConferenceCenterDB Backup',
    @schedule_name = N'DailyBackup';
GO

EXEC dbo.sp_add_jobserver @job_name = N'Daily Full ConferenceCenterDB Backup';
GO

-- Log Backup Agent Job
-- procedure to generate triggers for each table in the schema
CREATE OR ALTER PROCEDURE usp_GenerateTriggersForSchema
    @SchemaName NVARCHAR(128)
AS
BEGIN
    DECLARE @TriggerName NVARCHAR(128);
    DECLARE @DropTriggerSQL NVARCHAR(MAX);
    DECLARE @CreateTriggerSQL NVARCHAR(MAX);

    DECLARE cur CURSOR FOR
    SELECT t.name AS TableName
    FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = @SchemaName;

    OPEN cur;
    FETCH NEXT FROM cur INTO @TriggerName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @DropTriggerSQL = '
        IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = ''' + 'trg_BackupLog_' + @TriggerName + ''')
        BEGIN
            EXEC sp_executesql N''DROP TRIGGER ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME('trg_BackupLog_' + @TriggerName) + ''';
        END;';

        EXEC sp_executesql @DropTriggerSQL;

        SET @CreateTriggerSQL = '
        EXEC sp_executesql N''
        CREATE TRIGGER ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME('trg_BackupLog_' + @TriggerName) + '
        ON ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TriggerName) + '
        AFTER INSERT, UPDATE, DELETE
        AS
        BEGIN
            EXEC msdb.dbo.sp_start_job N''''Transaction Log ConferenceCenterDB Backup'''';
        END;'';';

        EXEC sp_executesql @CreateTriggerSQL;

        FETCH NEXT FROM cur INTO @TriggerName;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

EXEC usp_GenerateTriggersForSchema 'Events';
EXEC usp_GenerateTriggersForSchema 'Feedback';
EXEC usp_GenerateTriggersForSchema 'Orders';
EXEC usp_GenerateTriggersForSchema 'Inventory';
EXEC usp_GenerateTriggersForSchema 'Reservations';


USE msdb;
GO

EXEC dbo.sp_add_job 
    @job_name = N'Transaction Log ConferenceCenterDB Backup';
GO

EXEC sp_add_jobstep
    @job_name = N'Transaction Log ConferenceCenterDB Backup',
    @step_name = N'Log Backup Step',
    @subsystem = N'TSQL',
    @command = N'
    DECLARE @LogBackupFileName NVARCHAR(200);
    SET @LogBackupFileName = N''/var/opt/mssql/backups/ConferenceCenterDB_Log_'' + 
                                FORMAT(GETDATE(), ''yyyyMMdd_HHmm'') + N''.bak'';

    BACKUP LOG ConferenceCenterDB
        TO DISK = @LogBackupFileName
        WITH NAME = ''Transaction Log Backup of ConferenceCenterDB'';
    ';
GO

EXEC dbo.sp_add_jobserver @job_name = N'Transaction Log ConferenceCenterDB Backup';
GO


------------------------------------------------------------------------------------
--                                Tests                                           --
------------------------------------------------------------------------------------
USE ConferenceCenterDB;
GO

-- trigger list
SELECT name FROM sys.triggers WHERE name LIKE 'trg_BackupLog_%';

/* add a new record
    after adding a new record we should see the message
    'Job 'Transaction Log ConferenceCenterDB Backup' started successfully.' */

INSERT INTO Reservations.Reservations (ReservationDate, ReservationDetails, TotalPrice, Discount)
VALUES 
(
    '2025-02-17 15:30:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Crystal Hall</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>50</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Presentation</Time>
            <Time>11:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    300, 0
);
GO

-- check if the job has been started
EXEC msdb.dbo.sp_help_job @job_name = N'Transaction Log ConferenceCenterDB Backup';

-- check if the backup file exists
EXEC xp_dirtree '/var/opt/mssql/backups', 1, 1;


------------------------------------------------------------------------------------
--                                                                                --
------------------------------------------------------------------------------------


-- database maintenance
DBCC CHECKDB('ConferenceCenterDB') WITH NO_INFOMSGS;
GO

-- emergency mode and database repair
ALTER DATABASE ConferenceCenterDB SET Emergency WITH ROLLBACK IMMEDIATE;
ALTER DATABASE ConferenceCenterDB SET SINGLE_USER;
DBCC CHECKDB('ConferenceCenterDB', REPAIR_REBUILD);

ALTER DATABASE ConferenceCenterDB SET MULTI_USER;
ALTER DATABASE ConferenceCenterDB SET ONLINE;


-- Agent Job for Maintenance
USE msdb;
GO

EXEC dbo.sp_add_job 
    @job_name = N'MaintenancePlan_ConferenceCenterDB';
GO

EXEC sp_add_jobstep         -- integrity check
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @step_name = N'Check Database Integrity',
    @subsystem = N'TSQL',
    @command = N'DBCC CHECKDB (''ConferenceCenterDB'') WITH NO_INFOMSGS;',
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 3;
GO

EXEC sp_add_jobstep         -- reorganize index (fragmentation > 15%)
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @step_name = N'Reorganize Indexes',
    @subsystem = N'TSQL',
    @command = N'
    DECLARE @SchemaName NVARCHAR(256), @TableName NVARCHAR(256), @IndexName NVARCHAR(256), @SQL NVARCHAR(MAX);

    DECLARE index_cursor CURSOR FOR 
    SELECT OBJECT_SCHEMA_NAME(i.object_id) AS SchemaName, 
           OBJECT_NAME(i.object_id) AS TableName, 
           i.name AS IndexName
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, ''LIMITED'') ips
    JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
    WHERE ips.avg_fragmentation_in_percent > 15 
          AND ips.avg_fragmentation_in_percent <= 30
          AND ips.index_id > 0;

    OPEN index_cursor;
    FETCH NEXT FROM index_cursor INTO @SchemaName, @TableName, @IndexName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = ''ALTER INDEX '' + QUOTENAME(@IndexName) + '' ON '' + QUOTENAME(@TableName) + '' REORGANIZE'';
        EXEC sp_executesql @SQL;

        FETCH NEXT FROM index_cursor INTO @TableName, @IndexName;
    END;

    CLOSE index_cursor;
    DEALLOCATE index_cursor;',
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 3;
GO

EXEC sp_add_jobstep         -- rebuild index (fragmentation > 30%)
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @step_name = N'Rebuild Indexes',
    @subsystem = N'TSQL',
    @command = N'
    DECLARE @SchemaName NVARCHAR(256), @TableName NVARCHAR(256), @IndexName NVARCHAR(256), @SQL NVARCHAR(MAX);

    DECLARE index_cursor CURSOR FOR 
    SELECT OBJECT_SCHEMA_NAME(i.object_id) AS SchemaName, 
           OBJECT_NAME(i.object_id) AS TableName, 
           i.name AS IndexName
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, ''LIMITED'') ips
    JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
    WHERE ips.avg_fragmentation_in_percent > 30
          AND ips.index_id > 0;  -- Pomijamy indeksy heap

    OPEN index_cursor;
    FETCH NEXT FROM index_cursor INTO @SchemaName, @TableName, @IndexName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = ''ALTER INDEX '' + QUOTENAME(@IndexName) + '' ON '' + QUOTENAME(@TableName) + '' REBUILD'';
        EXEC sp_executesql @SQL;

        FETCH NEXT FROM index_cursor INTO @TableName, @IndexName;
    END;

    CLOSE index_cursor;
    DEALLOCATE index_cursor;',
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 3;
GO

EXEC sp_add_jobstep         -- update statistics
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @step_name = N'Update Statistics',
    @subsystem = N'TSQL',
    @command = N'EXEC sp_MSforeachtable ''UPDATE STATISTICS ?'';',
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 3;
GO

EXEC sp_add_jobstep         -- history cleanup
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @step_name = N'History Cleanup',
    @subsystem = N'TSQL',
    @command = N'
    DECLARE @OldestDate DATETIME;
    SET @OldestDate = DATEADD(DAY, -30, GETDATE());
    EXEC msdb.dbo.sp_purge_jobhistory @oldest_date = @OldestDate;

    DELETE FROM msdb.dbo.backupset WHERE backup_start_date < DATEADD(DAY, -30, GETDATE());
    DELETE FROM msdb.dbo.restorehistory WHERE restore_date < DATEADD(DAY, -30, GETDATE());',
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 1;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'Weekly maintenance',
    @freq_type = 8,
    @freq_recurrence_factor = 1,
    @freq_interval = 1,
    @active_start_time = 030000;
GO

EXEC sp_attach_schedule
    @job_name = N'MaintenancePlan_ConferenceCenterDB',
    @schedule_name = N'Weekly maintenance';
GO

EXEC dbo.sp_add_jobserver @job_name = N'MaintenancePlan_ConferenceCenterDB';
GO



/* Audits
    data necessary for protection: data from the Reservations.Customers table 
    on all customers of the conference center */

USE master;
GO

CREATE SERVER AUDIT ConferenceCenter_Change
TO FILE (FILEPATH = '/tmp/AuditLogs/',
         MAXSIZE = 256 MB,
         MAX_ROLLOVER_FILES = 2147483647,
         RESERVE_DISK_SPACE = OFF)
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);

ALTER SERVER AUDIT ConferenceCenter_Change WITH (STATE = ON);

USE ConferenceCenterDB;
GO

-- audit specification
CREATE DATABASE AUDIT SPECIFICATION CCAudit_CustomersAccess
FOR SERVER AUDIT ConferenceCenter_Change
ADD (SELECT, INSERT, UPDATE, DELETE ON Reservations.Customers BY PUBLIC);

-- inclusion of specification
ALTER DATABASE AUDIT SPECIFICATION CCAudit_CustomersAccess
WITH (STATE = ON);


------------------------------------------------------------------------------------
--                                Tests                                           --
------------------------------------------------------------------------------------
SELECT * FROM Reservations.Customers;

SELECT * FROM Reservations.Customers 
WHERE CustomerID = 5;

EXECUTE AS USER = 'tomlewan';
SELECT USER_NAME(), SUSER_SNAME();
REVERT;

INSERT INTO Reservations.Customers (CompanyName, TIN, RegistrationDate, ContactDetails, AdditionalInfo)
VALUES 
(
    'DIOZ',
    '6112770309',
    '2022-11-06 20:41:45',
    '<ContactDetails>
        <Address>
            <Street>Fishy 7</Street>
            <PostalCode>53-656</PostalCode>
            <City>Wroc</City>
            <Country>Poland</Country>
        </Address>
        <Phone>210-101-3858</Phone>
        <Email>dioz@gmail.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>No additional info.</Notes>
        <Feedback>"No additional info."</Feedback>
    </AdditionalInfo>'
);

DELETE Reservations.Customers
WHERE CustomerID = 31;

-- check the log table
SELECT * FROM sys.fn_get_audit_file ('/tmp/AuditLogs/*', DEFAULT, DEFAULT);

------------------------------------------------------------------------------------
--                                                                                --
------------------------------------------------------------------------------------