using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Email_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        EmailHelper email = new EmailHelper();
        email.EmailFrom = "liguofeng@swirebev.com";
        email.EmailTo = "liguofeng@swirebev.com";
 
        email.SendEmail("测试邮件", "test");
    }
}
