USE MASTER;
GO
IF EXISTS( SELECT 1 FROM sys.databases WHERE name='datawarehouse')
BEGIN 
    ALTER DATABASE datawarehouse SET single_user with rollback immediate;
    drop database datawarehouse;
    end;

    GO
CREATE DATABASE datawarehouse;
GO
USE datawarehouse;
GO
DROP SCHEMA IF EXISTS BRONZE;
GO

CREATE SCHEMA BRONZE;
GO
DROP SCHEMA IF EXISTS SILVER;
GO

CREATE SCHEMA SILVER;
GO
DROP SCHEMA IF EXISTS GOLD;
GO

CREATE SCHEMA GOLD;
GO


