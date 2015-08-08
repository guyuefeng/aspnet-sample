<%@ WebHandler Language="C#" Class="JsonData" %>

using System;
using System.Web;
using System.Data;

public class JsonData : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";

        int pageindex;
        int.TryParse(context.Request["p"], out pageindex);

        string order = "orderid desc";
        if (!string.IsNullOrEmpty(context.Request["orderby"]))
        {
            string[] strarr = context.Request["orderby"].ToString().Split('_');
            if (strarr[1] == "0")
                order = strarr[0] + " asc";
            else
                order = strarr[0] + " desc";

        }

        if (pageindex == 0)
            pageindex = 1;

        DataTable dt = Northwind.GetOrders(pageindex, order);
        string jsonData = JsonHelper.DataTableToJSON(dt, "Products");
        context.Response.Write(jsonData);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}