/// <reference path="jquery-1.4.2.js" />


////////////////////////////////////////// String /////////////////////////////////
jQuery.extend(String.prototype, {
        template: function(object)
        {
            var regex = /#{(.*?)}/g;
            return this.replace(regex, function(match, subMatch, index, source){
                return object[subMatch] || "";
            });
        }
    });    


////////////////////////////////////////// Function /////////////////////////////////
    jQuery.extend(Function.prototype, {
        proxy: function (context) {
            return jQuery.proxy(this, context);
        }
    });

////////////////////////////////////////// Class /////////////////////////////////
    var Class = {
    	create: function (classObj)
    	{
    		/// <summary>创建类的函数</summary>
    		/// <param name="classObj" type="object">用对象表示的类</param>
    		/// <returns type="object">类的实例，已经执行了类的构造函数</returns>
    		var args = jQuery.makeArray(arguments);
    		args.shift();
    		var tempclassObj = function (params)
    		{
    			this.initialize.apply(this, params);
    			this.initializeDOM.apply(this, params);
    			this.initializeEvent.apply(this, params);
    			this.pageLoad.apply(this, params);
    		};
    		classObj.initialize = classObj.initialize || jQuery.noop;
    		classObj.initializeDOM = classObj.initializeDOM || jQuery.noop;
    		classObj.initializeEvent = classObj.initializeEvent || jQuery.noop;
    		classObj.pageLoad = classObj.pageLoad || jQuery.noop;
    		classObj.dispose = classObj.dispose || jQuery.noop;
    		tempclassObj.prototype = classObj;
    		var result = new tempclassObj(args);
    		return result;
    	}
    }; 

////////////////////////////////////////// bgIframe plugin /////////////////////////////////
if (!jQuery.fn.bgIframe && !jQuery.fn.bgiframe)
{
	jQuery.fn.bgIframe = jQuery.fn.bgiframe = function(s)
	{
		// This is only for IE6
		if ($.browser.msie && /6.0/.test(navigator.userAgent))
		{
			s = $.extend({
				top: 'auto', // auto == .currentStyle.borderTopWidth
				left: 'auto', // auto == .currentStyle.borderLeftWidth
				width: 'auto', // auto == offsetWidth
				height: 'auto', // auto == offsetHeight
				opacity: true,
				src: 'javascript:false;'
			}, s || {});
			var prop = function(n) { return n && n.constructor == Number ? n + 'px' : n; },
		    html = '<iframe class="bgiframe"frameborder="0"tabindex="-1"src="' + s.src + '"' +
		               'style="display:block;position:absolute;z-index:-1;' +
			               (s.opacity !== false ? 'filter:Alpha(Opacity=\'0\');' : '') +
					       'top:' + (s.top == 'auto' ? 'expression(((parseInt(this.parentNode.currentStyle.borderTopWidth)||0)*-1)+\'px\')' : prop(s.top)) + ';' +
					       'left:' + (s.left == 'auto' ? 'expression(((parseInt(this.parentNode.currentStyle.borderLeftWidth)||0)*-1)+\'px\')' : prop(s.left)) + ';' +
					       'width:' + (s.width == 'auto' ? 'expression(this.parentNode.offsetWidth+\'px\')' : prop(s.width)) + ';' +
					       'height:' + (s.height == 'auto' ? 'expression(this.parentNode.offsetHeight+\'px\')' : prop(s.height)) + ';' +
					'"/>';
			return this.each(function()
			{
				if ($('> iframe.bgiframe', this).length == 0)
					this.insertBefore(document.createElement(html), this.firstChild);
			});
		}
		return this;
	};
}

////////////////////////////////////////// jQuery Extend Method /////////////////////////////////
jQuery.unparam = function (value)
{
	var params = {};
	var pairs = value.split('&');
	if (value.indexOf("=") < 0)
	{
		return value;
	}

	for (var i = 0; i < pairs.length; i++)
	{
		var pair = pairs[i].split('=');
		var accessors = [];
		var name = decodeURIComponent(pair[0]), value = decodeURIComponent(pair[1]);

		var name = name.replace(/\[([^\]]*)\]/g, function (k, acc) { accessors.push(acc); return ""; });
		accessors.unshift(name);
		var o = params;

		for (var j = 0; j < accessors.length - 1; j++)
		{
			var acc = accessors[j];
			var nextAcc = accessors[j + 1];
			if (!o[acc])
			{
				if ((nextAcc == "") || (/^[0-9]+$/.test(nextAcc)))
					o[acc] = [];
				else
					o[acc] = {};
			}
			o = o[acc];
		}
		acc = accessors[accessors.length - 1];
		if (acc == "")
			o.push(value);
		else
			o[acc] = value;
	}
	return params;
};

jQuery.getCookie = function (name, subName)
{
	/// <summary>获取Cookies信息, 根据Cookies内容返回对象会单值。不支持多层次嵌套的对象结构。使用举例：
	/// 获取主键为user的cookie：$.getCookie("user");（如果user含有子键，则返回对象）
	/// 获取主键为user，子键为name的cookie： $.getCookie("user","name");
	/// </summary>
	/// <param name="name" type="string">cookie主键</param>
	/// <param name="subName" type="string">cookie子键，可省略</param>
	/// <returns type="object">cookie值，string或object类型</returns>
	var cookieValue = "";
	if (document.cookie && document.cookie != '')
	{
		var cookies = document.cookie.split(';');
		for (var i = 0; i < cookies.length; i++)
		{
			var cookie = jQuery.trim(cookies[i]);
			if (cookie.substring(0, name.length + 1) == (name + '='))
			{//获取匹配主键名称的cookie字符串
				cookieValue = decodeURIComponent(cookie.substring(name.length + 1)); //获取Cookies主键值
				cookieValue = $.unparam(cookieValue);

				if (arguments.length > 1 && typeof arguments[1] === "string")
				{ //获取Cookies子键值
					if (typeof subName != 'undefined' && subName != null && subName != "")
					{
						cookieValue = cookieValue[subName] || "";
					}
				}
				break;
			}

		}
	}
	return cookieValue;
}


jQuery.setCookie = function (name, value, options)
{
	/// <summary>设置Cookies信息。value不支持多层次嵌套的对象结构。</summary>
	/// <param name="name" type="string">cookie主键</param>
	/// <param name="value" type="string">cookie值，可以是对象。</param>
	/// <param name="options" type="object">设置参数map对象，包括以下属性：
	/// expires[过期时间，数字(秒)或Date对象]
	/// path[路径，默认为根目录]
	/// domain[作用域，string，默认为根域名]
	/// secure[是否加密，传递任意值均表示加密]
	/// rewrite[是否覆盖，如果value传递对象则默认会和cookie的值做合并, 将rewrite设置为true则可以清空cookie并写入新值]
	/// </param>
	options = options || {};
	if (value === null)
	{
		value = '';
		options.expires = -1;
	}
	var expires = '';
	if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString))
	{
		var date;
		if (typeof options.expires == 'number')
		{
			date = new Date();
			date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
		} else
		{
			date = options.expires;
		}
		expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
	}
	var path = options.path ? '; path=' + (options.path) : ';path=/';
	var domain = options.domain ? '; domain=' + (options.domain) : '';
	var secure = options.secure ? '; secure' : '';

	if (typeof value == "object")
	{
		if (options && !options.rewrite)
		{ //rewrite为true表示重写此Cookie值，不做合并处理
			var currentValueObj = $.getCookie(name, true); // 当前Cookie中的值，对象形式
			value = jQuery.extend(currentValueObj, value);
		}
		value = $.param(value);
	}

	document.cookie = [name, '=', value, expires, path, domain, secure].join('');
}



    function toIntegersAtLease(n)
    // Format integers to have at least two digits.
    {
        return n < 10 ? '0' + n : n;
    }

    Date.prototype.toJSON = function (date)
    // Yes, it polutes the Date namespace, but we'll allow it here, as
    // it's damned usefull.
    {
        return this.getUTCFullYear() + '-' +
             toIntegersAtLease(this.getUTCMonth()) + '-' +
             toIntegersAtLease(this.getUTCDate());
    };

    var escapeable = /["\\\x00-\x1f\x7f-\x9f]/g;
    var meta = {    // table of character substitutions
        '\b': '\\b',
        '\t': '\\t',
        '\n': '\\n',
        '\f': '\\f',
        '\r': '\\r',
        '"': '\\"',
        '\\': '\\\\'
    };

    $.quoteString = function (string)
    // Places quotes around a string, inteligently.
    // If the string contains no control characters, no quote characters, and no
    // backslash characters, then we can safely slap some quotes around it.
    // Otherwise we must also replace the offending characters with safe escape
    // sequences.
    {
        if (escapeable.test(string)) {
            return '"' + string.replace(escapeable, function (a) {
                var c = meta[a];
                if (typeof c === 'string') {
                    return c;
                }
                c = a.charCodeAt();
                return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
            }) + '"';
        }
        return '"' + string + '"';
    };

    $.toJSON = function (o, compact) {
        var type = typeof (o);

        if (type == "undefined")
            return "undefined";
        else if (type == "number" || type == "boolean")
            return o + "";
        else if (o === null)
            return "null";

        // Is it a string?
        if (type == "string") {
            return $.quoteString(o);
        }

        // Does it have a .toJSON function?
        if (type == "object" && typeof o.toJSON == "function")
            return o.toJSON(compact);

        // Is it an array?
        if (type != "function" && typeof (o.length) == "number") {
            var ret = [];
            for (var i = 0; i < o.length; i++) {
                ret.push($.toJSON(o[i], compact));
            }
            if (compact)
                return "[" + ret.join(",") + "]";
            else
                return "[" + ret.join(", ") + "]";
        }

        // If it's a function, we have to warn somebody!
        if (type == "function") {
            throw new TypeError("Unable to convert object of type 'function' to json.");
        }

        // It's probably an object, then.
        var ret = [];
        for (var k in o) {
            var name;
            type = typeof (k);

            if (type == "number")
                name = '"' + k + '"';
            else if (type == "string")
                name = $.quoteString(k);
            else
                continue;  //skip non-string or number keys

            var val = $.toJSON(o[k], compact);
            if (typeof (val) != "string") {
                // skip non-serializable values
                continue;
            }

            if (compact)
                ret.push(name + ":" + val);
            else
                ret.push(name + ": " + val);
        }
        return "{" + ret.join(", ") + "}";
    };

    $.compactJSON = function (o) {
        return $.toJSON(o, true);
    };

    $.evalJSON = function (src)
    // Evals JSON that we know to be safe.
    {
        return eval("(" + src + ")");
    };

    $.secureEvalJSON = function (src)
    // Evals JSON in a way that is *more* secure.
    {
    	var filtered = src;
    	filtered = filtered.replace(/\\["\\\/bfnrtu]/g, '@');
    	filtered = filtered.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']');
    	filtered = filtered.replace(/(?:^|:|,)(?:\s*\[)+/g, '');

    	if (/^[\],:{}\s]*$/.test(filtered))
    		return eval("(" + src + ")");
    	else
    		throw new SyntaxError("Error parsing JSON, source is not valid.");
    };




jQuery(function ($) {
    if ($.datepicker) {
        $.datepicker.regional['zh-CN'] = {
            closeText: '关闭',
            prevText: '&#x3c;上月',
            nextText: '下月&#x3e;',
            currentText: '今天',
            monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
		    '七月', '八月', '九月', '十月', '十一月', '十二月'],
            monthNamesShort: ['一', '二', '三', '四', '五', '六',
		    '七', '八', '九', '十', '十一', '十二'],
            dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
            dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
            dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
            weekHeader: '周',
            dateFormat: 'yy-mm-dd',
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: true,
            yearSuffix: '年'
        };
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
    }
});