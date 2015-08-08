using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GetJson_JsonData : System.Web.UI.Page
{
    protected string pagecount;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            pagecount = Northwind.GetPageCount("orders");
    }
}
