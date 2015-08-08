/// <reference path="../../common/js/jquery-1.4.2.js" />
/// <reference path="../../common/js/Core.js" />
/// <reference path="../../common/js/TopCalendar.js" />
/// <reference path="../../common/js/jquery-ui-1.8.2.custom.min.js"/>

var Homepage = {
    //========== 属性和私有字段 ========== 
    $hotelStartCity: null,
    $hotelStartCityId: null,
    $hotelCheckInTime: null,
    $hotelCheckOutTime: null,
    $hotelPrice: null,
    $hotelName: null,

    //========== 页面事件 ========== 
    initializeDOM: function () {
        this.$hotelStartCity = $("#hotelStartCity");
        this.$hotelStartCityId = $("#hotelStartCityId");
        this.$hotelCheckInTime = $("#hotelCheckInTime");
        this.$hotelCheckOutTime = $("#hotelCheckOutTime");
        this.$hotelPrice = $("#hotelPrice");
        this.$hotelName = $("#hotelName");
        this.$btnHotelSearch = $("#btnHotelSearch");
    },
    initializeEvent: function () {
        $.getJSON("cityinfo.htm", null, this.onGetCityInfoComplete.proxy(this));
        this.$hotelCheckInTime.click(this.onHotelCheckInTimeClick.proxy(this));
        this.$hotelCheckInTime.focus(this.onHotelCheckInTimeClick.proxy(this));
        this.$hotelCheckInTime.blur(this.onHotelCheckInTimeBlur.proxy(this));
        this.$hotelCheckOutTime.click(this.onHotelCheckOutTimeClick.proxy(this));
        this.$hotelCheckOutTime.focus(this.onHotelCheckOutTimeClick.proxy(this));
        this.$hotelCheckOutTime.blur(this.onHotelCheckOutTimeBlur.proxy(this));
        this.$btnHotelSearch.click(this.onBtnHotelSearchClick.proxy(this));


    },
    pageLoad: function () {
        $.getJSON("cityinfo.htm", null, jQuery.proxy(this.initAutoComplete, this));
        $("#divHotelSearchBox").dialog({ resizable: false });
    },

    //========== 事件处理函数 ========== 
    onHotelCheckInTimeClick: function (event) {
        if (!(this.checkInCalendar && this.checkInCalendar.$windowElement)) {
            this.checkInCalendar = Class.create(TopCalendar, {
                $eventElement: this.$hotelCheckInTime,
                onSelected: function () {
                    jQuery("#hotelCheckOutTime").trigger("click");
                }
            });
        }
        event.stopPropagation();
    },
    onHotelCheckInTimeBlur: function (event) {
        if (this.checkInCalendar && this.checkInCalendar.$windowElement) {
            this.checkInCalendar.dispose();
            this.checkInCalendar = null;
        }
    },

    onHotelCheckOutTimeClick: function (event) {
        if (!(this.checkOutCalendar && this.checkOutCalendar.$windowElement)) {
            var dateFromObj = TopCalendar.getDateByString(this.$hotelCheckInTime.val());
            var nextDay = dateFromObj.year + "-" + dateFromObj.month + "-" + (dateFromObj.day + 1);
            this.checkOutCalendar = Class.create(TopCalendar, {
                $eventElement: this.$hotelCheckOutTime,
                selectDateString: nextDay,
                dateFrom: nextDay
            });
        }
        event.stopPropagation();
    },
    onHotelCheckOutTimeBlur: function (event) {
        if (this.checkOutCalendar && this.checkOutCalendar.$windowElement) {
            this.checkOutCalendar.dispose();
            this.checkOutCalendar = null;
        }
    },

    onGetCityInfoComplete: function (data) {
        var options = {
            minChars: 1,
            max: 500,
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
        this.$hotelStartCity.autocomplete(data, options);
        this.$hotelStartCity.result(function (event, data, formatted) {
            this.$hotelStartCityId.val(data.ElongCityId);
        } .proxy(this));
    },

    onBtnHotelSearchClick: function () {
        if (!this.$hotelStartCity.val()) {
            alert("请输入酒店所在城市");
            return;
        }
        var url = "http://" + "travel.elong.com/hotel/list_cn_" + this.$hotelStartCityId.val() + ".html?" + "indate=" + this.$hotelCheckInTime.val() + "&outdate=" + this.$hotelCheckOutTime.val() + "&campaign_id=4055103"
        location.href = url;
    }
}


$(function () {
    var homepage = Class.create(Homepage);
})