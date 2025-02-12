-- Security management - permissions

-- seller: Jan Kowalski - assigned login: jankowal
-- supplier: Anna Nowak - assigned login: annnowak
-- contractor: Michał Wiśniewski - assigned login: micwisni
-- socialmediaspecialist: Katarzyna Dąbrowska - assigned login: katdabro
-- manager (db_datareader): Tomasz Lewandowski - assigned login: tomlewan

USE ConferenceCenterDB;
GO

-- create roles
CREATE ROLE seller;
CREATE ROLE supplier;
CREATE ROLE contractor;
CREATE ROLE socialmediaspecialist;

-- create logins
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

-- create users
CREATE USER jankowal FOR LOGIN jankowal;
CREATE USER annnowak FOR LOGIN annnowak;
CREATE USER micwisni FOR LOGIN micwisni;
CREATE USER katdabro FOR LOGIN katdabro;
CREATE USER tomlewan FOR LOGIN tomlewan;

-- default schema for each user
ALTER USER jankowal WITH DEFAULT_SCHEMA = Reservations;
ALTER USER annnowak WITH DEFAULT_SCHEMA = Inventory;
ALTER USER micwisni WITH DEFAULT_SCHEMA = Orders;
ALTER USER katdabro WITH DEFAULT_SCHEMA = Feedback;
ALTER USER tomlewan WITH DEFAULT_SCHEMA = db_datareader;

-- matching roles and users
ALTER ROLE seller ADD MEMBER jankowal;
ALTER ROLE supplier ADD MEMBER annnowak;
ALTER ROLE contractor ADD MEMBER micwisni;
ALTER ROLE socialmediaspecialist ADD MEMBER katdabro;
ALTER ROLE db_datareader ADD MEMBER tomlewan;

-- permissions
-- seller (jankowal): Reservations and Events Schemas
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Reservations TO seller;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Events TO seller;

-- supplier (annnowak): Inventory and Orders Schemas
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Inventory TO supplier;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Orders TO supplier;

-- contractor (micwisni): Orders Schema
GRANT SELECT, UPDATE ON SCHEMA::Orders TO contractor;

-- socialmediaspecialist (katdabro): Reviews Schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Feedback TO socialmediaspecialist;


-- tests
-- impersonation
SELECT SUSER_NAME();

EXECUTE AS LOGIN = 'tomlewan';
SELECT USER_NAME(), SUSER_NAME();
REVERT;

EXECUTE AS USER = 'tomlewan';
SELECT USER_NAME(), SUSER_SNAME();
SELECT * FROM Reservations.Customers;
REVERT;

-- system views
-- server level
USE master;
GO

-- contains a row for every server-level principal
SELECT * FROM sys.server_principals;

-- returns one row for each member of each server role
SELECT * FROM sys.server_role_members;

-- returns one row for each server-level permission
SELECT * FROM sys.server_permissions;


-- database level
USE ConferenceCenterDB;
GO

-- returns a row for each security principal in a database
SELECT * FROM sys.database_principals;

-- returns one row for each member of each database role
SELECT * FROM sys.database_role_members;

-- returns a row for every permission or column-exception permission in the database
SELECT * FROM sys.database_permissions;

SELECT * FROM sys.database_role_members WHERE member_principal_id = 10;         -- jankowal
SELECT * FROM sys.database_permissions WHERE grantee_principal_id IN (0, 10);   -- 0 for role 'public'


-- check permissions for admin
SELECT * FROM fn_my_permissions(NULL, 'SERVER');
SELECT * FROM fn_my_permissions('Reservations.Customers', 'OBJECT');

-- check permissions for database user
EXECUTE AS USER = 'katdabro';
SELECT * FROM fn_my_permissions('Reservations.Customers', 'OBJECT');
REVERT;

-- shows only those tables to which the user has access
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


-- audits