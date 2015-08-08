using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Json2_Jquery_Load : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/javascript";
        Response.Write("var txt = '测试啊'" + System.Environment.NewLine);
        Response.Write("alert(txt)" + System.Environment.NewLine);
        Response.End();
    }
}
