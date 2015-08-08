/// <reference path="Core.js" />

var TopCalendar = {
    // ========== DOM ==========
    $contentEndRegion: null, //控件公共容器
    $windowElement: null,    //日历主窗口对象
    $eventElement: null,    //绑定日历的对象

    // ========== Properties ==========
    year: 2010,             //年
    month: 10,              //月
    day: 10,                //日
    language: "cn",         //此属性用于控制输出的日期字符串的格式，cn：2010-1-30, en: 1/30/2010
    selectDateString: null, //已经选中的日期字符串, 用于设置日历框控件的初始选中状态
    getDateString: function () {
        return this.language === "en" ? (this.month + "/" + this.day + "/" + this.year) : (this.year + "-" + this.month + "-" + this.day);
    },                      //返回日期的函数
    dateFrom: null,         //可选起始日期。yyyy-mm-dd或者 mm/dd/yyyy 格式的字符串。默认是今天
    dateTo: "9999-1-1",     //可选结束日期。yyyy-mm-dd或者 mm/dd/yyyy 格式的字符串。默认是9999-1-1


    // ========== Customer Method ==========
    isValidDate: function (year, month, day) {
        /// <summary>构建日历时，当前的日期是否是有效地，无效的日期将不可选，传入待判断日期的年、月、日</summary>
        var tempDataLeft = new Date(year, month - 1, day);
        var dateFromObj = this.getDateByString(this.dateFrom);
        var dateToObj = this.getDateByString(this.dateTo);
        var _from = new Date(dateFromObj.year, dateFromObj.month - 1, dateFromObj.day);
        var _to = new Date(dateToObj.year, dateToObj.month - 1, dateToObj.day);
        if ((!(tempDataLeft < _from)) && (!(tempDataLeft > _to))) {
            return true;
        }
        else {
            return false;
        }
    },

    onSelecting: function () {
        /// <summary>选择日期框之前触发的事件，返回false则会终止选择日期事件</summary>
        return true;
    },

    onSelect: function () {
        /// <summary>选择日期事件，默认行为是为事件触发元素填充日期</summary>
        this.$eventElement.val(this.getDateString());
    },

    onSelected: function () {
        /// <summary>选中日期后执行的事件</summary>
    },

    // ========== Method ==========
    initialize: function (options) {
        jQuery.extend(this, options);
        var inputDate = this.getDateByString(this.selectDateString);
        this.year = inputDate.year;
        this.month = inputDate.month;
        this.day = inputDate.day;
    },

    initializeDOM: function () {
        this.$contentEndRegion = $("#m_contentend");
        this.$windowElement = $("<div style=\"display:none; position: absolute; z-index: 2000;\"></div>").appendTo(this.$contentEndRegion);
    },

    initializeEvent: function () {
        this.$windowElement.bind("mousedown", this.onRegionClick.proxy(this));
    },

    pageLoad: function () {
        //更新日历框内容
        this.refreshMonth(this.year, this.month);
        //显示日历框
        var scrollTop = $(document).scrollTop();
        var scrollLeft = $(document).scrollLeft();
        var top = this.$eventElement.offset().top + this.$eventElement.height() + scrollTop + 6;
        var left = this.$eventElement.offset().left + scrollLeft;       

        $(this.$windowElement).offset({ "top": top, "left": left });
        $(this.$windowElement).bgIframe();
        $(this.$windowElement).show();
    },

    dispose: function () {
        /// <summary>析构函数，释放占用的所有资源，并销毁DOM对象</summary>
        if (this.$windowElement) {
            this.$windowElement.unbind();
            this.$windowElement.remove();
            this.$windowElement = null;
            this.$contentEndRegion = null;
            this.$eventElement = null;
        }
    },


    // ========== Event ==========
    onRegionClick: function (event) {
        var elem = $(event.target);
        var method = elem.attr("method");

        switch (method) {
            case "btnPre"://上一个月
                event.stopPropagation();
                var tempYear = parseInt(elem.parent().parent().find("span.h").attr("year"));
                var tempMonth = parseInt(elem.parent().parent().find("span.h").attr("month"));
                if (tempMonth <= 2) {
                    tempYear--;
                    tempMonth += 12;
                }
                tempMonth -= 2;
                this.refreshMonth(tempYear, tempMonth);
                return;
            case "btnNext"://下一个月
                event.stopPropagation();
                var tempYear = parseInt(elem.parent().parent().find("span.m").attr("year"));
                var tempMonth = parseInt(elem.parent().parent().find("span.m").attr("month"));
                if (tempMonth >= 11) {
                    tempYear++;
                    tempMonth -= 12;
                }
                tempMonth += 2;
                this.refreshMonth(tempYear, tempMonth);
                return;
            case "btnDay"://选择某一天
                if (elem.text()) {
                    this.year = parseInt(elem.parents("table").attr("year"));
                    this.month = parseInt(elem.parents("table").attr("month"));
                    this.day = parseInt(elem.text());
                    if (this.onSelecting) {
                        if (!this.onSelecting()) {//onSeleting返回true表示继续执行
                            return;
                        }
                    }

                    if (this.onSelect) {
                        this.onSelect();
                    }

                    if (this.onSelected) {
                        this.onSelected();
                    }

                    this.dispose();
                }
                return;
            case "close"://关闭控件
                this.dispose();
                return;
        }
    },

    // ========== private method ==========
    refreshMonth: function (year, month) {
        /// <summary>更改月份,更新日历DOM对象的内容</summary>

        var popRegion = "<div class=\"com_cbox\" >  <div class=\"calendar_year\"><div class=\"year\"><a method=\"btnPre\" href=\"#\" title=\"上一月\" class=\"mf_lr_a\">&nbsp;</a></div>#{MonthSPAN}	<div class=\"month_1\"><a  method=\"btnNext\" title=\"下一月\" href=\"#\" class=\"mf_rr_a\">&nbsp;</a></div><div class=\"month\"><a method=\"close\" class=\"ac_close_t cur\" title=\"关闭\" href=\"#\">x</a></div>  </div>  <div class=\"date_box\">	#{MonthHTML}	<div class=\"hr\"></div>	#{nextMonthHTML}  </div>  <div class=\"clear\"></div>  <div class=\"com_cbox_b com_cbox_lt\"></div>  <div class=\"com_cbox_b com_cbox_rt\"></div>  <div class=\"com_cbox_b com_cbox_lb\"></div>  <div class=\"com_cbox_b com_cbox_rb\"></div><div class=\"clear\"></div></div>";
        var monthSPAN_cn = "<span class=\"h\" year=\"#{year1}\" month=\"#{month1}\">#{year1}年#{month1}月</span><span class=\"m\"  year=\"#{year2}\" month=\"#{month2}\">#{year2}年#{month2}月</span>";
        var monthSPAN_en = "<span class=\"h\"  year=\"#{year1}\" month=\"#{month1}\">#{year1}.#{month1}</span><span class=\"m\"  year=\"#{year2}\" month=\"#{month2}\">#{year2}.#{month2}</span>";

        var nextYear = month == 12 ? year + 1 : year;
        var nextMonth = month == 12 ? 1 : month + 1;
        var spanHTML = this.language.toLowerCase() == "cn" ? monthSPAN_cn : monthSPAN_en;
        spanHTML = spanHTML.template({ "year1": year, "month1": month, "year2": nextYear, "month2": nextMonth });
        var contentHTML = popRegion.template({
            MonthSPAN: spanHTML,
            MonthHTML: this.getDateHTML(year, month),
            nextMonthHTML: this.getDateHTML(nextYear, nextMonth)
        });
        this.$windowElement.html(contentHTML);
    },

    getDayCount: function (year, month) {
        /// <summary>获取某月的天数</summary>
        /// <returns type="numeric" >天数</returns>
        var dayCount = 0;
        var days = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
        if (month == 0) {
            dayCount = 31;
        }
        else if (month == 2) {
            if ((year % 400 == 0) || (year % 4 == 0 && year % 100 > 0)) {
                dayCount = 29;  //闰年
            }
            else {
                dayCount = 28;
            }
        }
        else {
            dayCount = days[month - 1];
        }
        return dayCount;
    },

    getDateHTML: function (year, month) {
        /// <summary>获取日期列表</summary>
        var li = "<td onmouseover=\"$(this).toggleClass('hover')\" onmouseout=\"$(this).toggleClass('hover')\" class=\"#{class}\" method=\"btnDay\">#{text}</td>";
        var disableLi = "<td class=\"Close\">#{text}</td>";
        var grayLi = "<td class=\"#{class}\">#{text}</td>";
        var weakHTML_cn = "<tr class=\"family\"><th>日</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th></tr>";
        var weakHTML_en = "<tr class=\"family\"><th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th></tr>";
        var weakHTML = this.language === "en" ? weakHTML_en : weakHTML_cn;

        var builder = new Array();
        var tempToday = new Date();

        builder.push("<table year=\"#{year}\" month=\"#{month}\" width=\"140\" height=\"115\" cellspacing=\"0\" cellpadding=\"0\">".template({ "year": year, "month": month }));
        builder.push(weakHTML);
        var dayCount = this.getDayCount(year, month);
        var firstDate = new Date(year, month - 1, 1);
        var beginDay = firstDate.getDay();         //1号是星期几：0-6
        var liStyle = "";
        var lineCount = 1;
        var count1 = dayCount + beginDay;
        var j = 1;
        for (var i = 0; i < count1; i++) {
            if (i % 7 == 0) { builder.push("<tr>") };
            if (i >= beginDay && !this.isValidDate(year, month, j)) {
                liStyle = disableLi; // 不可选
            }
            else if (i < beginDay) {
                liStyle = grayLi;
            }
            else {
                liStyle = li;
            }
            var className = "";

            if (year === this.year && month === this.month && j === this.day) {
                className = "selected";
            }
            if (year === tempToday.getFullYear() && month === tempToday.getMonth + 1 && j === tempToday.getDate()) {
                className += " newdate";
            }

            if (i < beginDay) {
                className = "";
                builder.push(liStyle.template({ "class": className, "text": " " }));
            }
            else {
                builder.push(liStyle.template({ "class": className, "text": j }));
                j++;
            }
            if (i % 7 == 6) { builder.push("</tr>"); }
        }
        var lastDate = new Date(year, month - 1, dayCount);
        var endDay = lastDate.getDay(); //最后一天是星期几
        var count2 = 6 - endDay;
        for (var i = 0; i < count2; i++) {
            builder.push(grayLi.template({ "class": "", "text": "" }));
        }
        builder.push("</tr></table>");
        return builder.join("");
    },

    getDateByString: function (dateString) {
        /// <summary>根据日期字符串，获取日期信息.默认为今天</summary>  
        /// <param name="dateString" type="string">日期字符串</param>
        var year, month, day;
        if (dateString) {//根据传入的字符串获取日期信息
            if (dateString.indexOf("-") > -1) {
                dateArray = dateString.split("-");
                year = parseInt(dateArray[0]);
                month = parseInt(dateArray[1]);
                day = parseInt(dateArray[2]);
            }
            else {
                dateArray = dateString.split("/");
                year = parseInt(dateArray[2]);
                month = parseInt(dateArray[0]);
                day = parseInt(dateArray[1]);
            }
        }
        else {//默认为今天
            var today = new Date();
            year = today.getFullYear();
            month = today.getMonth() + 1;
            day = today.getDate();
        }
        return { "year": year, "month": month, "day": day };
    }
};