<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Jquery_Load.aspx.cs" Inherits="Json2_Jquery_Load" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery Ajax - Load</title>

    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $("#btnAjaxGet").click(function(event) {
                //发送Get请求
                $("#divResult").load("AjaxGetMethod.aspx?param=btnAjaxGet_click" + "&timestamp=" + (new Date()).getTime());
                alert((new Date()).getTime());
            });

            $("#btnAjaxPost").click(function(event) {
                //发送Post请求
                $("#divResult").load("AjaxGetMethod.aspx", { "param": "btnAjaxPost_click" });
            });

            $("#btnAjaxCallBack").click(function(event) {
                //发送Post请求, 返回后执行回调函数.
                $("#divResult").load("AjaxGetMethod.aspx", { "param": "btnAjaxCallBack_click" }, function(responseText, textStatus, XMLHttpRequest) {
                    responseText = " Add in the CallBack Function! <br/>" + responseText
                    $("#divResult").html(responseText); //或者: $(this).html(responseText);
                });
            });

            $("#btnAjaxFiltHtml").click(function(event) {
                //发送Get请求, 从结果中过滤掉 "鞍山" 这一项
                $("#divResult").load("AjaxGetCityInfo.aspx?resultType=html" + "&timestamp=" + (new Date()).getTime() + " ul>li:not(:contains('鞍山'))");
            });

        })
    </script>

</head>
<body>    
    <button id="btnAjaxGet">使用Load执行Get请求</button><br />
    <button id="btnAjaxPost">使用Load执行Post请求</button><br />
    <button id="btnAjaxCallBack">使用带有回调函数的Load方法</button><br />
    <button id="btnAjaxFiltHtml">使用selector过滤返回的HTML内容</button>
    <br />
    <div id="divResult"></div>
</body>
</html>