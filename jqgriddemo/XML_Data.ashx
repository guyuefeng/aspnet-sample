<%@ WebHandler Language="C#" Class="XML_Data" %>

using System;
using System.Web;
using System.Xml;

public class XML_Data : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/xml";
        
        Int32 page=1;
        if (!string.IsNullOrEmpty(context.Request["page"]))
         page=int.Parse(context.Request["page"]);

        Int32 rows=10;
        if (!string.IsNullOrEmpty(context.Request["rows"]))
            rows = int.Parse(context.Request["rows"]);

        string sidx;
        if (!string.IsNullOrEmpty(context.Request["sidx"]))
            sidx = context.Request["sidx"].ToString();

        string sord;
        if (!string.IsNullOrEmpty(context.Request["sord"]))
            sord = context.Request["sord"].ToString();

        Int32 count = 0;

        count = int.Parse(SqlHelper2.ExecuteScalar("SELECT COUNT(*) AS count FROM invheader a, clients b WHERE a.client_id=b.client_id").ToString());

        Int32 total_pages = 0;
        
        if( count >0 ) {
            //decimal result = count / rows;
            total_pages = count / rows + 1;
        } else {
	        total_pages = 0;
        }
        
        if (page > total_pages) 
            page=total_pages;
        
        Int32 start;
        start = rows*page - rows+1; // do not put $limit*($page - 1)

        Int32 end;
        end = rows * page;

        string sqlStr = @"SELECT  rowid id ,
                            invdate ,
                            name ,
                            amount ,
                            tax ,
                            total ,
                            note
                            FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY a.id DESC ) AS rowid ,
                                                a.id ,
                                                a.invdate ,
                                                b.name ,
                                                a.amount ,
                                                a.tax ,
                                                a.total ,
                                                a.note
                                      FROM      invheader a ,
                                                clients b
                                      WHERE     a.client_id = b.client_id
                                    ) AS Results
                            WHERE   rowid >= {0} AND rowid <= {1}";
        
        sqlStr = string.Format(sqlStr, start, end);

        System.Data.DataTable dt = SqlHelper2.ExecuteDataset(sqlStr).Tables[0];

       


        System.Text.StringBuilder sb=new System.Text.StringBuilder();
        sb.Append("<?xml version='1.0' encoding='utf-8'?>");
        sb.AppendLine("<rows>");
        sb.AppendLine(string.Format("<page>{0}</page>", page));
        sb.AppendLine(string.Format("<total>{0}</total>", total_pages));
        sb.AppendLine(string.Format("<records>{0}</records>", count));
         for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append(string.Format("<row id='{0}'>",dt.Rows[i]["id"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["id"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["invdate"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["name"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["amount"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["tax"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["total"]));
             sb.Append(string.Format("<cell>{0}</cell>",dt.Rows[i]["note"]));
             sb.AppendLine("</row>");

        }

         sb.AppendLine("</rows>");
        
        context.Response.Write(sb.ToString());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}