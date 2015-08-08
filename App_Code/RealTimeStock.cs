using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
///RealTimeStock 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
[System.Web.Script.Services.ScriptService]
public class RealTimeStock : System.Web.Services.WebService {

    public RealTimeStock () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    const string SYMBOLS = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private object _syncLock = new object();

    public string ID { get; set; }
    public string Token { get; set; }

    [WebMethod]
    public string[] Tick()
    {
        lock (_syncLock)
        {
            List<string> data = new List<string>();
            string jData = RandomDataToJson();
            data.Add(jData);
            return data.ToArray();
        }
    }


    public string RandomDataToJson()
    {
        lock (_syncLock)
        {
            char[] charArray = new char[3];
            string charPool = string.Empty;

            charPool += SYMBOLS;

            for (int i = 0; i < charArray.Length; i++)
            {
                int index = RandomNumber(0, charPool.Length);
                charArray[i] = charPool[index];
            }

            string zSymbol = new string(charArray);
            int x = RandomNumber(1, 3);

            if (x > 2)
                x = 2;
            string sDirection = "▲";
            if (x < 2)
                sDirection = "▲";
            else
                sDirection = "▼";

            try
            {
                var ret = string.Format("{{"+
                    "\"ImageID\":\"{0}\"," +
                      "\"Dir\":\"{1}\"," +
                    "\"Time\":\"{2}\"," +
                    "\"Symbol\":\"{3}\"," +
                    "\"High\":\"{4}\"," +
                    "\"Low\":\"{5}\"," +
                    "\"Price\":\"{6}\"," +
                    "\"Volume\":\"{7}\"," +
                    "\"News\":\"{8}\"" +
                    "}}",
                    x.ToString(),
                    sDirection,
                    string.Format("{0:G}",DateTime.Now.ToString()),
                    zSymbol ,
                    RandomNumber(1, 333).ToString("#,##0.00"),          //ret["High"] 
                    RandomNumber(1, 23).ToString("#,##0.00"),           //ret["Low"] 
                    RandomNumber(43, 333).ToString("#,##0.00"),         //ret["Price"] 
                    RandomNumber(11111, 88888).ToString(),              //ret["Volume"] 
                    "<a href='http://www.baidu.com/' target='blank'>News</a>");    //ret["News"]

                return ret;
            }
            catch
            {
            }

        }


        return String.Empty;
    }



    public int RandomNumber(int min,int max)
    {
        Random random = new Random();

        return random.Next(min, max);

    }

    
}

