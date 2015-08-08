using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Json2_JSON : System.Web.UI.Page
{

    public class MyClass
    {
        public string MyName
        { get; set; }
        public int Age
        { get; set; }
    }

    protected MyClass myClass;
    protected string jsonString = String.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        //创建一个类实例
        myClass = new MyClass() { MyName = "ligufo0eng", Age = 99 };
        //将对象实例转化为JSON字符串
        jsonString = JsonHelper2.ObjectToJson<MyClass>(myClass);
        //将JSON字符串转化为对象实例
        myClass = JsonHelper2.JsonToObject<MyClass>(jsonString);

    }
}
