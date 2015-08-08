using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class RealTimeStock_RealTimeStock : System.Web.UI.Page
{
    private object _syncLock = new object();
    public static string IPAddress = "IP Address: 127.0.0.1";

    protected override void OnInit(EventArgs e)
    {
        this.Load += new System.EventHandler(this.Page_Load);
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (IsCallback)
        //    return;

        if (!Page.IsPostBack)
        {
            IPAddress = IPHelper.GetIPAddress(Request.ServerVariables["HTTP_VIA"],
                Request.ServerVariables["HTTP_X_FORWARDED_FOR"],
                Request.ServerVariables["REMOTE_ADDR"]);

            runjQueryCode("setIPAddress('" + IPAddress + "');");
        }
    }

    private string getjQueryCode(string jsCodetoRun)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("$(document).ready(function() {");
        sb.AppendLine(jsCodetoRun);
        sb.AppendLine(" });");
        return sb.ToString();
    }

    private void runjQueryCode(string jsCodetoRun)
    {
        ScriptManager requestSM = ScriptManager.GetCurrent(this);
        if (requestSM != null && requestSM.IsInAsyncPostBack)
        {
            ScriptManager.RegisterClientScriptBlock(this,
            typeof(Page), Guid.NewGuid().ToString(), getjQueryCode(jsCodetoRun), true);
        }
        else
        {
            ClientScript.RegisterClientScriptBlock(typeof(Page),
            Guid.NewGuid().ToString(), getjQueryCode(jsCodetoRun), true);
        }
    }
}
