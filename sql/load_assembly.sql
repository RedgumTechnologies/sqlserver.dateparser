
-- Drop existing function and library
IF EXISTS(SELECT * FROM sysobjects WHERE Name = 'dateTimeParser' AND Type = 'FS')
DROP FUNCTION dbo.dateTimeParser
GO

drop assembly dateTimeParser
go

/*
-- For SQL Server 2017, need to allow unsigned assemblies

EXEC sp_configure  'clr strict security', 0 
GO
RECONFIGURE;  
GO

*/  


-- Create the asembly and the calling function
CREATE ASSEMBLY dateTimeParser from 'D:\_git\OpenSource\SQLServer.DateTimeParser\src\SQLServer.DateTimeParser\bin\Release\SQLServer.DateTimeParser.dll' WITH PERMISSION_SET = SAFE  
GO


CREATE FUNCTION dbo.dateTimeParse(@text nvarchar(max))
RETURNS DATETIME  
EXTERNAL NAME SQLServer.DateParser.DateTimeParser.Parse 
go

CREATE FUNCTION dbo.dateTimeTryParse(@text nvarchar(max))
RETURNS DATETIME  
EXTERNAL NAME SQLServer.DateParser.DateTimeParser.TryParse 
go



-- Test the output to see if it works

-- Works
SELECT dbo.dateParse('28Apr2018')
-- Returns null
SELECT dbo.dateParse('tester')