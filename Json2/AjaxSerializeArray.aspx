<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxSerializeArray.aspx.cs" Inherits="Json2_AjaxSerializeArray" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery Ajax - param </title>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function console(text) {
            $("#divMsg").append("<div>" + text + "</div>");
        }

        $(function() {
            $("#btnSerialize").click(function(e) {
                console($("form").serializeArray());
            });
        })
    </script>

</head>
<body>
    <form>
    <select name="single">
        <option>Single</option>
        <option>Single2</option>
    </select>
    <select name="multiple" multiple="multiple">
        <option selected="selected">Multiple</option>
        <option>Multiple2</option>
        <option selected="selected">Multiple3</option>
    </select>
    <div>
        <input type="text" name="a" value="1" id="a" />
        <input type="text" name="b" value="2" id="b" />
    </div>
    <div>
        <input type="checkbox" name="f" value="8" id="f" />
    </div>
    <input type="button" id="btnSerialize" value="serialize" />
    </form>    
    <div id="divMsg"></div>
</body>
</html>
