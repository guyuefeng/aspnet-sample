using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Text.RegularExpressions;



public partial class userControl_pagination1 : System.Web.UI.UserControl
{

    //分页字符
    public StringBuilder paginationStr = new StringBuilder();

    //总分页数 
    private string page_Count;
    public string Page_Count
    {
        set
        {
            Regex re = new Regex(@"^[1-9]\d*$");
            if (re.IsMatch(value))
            {
                int data_count = Convert.ToInt32(value);
                if (data_count % 20 != 0)
                {
                    page_Count = string.Format("{0}", data_count / 20 + 1);
                }
                else
                {
                    page_Count = string.Format("{0}", data_count / 20);
                }
            }
        }
    }

    //显示分页文字是中文 还是英文
    private string text_Type;
    public string Text_Type
    {
        set
        {
            if (string.IsNullOrEmpty(string.Format("{0}",value)))
            {
                value = "CN";
            }
            text_Type = value.ToUpper().Trim();
        }
    }

    //当前页的索引
    public int pageIndex = 0;

    //当前请求URL
    public string url = string.Empty;

    //原始URL
    public string baseUrl = string.Empty;

    //获取所有参数集合
    public Hashtable urlParameters = new Hashtable();
    // 分页模式:
    // style1: 10页以内
    // 首页 上一页 1 2 3 4 6 7 8 9 10下一页 末页 当前2/共200页

    // style2: 10页以上
    // 首页 上一页 5 6 7 8 9 10 11 12 13 14 15 16 下一页 末页 当前2/共200页

    //style3:
    //home prev 1 2 3 4 5 6 7 8 9 10 next last


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void Get_URL()
    {
        try
        {
            string urlParams = string.Empty;
            url = Request.Url.AbsoluteUri;
            baseUrl = url.Split('?').Length > 1 ? url.Substring(0, url.IndexOf('?')) : url;
            urlParams = url.Split('?').Length > 1 ? url.Substring(url.IndexOf('?') + 1) : "";
            if (url.Split('?').Length > 0 && url.Split('?').Length < 3)
            {
                if (urlParams.Trim() != "")
                {
                    if (urlParams.Split('&').Length > 0)
                    {
                        for (int i = 0; i < urlParams.Split('&').Length; i++)
                        {
                            urlParameters.Add(urlParams.Split('&')[i].Split('=')[0], urlParams.Split('&')[i].Split('=')[1]);
                        }
                    }
                }
                else
                {
                    urlParameters.Add("page", 1);
                }
            }
            SetPaginationNumber(Convert.ToInt32(urlParameters["page"]));
        }
        catch 
        {
            Page.ClientScript.RegisterStartupScript(GetType(), Guid.NewGuid().ToString(), "alert('参数错误!');top.location.href='../404.aspx'", true);
            Response.End();
            //throw;
        }
    }

    public void SetPaginationNumber(int PageIndexNumber)
    {
        int page_Count_i = Convert.ToInt32(page_Count);
        string parmsStr = string.Empty;
        foreach (var item in urlParameters.Keys)
        {
            if (item.ToString() != "page")
            {
                parmsStr += "&" + item.ToString() + "=" + urlParameters[item].ToString();
            }
        }
        paginationStr.Append("<ul id=\"pagination-flickr\">");
        //首页
        paginationStr.Append(PageIndexNumber != 1 ? string.Format("<li class=\"next\"><a href=\"{0}?page={1}{2}\">{3}</a></li>" ,
                              baseUrl, 1, parmsStr,text_Type=="EN"?"home":"首页") : "");

        //上一页
        if (PageIndexNumber < 2)
        {
            PageIndexNumber = 1;
        }
        paginationStr.Append(string.Format("<li class=\"next\"><a href=\"{0}?page={1}{2}\">{3}</a></li>",
                              baseUrl, PageIndexNumber == 1 ? 1 : PageIndexNumber - 1, parmsStr,text_Type=="EN"?"prev":"上一页"));

        // 数字导航
        if (page_Count_i <= 10)
        {
            Set_NumStr(1, page_Count_i, PageIndexNumber, parmsStr);
        }
        else
        {
            if (PageIndexNumber < 5)
            {
                Set_NumStr(1, 10, PageIndexNumber, parmsStr);
            }
            else if ((PageIndexNumber + 5) > page_Count_i)
            {
                Set_NumStr((page_Count_i - 9), page_Count_i+1, PageIndexNumber, parmsStr);
            }
            else
            {
                Set_NumStr(PageIndexNumber - 5, PageIndexNumber + 4, PageIndexNumber, parmsStr);
            }
        }

        //下一页
        if (PageIndexNumber >= page_Count_i)
        {
            PageIndexNumber = page_Count_i - 1;
        }
        paginationStr.Append(string.Format("<li class=\"next\"><a href=\"{0}?page={1}{2}\">{3}</a></li>",
                              baseUrl, PageIndexNumber + 1, parmsStr,text_Type == "EN" ? "next" : "下一页"));

        //末页
        paginationStr.Append(PageIndexNumber != page_Count_i - 1
                            ? string.Format("<li class=\"next\"><a href=\"{0}?page={1}{2}\">{3}</a></li>",
                            baseUrl, page_Count_i, parmsStr, text_Type == "EN" ? " last" : "末页") : "");

        //当前1/共20页
        paginationStr.Append(string.Format("<li class=\"next\"><a  href=\"#\">当前{0}/共{1}页</a></li>", PageIndexNumber, page_Count_i));
        paginationStr.Append("</ul>");
    }

    //设置数字分页字符串
    private void Set_NumStr(int BeginNumber, int EndNumber, int PageIndexNumber, string parmsStr)
    {
        for (int i = BeginNumber; i < EndNumber; i++)
        {
            paginationStr.Append(string.Format("<li {0}><a href=\"{1}?page={2}{3}\">{4}</a></li>",
                                i == PageIndexNumber ? "class=\"currentState\"" : "", baseUrl, i, parmsStr, i));
        }
    }
}