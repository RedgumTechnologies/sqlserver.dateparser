using System;
using System.Data;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;

class DateParser
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static SqlDateTime Parse(string text)
    {
        DateTime dt;
        if (DateTime.TryParse(text, out dt))
        {
            return new SqlDateTime(dt);
        }
        else
        {
            return new SqlDateTime();
        }
    }

    public static SqlBoolean TryParse(string text)
    {
        DateTime dt;
        if (DateTime.TryParse(text, out dt))
        {
            return new SqlBoolean(true);
        }
        else
        {
            return new SqlBoolean(true);
        }
    }
}
