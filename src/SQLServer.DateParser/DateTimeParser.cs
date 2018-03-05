using System;
using System.Data;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using System.Globalization;

public class DateTimeParser
{
    /// <summary>
    /// Converts the string representation of a date and time to its DateTime equivalent. If the string representation cannot be parsed, returns NULL
    /// </summary>
    /// <param name="text">The string representing a date time</param>
    /// <param name="culture">Optional. The culture to use when parsing. If not provided, the current system culture is used</param>
    /// <returns></returns>
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static SqlDateTime Parse(string text, string culture = "")
    {
        
        IFormatProvider format = null;
        CultureInfo ci;
        if (!string.IsNullOrWhiteSpace(culture))
        {
            // Will need to use a format provider based on the provided culture string
            ci = new CultureInfo(culture);
            format = ci.DateTimeFormat;
        }
        else
        {
            //Use current culture
            ci = CultureInfo.CurrentCulture;
            format = ci.DateTimeFormat;
        }

        DateTime dt;
        if (DateTime.TryParse(text, format, System.Globalization.DateTimeStyles.None, out dt))
        {
            return new SqlDateTime(dt);
        }
        else
        {
            return new SqlDateTime();
        }
    }

    /// <summary>
    /// Converts the specified string representation of a date and time to its DateTime equivalent and returns a value that indicates whether the conversion succeeded.
    /// </summary>
    /// <param name="text">The string representing a date time</param>
    /// <param name="culture">Optional. The culture to use when parsing. If not provided, the current system culture is used</param>
    /// <returns></returns>
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static SqlBoolean TryParse(string text, string culture = "")
    {
        
        IFormatProvider format = null;
        CultureInfo ci;
        if (!string.IsNullOrWhiteSpace(culture))
        {
            // Will need to use a format provider based on the provided culture string
            ci = new CultureInfo(culture);
            format = ci.DateTimeFormat;
        }
        else
        {
            //Use current culture
            ci = CultureInfo.CurrentCulture;
            format = ci.DateTimeFormat;
        }

        DateTime dt;
        if (DateTime.TryParse(text, format, DateTimeStyles.None, out dt))
        {
            return new SqlBoolean(true);
        }
        else
        {
            return new SqlBoolean(false);
        }
    }
}
