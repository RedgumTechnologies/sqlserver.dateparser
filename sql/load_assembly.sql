
-- Drop existing function and library
IF EXISTS(SELECT * FROM sysobjects WHERE Name = 'dateTimeParse' AND Type = 'FS')
DROP FUNCTION dbo.dateTimeParse
GO

IF EXISTS(SELECT * FROM sysobjects WHERE Name = 'dateTimeTryParse' AND Type = 'FS')
DROP FUNCTION dbo.dateTimeTryParse
GO

DROP ASSEMBLY dateTimeParser
GO


/* 
-- Enable CLR for the SQL Server instance
-- This only needs to be run once against the SQL Database
-- More info, see https://docs.microsoft.com/en-us/sql/relational-databases/clr-integration/clr-integration-enabling

sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'clr enabled', 1;  
GO  
RECONFIGURE;  
GO  

*/

/*
-- For SQL Server 2017, need to allow unsigned assemblies

EXEC sp_configure  'clr strict security', 0 
GO
RECONFIGURE;  
GO

*/  


-- Create the assembly and the calling function
CREATE ASSEMBLY dateTimeParser from 'D:\_git\OpenSource\SQLServer.DateTimeParser\src\SQLServer.DateTimeParser\bin\Release\SQLServer.DateParser.dll' WITH PERMISSION_SET = SAFE  
GO



CREATE FUNCTION dbo.dateTimeParse(@text nvarchar(max), @culture nvarchar(10) = '')
RETURNS DATETIME  
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME dateTimeParser.DateTimeParser.Parse 
GO

CREATE FUNCTION dbo.dateTimeTryParse(@text nvarchar(max), @culture nvarchar(10) = '')
RETURNS BIT  
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME dateTimeParser.DateTimeParser.TryParse 
GO



-- Test the output to see if it works

-- Parse using system culture
SELECT dbo.dateTimeParse('28Apr2018', '')

-- Parse using  explicit UK culture
SELECT dbo.dateTimeParse('4/9/2018', 'en-GB')

-- Parse using explicit US culture
SELECT dbo.dateTimeParse('9/4/2018', 'en-US')

-- Parse, returns null
SELECT dbo.dateTimeParse('tester', '')

-- TryParse using system culture, return 1/True
SELECT dbo.dateTimeTryParse('28Apr2018', '')

-- TryParse using system culture, return 0/False
SELECT dbo.dateTimeTryParse('tester', '')