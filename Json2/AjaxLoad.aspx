<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxLoad.aspx.cs" Inherits="Json2_AjaxLoad" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery 中的Ajax</title>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#btnAjaxJquery").click(function (event) {
            $("#divResult").load("AjaxLoad_Data.aspx", { "resultType": "html" });
            });
        })        
    </script>
</head>
<body>    
    <button id="btnAjaxJquery">使用jQuery的load方法</button>
    <br />
    <div id="divResult"></div>
</body>
</html>