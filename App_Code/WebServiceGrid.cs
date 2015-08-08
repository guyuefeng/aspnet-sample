using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
//using RaisingStudio.Data.Entities;
//using RaisingStudio.Data;
/// <summary>
///WebServiceGrid 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
[System.Web.Script.Services.ScriptService]
public class WebServiceGrid : System.Web.Services.WebService {


    //private DataContext dc = new DataContext("ApplicationServices");
    public WebServiceGrid () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

}

