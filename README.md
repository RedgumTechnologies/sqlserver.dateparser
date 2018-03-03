
# SQL Server Date Parser 

![Build Status](https://ci.appveyor.com/api/projects/status/github/RedgumTechnologies/sqlserver.dateparser?branch=master&svg=true)

SQL Server CLR assembly for parsing string dates into DateTime SQL data types. This assembly is a simple wrapper around the [DateTime.Parse()](https://msdn.microsoft.com/en-us/library/system.datetime.parse(v=vs.110).aspx) method.

## Examples

### Parse

The Parse scalar function attempts to parse the supplied string into a valid DateTime object. If the string cannot be parsed, NULL is returned. An optional culture can be specified to provide additional culture-specific format information. If the culture is not provided, the current system culture is used.

```sql
SELECT dbo.dateParse('26 Jan 2018')
```

returns

```sql
26/01/2018 12:00:00 AM
```

### TryParse

The TryParse scalar function attempts to parse the supplied string into a valid DateTime object and returns a boolean value that indicates whether the conversion succeeded. An optional culture can be specified to provide additional culture-specific format information. If the culture is not provided, the current system culture is used.

```sql
SELECT dbo.dateTryParse('26 Jan 2018')
```

returns

```sql
True
```
