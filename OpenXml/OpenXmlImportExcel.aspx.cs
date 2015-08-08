using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class OpenXml_OpenXmlImportExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (fCtrl.HasFile)
        {
            Stream fileStream = fCtrl.FileContent;
            new  OpenXmlExcelHelper(4).SheetToDataSet(fileStream);
        }
    }
}
