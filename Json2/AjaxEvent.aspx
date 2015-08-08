<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxEvent.aspx.cs" Inherits="Json2_AjaxEvent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery 全局Ajax事件</title>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    	$(document).ready(function ()
    	{
			//单击时执行一次Ajax请求
    		$("#btnAjax").bind("click", function (event)
    		{
    			$.get("AjaxGetMethod.aspx");
    		})
    		//添加“ajaxComplete”事件
    		$("#divResult").ajaxComplete(function (evt, request, settings)
    		{ $(this).append('<div>ajaxComplete</div>'); })
    		//添加“ajaxError”事件
    		$("#divResult").ajaxError(function (evt, request, settings)
    		{ $(this).append('<div>ajaxError</div>'); })
    		//添加“ajaxSend”事件
    		$("#divResult").ajaxSend(function (evt, request, settings)
    		{ $(this).append('<div>ajaxSend</div>'); })
    		//添加“ajaxStart”事件
    		$("#divResult").ajaxStart(function () { $(this).append('<div>ajaxStart</div>'); })
    		//添加“ajaxStop”事件
    		$("#divResult").ajaxStop(function () { $(this).append('<div>ajaxStop</div>'); })
    		//添加“ajaxSuccess”事件
    		$("#divResult").ajaxSuccess(function (evt, request, settings)
    		{ $(this).append('<div>ajaxSuccess</div>'); })
    	});
    </script>
</head>
<body>    
  <br /><button id="btnAjax">发送 AJAX 请求</button><br/>
  <div id="divResult"></div>
</body>
</html>
