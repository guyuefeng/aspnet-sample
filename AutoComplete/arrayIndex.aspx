<%@ Page Language="C#" AutoEventWireup="true" CodeFile="arrayIndex.aspx.cs" Inherits="AutoComplete_arrayIndex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ajax AutoComplete for jQuery</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
<link href="widgets.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery.autocomplete.min.js"></script>
    <script type="text/javascript">
    var local;

    function InitMonths() {
    	local.setOptions({ lookup: 'January,February,March,April,May,June,July,August,September,October,November,December'.split(',') });
    }
    function InitWeekdays() {
    	local.setOptions({ lookup: 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday'.split(',') });
    }
    jQuery(function () {
    	
    	local = $('#months').autocomplete({
            width: 384,
            delimiter: /(,|;)\s*/,
            lookup: 'January,February,March,April,May,June,July,August,September,October,November,December'.split(',')
        });
    });
</script>
</head>
<body id="top">
<div class="dbcms-content" id="dbcms-ctl-3t99">
  <div class="dbcms-contenttext dbcms-clearfix" id="dbcms-content-3t99">
    <div class="jquery-heading container clearafter">
      
      <div class="half-column demo" style="margin: 0; float: right;"> <img alt="Ajax AutoComplete for jQuery Live Demo" src="img/live-demo.jpg" />
        <div class="trans-box-light">
          <div class="no-ajax-demo">
            <h3>array数据源</h3>
            <label>Month of Year:</label>
            <br />
            <input class="textbox" id="months" name="q" type="text" />
            <div class="suggest"> <strong>Suggest:</strong>
              <label>
                <input checked="checked" name="Suggest" onclick="InitMonths();" type="radio" />
                Month</label>
              <label>
                <input name="Suggest" onclick="InitWeekdays();" type="radio" />
                Weekday</label>
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</div>
</body>
</html>


