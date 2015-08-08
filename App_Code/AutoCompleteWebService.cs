using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

/// <summary>
///AutoCompleteWebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
[System.Web.Script.Services.ScriptService]
public class AutoCompleteWebService : System.Web.Services.WebService {

    public AutoCompleteWebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<GetRandomStringsResult> GetRandomStrings(string Value)
    {
        List<GetRandomStringsResult> result = new List<GetRandomStringsResult>();
        //Generate Random Strings
        for (int i = 97; i <= 122; i++)
        {
            result.Add(new GetRandomStringsResult(Value + i.ToString(), i.ToString()));
        }

        return result;

    }
    
}

public class GetRandomStringsResult
{

    public GetRandomStringsResult()
    {
    }
    public GetRandomStringsResult(string Name, string Value)
    {
        this.Name = Name;
        this.Value = Value;
    }
    public string Name { get; set; }
    public string Value { get; set; }


}
