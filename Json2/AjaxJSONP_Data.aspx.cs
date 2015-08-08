using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Json2_AjaxJSONP_Data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string callback = Request["callback"];
        Response.Clear();
        Response.Write(callback + "({ name: \"liguofeng\", isGood: true })");
        Response.End();
    }
}
