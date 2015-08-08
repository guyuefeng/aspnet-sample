<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Jquery_AutoComplete.aspx.cs" Inherits="Json2_Jquery_AutoComplete" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>jQuery PlugIn - 自动完成插件实例 AutoComplete </title>
    <link href="../js/jquery.autocomplete.css" rel="stylesheet"
        type="text/css" />
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery.autocomplete.min.js"
        type="text/javascript"></script>
    <style type="text/css">
        body
        {
            font-size: 12px;
        }
        
        .formLabel
        {
            float: left;
            width: 150px;
            text-align: right;
        }
        .formInput
        {
            float: left;
        }
    </style>
</head>
<body>
    <!-- Demo. 应用AutoComplete插件 -->
    <div class="ui-widget ui-widget-content ui-corner-all" style="width: 700px; padding: 5px;">
        <h3>
            Demo. 应用AutoComplete插件
        </h3>
        <br style="clear: both" />
        <div class="formLabel">
            <label for="inputCityName">
                请输入城市拼音和汉字:</label>
        </div>
        <div class="formInput">
            <input id="inputCityName" name="inputCityName" type="text" />
        </div>
        <br style="clear: both" />
        <br style="clear: both" />
        <div class="formLabel">
            <label for="inputCityName">
                城市ID:</label></div>
        <div class="formInput">
            <input id="inputCityId" name="inputCityId" type="text" /></div>
        <br style="clear: both" />
        <br style="clear: both" />
    </div>
    <script type="text/javascript">
        var thisPage = {
            initialize: function () {//加载时执行
                this.initializeDom();
                this.initializeEvent();

                $.getJSON("cityinfo.htm", null, jQuery.proxy(this.initAutoComplete, this));

            },
            initializeDom: function () {//初始化DOM 
                this.$inputCityName = $("#inputCityName");
                this.$inputCityId = $("#inputCityId");
            },
            initializeEvent: function () {//事件绑定

            },
            initAutoComplete: function (data) {
                var options = {
                    minChars: 1,
                    max: 600,
                    width: 250,
                    matchContains: true,
                    formatItem: function (row, i, max) {
                        return i + "/" + max + ": \"" + row.CityNameEn + "\" [" + row.CityName + "]";
                    },
                    formatMatch: function (row, i, max) {
                        return row.CityNameEn + " " + row.CityName;
                    },
                    formatResult: function (row) {
                        return row.CityName;
                    }
                };
                this.$inputCityName.autocomplete(data, options);
                this.$inputCityName.result(jQuery.proxy(function (event, data, formatted) {
                    this.$inputCityId.val(data.ElongCityId);
                }, this));
            }

        }

        $(thisPage.initialize());        
    </script>
</body>
</html>
