using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CookieHelper
/// </summary>
public class CookieHelper
{

    #region ==================== Private Filed ====================
    #endregion


    #region ==================== Property ====================
    #endregion


    #region ==================== Constructed Method ====================
    public CookieHelper()
    {
    }
    #endregion


    #region ==================== Private Method ====================
    #endregion


    #region ==================== Public Method ====================

    #region SetCookie() : 设置Cookies方法

    /// <summary>
    /// 写入Cookies
    /// </summary>
    /// <param name="cookieName">cookie名称</param>
    /// <param name="cookieValue">cookie值</param>
    /// <param name="day">过期天数</param>
    /// <returns>是否成功</returns>
    public static bool SetCookie(string cookieName, string cookieValue, int days)
    {
        return CookieHelper.SetCookie(cookieName, cookieValue, DateTime.Now.AddDays(days));
    }

    /// <summary>
    /// 写入Cookies
    /// </summary>
    /// <param name="cookieName">cookie名称</param>
    /// <param name="cookieValue">cookie值</param>
    /// <param name="expireTime">过期日期</param>
    /// <returns>是否成功</returns>
    public static bool SetCookie(string cookieName, string cookieValue, DateTime expireTime)
    {
        return CookieHelper.SetCookie(cookieName, null, cookieValue, expireTime);
    }

    /// <summary>
    /// 写入Cookies
    /// </summary>
    /// <param name="cookieName">cookie名称</param>
    /// <param name="subKeyName">Cookies子键的名称</param>
    /// <param name="cookieValue">cookie值</param>
    /// <param name="day">过期天数</param>
    /// <returns>是否成功</returns>
    public static bool SetCookie(string cookieName, string subKeyName, string cookieValue, int days)
    {
        return CookieHelper.SetCookie(cookieName, subKeyName, cookieValue, DateTime.Now.AddDays(days));
    }

    /// <summary>
    /// 写入Cookies
    /// </summary>
    /// <param name="cookieName">cookie名称</param>
    /// <param name="cookieValue">cookie值</param>
    /// <param name="expireTime">日期</param>
    /// <returns>是否成功</returns>
    public static bool SetCookie(string cookieName, string subKeyName, string cookieValue, DateTime expireTime)
    {
        //私有变量
        string domain = "elong.com";                    //Cookies的作用于,默认为elong.com
        HttpCookie SessionCookie = null;                //保存SessionID的cookie
        HttpCookie SessionGuidCookie = null;

        //创建Cookie对象
        if (cookieName == null || cookieName == "") return false;
        HttpCookie objCookie;
        //先判断是否有Cookies对象。如果有则需要先获取。
        if (System.Web.HttpContext.Current.Response.Cookies[cookieName] == null)
        {
            objCookie = new HttpCookie(cookieName);
        }
        else
        {
            objCookie = System.Web.HttpContext.Current.Response.Cookies[cookieName];
        }


        //对 Asp.Net_SessionId 和 SessionGuid 进行备份.
        if (HttpContext.Current.Request.Cookies["ASP.NET_SessionId"] != null
            && !String.IsNullOrEmpty(HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value))
        {
            string sesssionId = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString();
            SessionCookie = new HttpCookie("ASP.NET_SessionId");
            SessionCookie.Value = sesssionId;
        }
        if (HttpContext.Current.Request.Cookies["SessionGuid"] != null
            && !String.IsNullOrEmpty(HttpContext.Current.Request.Cookies["SessionGuid"].Value))
        {
            string sessionGuid = HttpContext.Current.Request.Cookies["SessionGuid"].Value.ToString();
            SessionGuidCookie = new HttpCookie("SessionGuid");
            SessionGuidCookie.Value = sessionGuid;
        }

        //设定cookie 过期时间.
        objCookie.Expires = expireTime;

        //设定cookie 域名.
        if (HttpContext.Current.Request.Params["HTTP_HOST"] != null)
        {
            //domain = "www.elong.com";
            domain = HttpContext.Current.Request.Params["HTTP_HOST"].ToString();
        }

        //如果是www.elong.com或多级域名,需要转化为elong.com
        if (domain.IndexOf(".") > -1)
        {
            string[] temp = domain.Split('.');

            if (temp.Length >= 3)
            {
                domain = temp[temp.Length - 2].Trim() + "." + temp[temp.Length - 1].Trim();
            }
            objCookie.Domain = domain;
        }


        //写入Cookies   
        if (!String.IsNullOrEmpty(subKeyName))
        {
            objCookie[subKeyName] = HttpUtility.UrlEncode(cookieValue.Trim());
        }
        else
        {
            objCookie.Value = HttpUtility.UrlEncode(cookieValue.Trim());
        }
        if (System.Web.HttpContext.Current.Response.Cookies[cookieName] == null)
        {
            System.Web.HttpContext.Current.Response.Cookies.Add(objCookie);
        }
        else
        {
            System.Web.HttpContext.Current.Response.Cookies.Set(objCookie);
        }


        //如果cookie总数超过20 个, 重写ASP.NET_SessionId 和 SessionGuid, 以防Session 丢失.
        if (HttpContext.Current.Request.Cookies.Count > 20)
        {
            if (SessionCookie != null && !String.IsNullOrEmpty(SessionCookie.Value))
            {
                HttpContext.Current.Response.Cookies.Remove("ASP.NET_SessionId");
                HttpContext.Current.Response.Cookies.Add(SessionCookie);
            }
            if (SessionGuidCookie != null && !String.IsNullOrEmpty(SessionGuidCookie.Value))
            {
                HttpContext.Current.Response.Cookies.Remove("SessionGuid");
                HttpContext.Current.Response.Cookies.Add(SessionGuidCookie);
            }
        }

        return true;
    }

    #endregion

    #region GetCookie() : 获取Cookies

    /// <summary>
    /// 读取Cookies
    /// </summary>
    /// <param name="cookieName">Cookie键名</param>
    /// <returns>Cookies值</returns>
    public static string GetCookie(string cookieName)
    {
        return CookieHelper.GetCookie(cookieName, null);
    }

    /// <summary>
    /// 读取Cookies
    /// </summary>
    /// <param name="cookieName">Cookie键名</param>
    /// <param name="subKeyName">子键名</param>
    /// <returns>Cookies值</returns>
    public static string GetCookie(string cookieName, string subKeyName)
    {
        string result = string.Empty;

        try
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                if (!String.IsNullOrEmpty(subKeyName))
                {
                    result = HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies[cookieName][subKeyName]);
                }
                else
                {
                    if (HttpContext.Current.Request.Cookies[cookieName] != null)
                        result = HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies[cookieName].Value.Trim());
                    else
                        result = string.Empty;
                }
            }
        }
        catch
        {
            result = string.Empty;
        }

        return result;
    }

    #endregion

    #endregion

}