<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoCompleteT1.aspx.cs" Inherits="AutoComplete_AutoCompleteT1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Jquery AutoComplete</title>
    <script src="jquery.min.js" type="text/javascript"></script>
    <script src="jquery-ui-1.8.16.custom.min.js"
        type="text/javascript"></script>
<%--    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/i18n/jquery-ui-i18n.min.js"
        type="text/javascript"></script>--%>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css"
        type="text/css" media="all" />
   <style type="text/css">
	.ui-autocomplete-loading { background: white url('/images/ui-anim_basic_16x16.gif') right center no-repeat; }
	#AutoCompleteText { width: 25em; }
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#AutoCompleteText").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "AutoCompleteWebService.asmx/GetRandomStrings",
                        dataType: "json",
                        data: "{'Value':'" + request.term + "'}",
                        success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.Name + '(' + item.Value + ')',
                                        value: item.Name
                                    }
                                }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    //TO TEST PURPOSE ONLY
                    log(ui.item ? "Selected: " + ui.item.label + " Value: " + ui.item.value + " Name: " + ui.item.Name : "Nothing selected, input was " + this.value);
                },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });

        });
        function log(message) {
            $("<div/>").text(message).prependTo("#log");
            $("#log").attr("scrollTop", 0);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="AutoCompleteText" type="text" />

    </div>
    <div class="ui-widget" style="margin-top:2em; font-family:Arial">
	Selection Result Log (Test Purpose Only):
	<div id="log" style="height: 200px; width: 500px; overflow: auto;" class="ui-widget-content"></div>
</div>
    </form>
</body>
</html>
