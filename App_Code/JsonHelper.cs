using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using System.Text;
using System.IO;

/// <summary>
///JsonHelper 的摘要说明
/// </summary>
public class JsonHelper
{
	public JsonHelper()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public static string DataTableToJSON(DataTable dt, string dtName)
    {
        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);


        //using (JsonWriter jw = new JsonWriter(sw))
        //{
        //    JsonSerializer ser = new JsonSerializer();
        //    jw.WriteStartObject();
        //    jw.WritePropertyName(dtName);
        //    jw.WriteStartArray();
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        jw.WriteStartObject();
             
        //        foreach (DataColumn dc in dt.Columns)
        //        {
        //            jw.WritePropertyName(dc.ColumnName);
        //            ser.Serialize(jw, dr[dc].ToString());
        //        }
               
        //        jw.WriteEndObject();
        //    }
        //    jw.WriteEndArray();
        //    jw.WriteEndObject();

        //    sw.Close();
        //    jw.Close();

        //}

        return sb.ToString();
    }
}
