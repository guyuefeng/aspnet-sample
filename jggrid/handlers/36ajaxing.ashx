<%@ WebHandler Language="C#" Class="_36ajaxing" %>

using System;
using System.Web;

public class _36ajaxing : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";

        string sql = "SELECT a.id, a.invdate, b.name, a.amount,a.tax,a.total,ISNULL(a.note,'abc') note FROM invheader a, clients b WHERE a.client_id=b.client_id";
        System.Data.DataTable dt = SqlHelper.ExecuteDataSet(sql).Tables[0];

        // 每页显示记录数
        int pageSize = 10;
        // 记录总数
        int rowCount = dt.Rows.Count;
        // 总页数
        int pageCount = rowCount % pageSize == 0 ? rowCount / pageSize : rowCount / pageSize + 1;

        var resultObj = new DataResult
        {
            // 总页数
            PageCount = pageCount,
            // 当前页
            PageIndex = 1,
            // 总记录数
            Total = rowCount,
            // 数据
            Data = dt
        };

        string resultJson = JsonHelper3.Serialize(resultObj);

        context.Response.Write(resultJson);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}