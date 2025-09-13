USE MarsColonyDB;
GO

-- =====================================================
-- 1) Ensure the users exist
-- =====================================================

CREATE LOGIN user1 WITH PASSWORD = 'User1@123';
CREATE USER user1 FOR LOGIN user1;
GO

-- =====================================================
-- 2) Grant Permissions
-- =====================================================

GRANT CONTROL ON DATABASE::MarsColonyDB TO sa WITH GRANT OPTION;

-- b) user1: Only SELECT permissions
GRANT SELECT ON SCHEMA::dbo TO user1;
GO

-- =====================================================
-- 3) Verification
-- =====================================================

SELECT pr.principal_id, pr.name AS UserName, pr.type_desc, pe.permission_name, pe.state_desc, pe.class_desc
FROM sys.database_permissions pe
JOIN sys.database_principals pr
    ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name IN ('sa','user1');
