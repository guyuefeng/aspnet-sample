<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxJSONP.aspx.cs" Inherits="Json2_AjaxJSONP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery 使用 JSONP </title>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        function myJsonCallBack(data) {
            console(data.name);
        }


        function console(text) {
            $("#divMsg").append("<div>" + text + "</div>");
        }

        $(function() {
            $.ajax({
                url: "AjaxJSONP_Data.aspx",
                dataType: "jsonp",
                success: function(data) { console(data.isGood); },
                jsonpCallback: "myJsonCallBack"
            });
        })
    </script>
</head>
<body> 
    <div id="divMsg"></div>
</body>
</html>
