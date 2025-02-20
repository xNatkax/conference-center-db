/*
    Database Security and Permissions Management Script
    ----------------------------------------
    This script manages database security by defining user roles, assigning permissions, 
    and ensuring appropriate access control for different users.

    Roles and Assigned Users:
    - seller (`Reservations`, `Events` access) → Jan Kowalski (Login: `jankowal`)
    - supplier (`Inventory`, `Orders` access) → Anna Nowak (Login: `annnowak`)
    - contractor (`Orders` access - limited) → Michał Wiśniewski (Login: `micwisni`)
    - socialmediaspecialist (`Feedback` access) → Katarzyna Dąbrowska (Login: `katdabro`)
    - manager (Read-only access - `db_datareader`) → Tomasz Lewandowski (Login: `tomlewan`)

    Security Implementation:
    - Step 1: Creates logins and database users.
    - Step 2: Assigns default schemas to users.
    - Step 3: Grants appropriate permissions for each role:
      - `seller`: Full access to `Reservations` and `Events` schemas.
      - `supplier`: Full access to `Inventory` and `Orders` schemas.
      - `contractor`: Limited access to `Orders` (only `SELECT`, `UPDATE`).
      - `socialmediaspecialist`: Full access to `Feedback` schema.
      - `manager`: Read-only access (`db_datareader` role).
*/

USE ConferenceCenterDB;
GO

-- Create roles
CREATE ROLE seller;
CREATE ROLE supplier;
CREATE ROLE contractor;
CREATE ROLE socialmediaspecialist;

-- Create logins
USE master;
GO

CREATE LOGIN [jankowal] WITH
    PASSWORD=N'TymczasoweHasloJan123' MUST_CHANGE,
    DEFAULT_DATABASE=[ConferenceCenterDB],
    CHECK_EXPIRATION=ON,
    CHECK_POLICY=ON;
GO

CREATE LOGIN [annnowak] WITH
    PASSWORD=N'TymczasoweHasloAnna123' MUST_CHANGE,
    DEFAULT_DATABASE=[ConferenceCenterDB],
    CHECK_EXPIRATION=ON,
    CHECK_POLICY=ON;
GO

CREATE LOGIN [micwisni] WITH
    PASSWORD=N'TymczasoweHasloMichal123' MUST_CHANGE,
    DEFAULT_DATABASE=[ConferenceCenterDB],
    CHECK_EXPIRATION=ON,
    CHECK_POLICY=ON;
GO

CREATE LOGIN [katdabro] WITH
    PASSWORD=N'TymczasoweHasloKasia123' MUST_CHANGE,
    DEFAULT_DATABASE=[ConferenceCenterDB],
    CHECK_EXPIRATION=ON,
    CHECK_POLICY=ON;
GO

CREATE LOGIN [tomlewan] WITH
    PASSWORD=N'TymczasoweHasloTomek123' MUST_CHANGE,
    DEFAULT_DATABASE=[ConferenceCenterDB],
    CHECK_EXPIRATION=ON,
    CHECK_POLICY=ON;
GO


USE ConferenceCenterDB;
GO

-- Create users
CREATE USER jankowal FOR LOGIN jankowal;
CREATE USER annnowak FOR LOGIN annnowak;
CREATE USER micwisni FOR LOGIN micwisni;
CREATE USER katdabro FOR LOGIN katdabro;
CREATE USER tomlewan FOR LOGIN tomlewan;

-- Default schema for each user
ALTER USER jankowal WITH DEFAULT_SCHEMA = Reservations;
ALTER USER annnowak WITH DEFAULT_SCHEMA = Inventory;
ALTER USER micwisni WITH DEFAULT_SCHEMA = Orders;
ALTER USER katdabro WITH DEFAULT_SCHEMA = Feedback;
ALTER USER tomlewan WITH DEFAULT_SCHEMA = db_datareader;

-- Matching roles and users
ALTER ROLE seller ADD MEMBER jankowal;
ALTER ROLE supplier ADD MEMBER annnowak;
ALTER ROLE contractor ADD MEMBER micwisni;
ALTER ROLE socialmediaspecialist ADD MEMBER katdabro;
ALTER ROLE db_datareader ADD MEMBER tomlewan;

-- Permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Reservations TO seller;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Events TO seller;

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Inventory TO supplier;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Orders TO supplier;

GRANT SELECT, UPDATE ON SCHEMA::Orders TO contractor;

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Feedback TO socialmediaspecialist;


------------------------------------------------------------------------------------
--                                Tests                                           --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                         System views - server level                            --
------------------------------------------------------------------------------------
USE master;
GO

-- Contains a row for every server-level principal
SELECT * FROM sys.server_principals;

-- Returns one row for each member of each server role
SELECT * FROM sys.server_role_members;

-- Returns one row for each server-level permission
SELECT * FROM sys.server_permissions;

------------------------------------------------------------------------------------
--                       System views - database level                            --
------------------------------------------------------------------------------------
USE ConferenceCenterDB;
GO

-- Returns a row for each security principal in a database
SELECT * FROM sys.database_principals;

-- Returns one row for each member of each database role
SELECT * FROM sys.database_role_members;

-- Returns a row for every permission or column-exception permission in the database
SELECT * FROM sys.database_permissions;

SELECT * FROM sys.database_role_members WHERE member_principal_id = 10;         -- jankowal
SELECT * FROM sys.database_permissions WHERE grantee_principal_id IN (0, 10);   -- 0 for role 'public'

-- Check permissions for admin
SELECT * FROM fn_my_permissions(NULL, 'SERVER');
SELECT * FROM fn_my_permissions('Reservations.Customers', 'OBJECT');

-- Check permissions for database user
EXECUTE AS USER = 'katdabro';
SELECT * FROM fn_my_permissions('Reservations.Customers', 'OBJECT');
REVERT;

-- Shows only those tables to which the user has access - impersonation
EXECUTE AS USER = 'jankowal';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM sys.tables;
REVERT;

EXECUTE AS USER = 'annnowak';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM sys.tables;
REVERT;

EXECUTE AS USER = 'micwisni';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM sys.tables;
REVERT;

EXECUTE AS USER = 'katdabro';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM sys.tables;
REVERT;

EXECUTE AS USER = 'tomlewan';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM sys.tables;
REVERT;

------------------------------------------------------------------------------------
--                                                                                --
------------------------------------------------------------------------------------