using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Data;

public partial class DragItemInListView_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Bind two xml data file to ListView control, actually you can change the "open" property to "0",
        // In that way, it will not display in ListView control.
        XmlDocument xmlDocument = new XmlDocument();
        using (DataTable tabListView1 = new DataTable())
        {
            tabListView1.Columns.Add("value", Type.GetType("System.String"));
            xmlDocument.Load(AppDomain.CurrentDomain.BaseDirectory + "/DragItemInListView/XmlFile/ListView1.xml");
            XmlNodeList xmlNodeList = xmlDocument.SelectNodes("root/data[@open='1']");
            foreach (XmlNode xmlNode in xmlNodeList)
            {
                DataRow dr = tabListView1.NewRow();
                dr["value"] = xmlNode.InnerText;
                tabListView1.Rows.Add(dr);
            }
            ListView1.DataSource = tabListView1;
            ListView1.DataBind();
        }

        XmlDocument xmlDocument2 = new XmlDocument();
        using (DataTable tabListView2 = new DataTable())
        {
            tabListView2.Columns.Add("value2", Type.GetType("System.String"));
            xmlDocument2.Load(AppDomain.CurrentDomain.BaseDirectory + "/DragItemInListView/XmlFile/ListView2.xml");
            XmlNodeList xmlNodeList2 = xmlDocument2.SelectNodes("root/data[@open='1']");
            foreach (XmlNode xmlNode in xmlNodeList2)
            {
                DataRow dr = tabListView2.NewRow();
                dr["value2"] = xmlNode.InnerText;
                tabListView2.Rows.Add(dr);
            }
            ListView2.DataSource = tabListView2;
            ListView2.DataBind();
        }
    }
}
