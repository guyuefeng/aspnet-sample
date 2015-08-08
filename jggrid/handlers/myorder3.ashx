<%@ WebHandler Language="C#" Class="myorder3" %>

using System;
using System.Web;

public class myorder3 :PagingHandler {

    public override string ProcName
    {
        get { return "SP_GetOrdersByPage"; }
    }

}