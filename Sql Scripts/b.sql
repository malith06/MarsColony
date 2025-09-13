USE MarsColonyDB;
GO

-- =====================================================
-- 1) Map built-in 'sa' login to the database
-- (This assumes 'sa' login already exists at server level)
-- =====================================================
CREATE USER sa FOR LOGIN sa;
GO

-- =====================================================
-- 2) Create a new SQL Server login for user1
--    Then create a database user mapped to it
-- =====================================================
CREATE LOGIN user1 WITH PASSWORD = 'User1@123';   -- strong password
GO

CREATE USER user1 FOR LOGIN user1;
GO

-- =====================================================
-- 3) Verification: list users in current database
-- =====================================================
SELECT name AS UserName, type_desc AS UserType
FROM sys.database_principals
WHERE type IN ('S','U');
