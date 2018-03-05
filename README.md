
# SQL Server Date Parser 

![Build Status](https://ci.appveyor.com/api/projects/status/github/RedgumTechnologies/sqlserver.dateparser?branch=master&svg=true)

SQL Server CLR assembly for parsing string dates into DateTime SQL data types. This assembly is a simple wrapper around the [DateTime.Parse()](https://msdn.microsoft.com/en-us/library/system.datetime.parse(v=vs.110).aspx) and [DateTime.TryParse()](https://msdn.microsoft.com/en-us/library/system.datetime.tryparse(v=vs.110).aspx) method.

## Examples

### Parse

The Parse scalar function attempts to parse the supplied string into a valid DateTime object. If the string cannot be parsed, NULL is returned. An optional culture can be specified to provide additional culture-specific format information. If the culture is not provided, the current system culture is used.

```sql
SELECT dbo.dateTimeParse('26 Jan 2018', '')
-- returns 
-- 26/01/2018 12:00:00 AM
```

### TryParse

The TryParse scalar function attempts to parse the supplied string into a valid DateTime object and returns a boolean value that indicates whether the conversion succeeded. An optional culture can be specified to provide additional culture-specific format information. If the culture is not provided, the current system culture is used.

```sql
SELECT dbo.dateTimeTryParse('26 Jan 2018', '')
-- returns
-- True
```

### Culture Specific Parsing

To parse the text into a date using a specific culture format, pass in the required culture as the second parameter

```sql
SELECT dbo.dateTimeParse('4/9/2018', 'en-GB')
-- returns
-- 04 September 2018 12:00:00 AM
```

whereas

```sql
SELECT dbo.dateTimeParse('4/9/2018', 'en-US')
-- returns
-- 09 April 2018 12:00:00 AM
```


## Installation

Before any CLR library can be used in SQL Server, the CLR feature must be enabled. This script only needs to be run once against the SQL Database. For further information on enabling CLR in SQL Server, see [https://docs.microsoft.com/en-us/sql/relational-databases/clr-integration/clr-integration-enabling]

```sql
sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'clr enabled', 1;  
GO  
RECONFIGURE;  
GO  
```

In SQL Server 2016, by default CLR assemblies must be signed to be loaded. To get around this and allow unsigned assemblies to be loaded, the ```clr strict security option``` must be disabled.

```sql
EXEC sp_configure  'clr strict security', 0 
GO
RECONFIGURE;  
GO
```

Load the assembly (changing the path below to the location of the DLL)

```sql
-- Create the assembly and the calling function
CREATE ASSEMBLY dateTimeParser from 'D:\_git\OpenSource\SQLServer.DateTimeParser\src\SQLServer.DateTimeParser\bin\Release\SQLServer.DateParser.dll' WITH PERMISSION_SET = SAFE  
GO
```

Lastly, two functions need to be created to use the library
```sql
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
```