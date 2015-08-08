<%@ WebHandler Language="C#" Class="GetCustomer" %>

using System;
using System.Web;
using System.Data;

public class GetCustomer : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";

        int pageindex;
        int.TryParse(context.Request["p"], out pageindex);

        string order = "CustomerID asc";
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

        DataTable dt = Northwind.GetCustomers(pageindex, order);
        string jsonData = JsonHelper.DataTableToJSON(dt, "Customers");
        context.Response.Write(jsonData);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}