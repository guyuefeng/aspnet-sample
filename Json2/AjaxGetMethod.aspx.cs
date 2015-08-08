using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Data_AjaxGetMethod : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string param = string.Empty;
        var url = Request.Url.ToString();
        if (Request.HttpMethod == "POST")
        {
            for(int i=0; i<Request.Form.Count; i++)
            {
                param += "<br/>key:" + Request.Form.Keys[i] + ",value:" + Request.Form[i];
            }
        }
        else if (Request.HttpMethod == "GET")
        {
            for (int i = 0; i < Request.QueryString.Count; i++)
            {
                param += "<br/>key:" + Request.QueryString.Keys[i] + ",value:" + Request.QueryString[i];
            }
        }

        Response.Clear();
        Response.Write("Http Method: " + HttpContext.Current.Request.HttpMethod.ToUpper() + ", Param:" + param);
        Response.End();
        
    }
}
