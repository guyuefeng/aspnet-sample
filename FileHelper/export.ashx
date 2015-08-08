<%@ WebHandler Language="C#" Class="help" %>

using System;
using System.Web;
using System.Data.OleDb;
using System.Data;
using System.Data.Common;


public class help : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action  = context.Request.Form["action"];
        if (action == "export")
            Export();

            
    }
    private void Export()
    {
        //大批量导出的方法，用oledb和excel组件均太慢，采用流写入文件。
        string fileName = HttpContext.Current.Request.Form["fileName"];
        string destPath = HttpContext.Current.Server.MapPath("../export/") + fileName + ".xls";
        string temp = HttpContext.Current.Server.MapPath("../export/temp.txt");

        
        string ids ="1,2,3";
        string sql = "select title,summary,content,keywords,category_id from news_content where is_delete=0 and category_id in ("+ids+")";

        string title = string.Empty;
        string summary = string.Empty;
        string content = string.Empty;
        string keywords = string.Empty; 
        int categoryId = 0;
        string categoryName = string.Empty;
        System.Text.StringBuilder excelstr = new System.Text.StringBuilder();
        //下面是excel标题，
        excelstr.Append("<tr height=19 style='height:14.25pt'>");
        excelstr.Append("<td height=19 width=72 style='height:14.25pt;width:54pt'>标题</td>");
        excelstr.Append("<td width=72 style='width:54pt'>摘要</td>");
        excelstr.Append("<td width=72 style='width:54pt'>内容</td>");
        excelstr.Append("<td width=72 style='width:54pt'>关键字</td>");
        excelstr.Append("<td width=72 style='width:54pt'>目录</td>");
        excelstr.Append("</tr>");
        
        string conn = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;
        using (IDataReader reader = SqlHelper2.ExecuteReader(conn,CommandType.Text, sql))
        {
            while (reader.Read())
            {
                title = reader["title"].ToString();
                summary = reader["summary"].ToString();
                content = reader["content"].ToString();
                keywords = reader["keywords"].ToString();
                categoryId = int.Parse(reader["category_id"].ToString());
                categoryName = "Test";
                //这里是数据
                excelstr.Append("<tr height=19 style='height:14.25pt'>");
                excelstr.Append("<td height=19 width=72 style='height:14.25pt;width:54pt'>"+title+"</td>");
                excelstr.Append("<td width=72 style='width:54pt'>"+summary+"</td>");
                excelstr.Append("<td width=72 style='width:54pt'>"+content+"</td>");
                excelstr.Append("<td width=72 style='width:54pt'>"+keywords+"</td>");
                excelstr.Append("<td width=72 style='width:54pt'>" + categoryName + "</td>");
                excelstr.Append("</tr>");
            }
        }
        //excel的头
        string excelhead = FileHelper.FileToString(HttpContext.Current.Server.MapPath("../export/excel_head.txt"));
        //excel的尾
        string excelfoot = FileHelper.FileToString(HttpContext.Current.Server.MapPath("../export/excel_foot.txt"));
        
       //删除临时文件和目录文件，如果有
        FileHelper.DeleteFile(temp);
        FileHelper.DeleteFile(destPath);
        //创建临时文件
        FileHelper.CreateFile(temp);
        FileHelper.WriteText(temp, excelhead + excelstr.ToString() + excelfoot);
        //另存为excel文件
        System.IO.FileInfo file = new System.IO.FileInfo(temp);
        file.MoveTo(destPath);
        
        HttpContext.Current.Response.Write("{\"message\":\"success\"}");
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    /// <summary>
    /// 新闻内容类
    /// </summary>
    public class NewsContent
    {
        /// <summary>
        /// Id号
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// 新闻标题,meta title标签
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 新闻摘要,meta description标签
        /// </summary>
        public string Summary { get; set; }
        /// <summary>
        /// 新闻内容
        /// </summary>
        public string Content { get; set; }
        /// <summary>
        /// 是否显示
        /// </summary>
        public bool IsShow { get; set; }
        /// <summary>
        /// 排序号
        /// </summary>
        public int OrderBy { get; set; }
        /// <summary>
        /// 是否推荐
        /// </summary>
        public bool IsRecommend { get; set; }
        /// <summary>
        /// 是否审核
        /// </summary>
        public bool IsCheck { get; set; }
        /// <summary>
        /// 是否已经删除
        /// </summary>
        public bool IsDelete { get; set; }
        /// <summary>
        /// 是否允许评论
        /// </summary>
        public bool IsComment { get; set; }
        /// <summary>
        /// 是否成为图片新闻
        /// </summary>
        public bool IsImageNews { get; set; }
        /// <summary>
        /// 点击率
        /// </summary>
        public int ClickNumber { get; set; }
        /// <summary>
        /// 新闻来源
        /// </summary>
        public string PageFrom { get; set; }
        /// <summary>
        /// 关键字, meta keyword标签
        /// </summary>
        public string Keywords { get; set; }
        /// <summary>
        /// 作者
        /// </summary>
        public string Author { get; set; }
        /// <summary>
        /// 主题图片
        /// </summary>
        public string Image { get; set; }
        /// <summary>
        /// 图片提示
        /// </summary>
        public string Alt { get; set; }
        /// <summary>
        /// 生成html文件名称
        /// </summary>
        public string HtmlName { get; set; }
        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime? CreateDate { get; set; }
        /// <summary>
        /// 新闻目录
        /// </summary>
        public int CategoryId { get; set; }
    }

}

