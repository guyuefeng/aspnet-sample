<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomePage.aspx.cs" Inherits="JqueryStorm_HomePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../js/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../js/style.css" rel="stylesheet" />
    <link href="../js/jquery.autocomplete.css" rel="stylesheet"
        type="text/css" />
    <style type="text/css">
        #divHotelSearchBox div{ margin:5px; }
    </style>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="divHotelSearchBox" title="酒店搜索">
        <div>
            <label class="ui-widget">
                城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：
            </label>
            <input id="hotelStartCity" />
            <input id="hotelStartCityId" name="hotelStartCityId" type="hidden" />
        </div>
        <div>
            <label class="ui-widget">
                入住日期：
            </label>
            <input id="hotelCheckInTime" />
        </div>
        <div>
            <label class="ui-widget">
                离店日期：
            </label>
            <input id="hotelCheckOutTime" />
        </div>
        <div>
            <label class="ui-widget">
                酒店名称：</label>
            <input id="hotelName" />
        </div>
        <div>
            <br />
            <input type="button" id="btnHotelSearch" value="搜索" class="ui-state-default" style="width:80px;height:25px;"/>
        </div>
    </div>
    </form>
    <div id="m_contentend">
    </div>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/Core.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
    <script src="../js/jquery.autocomplete.min.js"
        type="text/javascript"></script>
    <script src="../js/TopCalendar.js" type="text/javascript"></script>
    <script src="../js/homepage.js" type="text/javascript"></script>
</body>
</html>