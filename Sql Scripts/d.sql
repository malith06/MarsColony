USE MarsColonyDB;
GO

-- =====================================================
-- Step 1: Login as user1 (simulation)
-- =====================================================
-- In SSMS: connect using login = user1 / password = User1@123
-- Or simulate with EXECUTE AS

EXECUTE AS USER = 'user1';
GO

-- =====================================================
-- Step 2: Begin a transaction and attempt DELETE
-- =====================================================
BEGIN TRANSACTION;

    -- user1 only has SELECT permission, so this DELETE will FAIL
    DELETE FROM Colonist WHERE MarsID = 1;

-- =====================================================
-- Step 3: Rollback transaction
-- =====================================================
ROLLBACK TRANSACTION;
GO

-- =====================================================
-- Step 4: Verify data still exists
-- =====================================================
SELECT * FROM Colonist WHERE MarsID = 1;
GO

-- Revert context back to original login
REVERT;
GO
