<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RealTimeStock.aspx.cs" Inherits="RealTimeStock_RealTimeStock" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>HTML Table</title>

    <link href="table.css" rel="stylesheet" type="text/css" />

    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        // BILL: This keeps the total number of rows in the html table constant
        function removeRowFromTable() {
            var tbl = document.getElementById('gvData');
            var lastRow = tbl.rows.length;
            if (lastRow > 10) tbl.deleteRow(lastRow - 1);
        }

        function Log(Text, MessageType) {
            if ((document.getElementById("LogContainer") == undefined)) { return; }
            if (MessageType == "OK") Text = "<span style='color: white;'>" + Text + "</span>";
            if (MessageType == "ERROR") Text = "<span style='color: red;'>" + Text + "</span>";
            document.getElementById("LogContainer").innerHTML = Text + "<br />";
            var LogContainer = document.getElementById("LogContainer");
            LogContainer.scrollTop = LogContainer.scrollHeight;
        };

        function setIPAddress(responseText) {
            document.getElementById("iplabel").innerText = "IP Address: " + responseText;
        }

        function fnStartClock() {
            oInterval = setInterval("CallWebServiceFromJquery()", 10000);
        }

        function fnStopClock() {
            clearInterval(oInterval);
        }

        function CallWebServiceFromJquery() {
            $.ajax({
                type: "POST",
                url: "RealTimeStock.asmx/Tick",
                data: "{  }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                error: OnError
            });

        }

        function OnSuccess(data, status) {
//            alert(data.d);
            messages = data.d;
            
            var zebra = document.getElementById("gvData");
            var trow;
            for (var i = 0; i < messages.length; i++) {
                var ret = jQuery.parseJSON(messages[i]);
                if (ret.Dir == "▼")
                    trow = $('<tr style="color:red;"><td><img src="../icons_grid/' + ret.ImageID + '.gif" /></td><td><nobr>' + ret.Dir + '</td><td><nobr>' + ret.Time + '</nobr></td><td>' + ret.Symbol + '</td><td>' + ret.High + '</td><td>' + ret.Low + '</td><td>' + ret.Price + '</td><td>' + ret.Volume + '</td><td>' + ret.News + '</td></tr>');
                else
                    trow = $('<tr style="color:lime;"><td><img src="../icons_grid/' + ret.ImageID + '.gif" /></td><td><nobr>' + ret.Dir + '</td><td><nobr>' + ret.Time + '</nobr></td><td>' + ret.Symbol + '</td><td>' + ret.High + '</td><td>' + ret.Low + '</td><td>' + ret.Price + '</td><td>' + ret.Volume + '</td><td>' + ret.News + '</td></tr>');

                trow.prependTo(zebra);
                removeRowFromTable();
            }
        }

        function OnError(request, status, error) {
            alert(request.statusText);
        }

        $(document).ready(function () {
            fnStartClock();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="blank" 
        style="font-family: Arial, Helvetica, sans-serif; font-size: x-large; font-weight: bold; color: #FFFFFF">
        Jquer AJAX  with JSON HTML Table</div>
    <div id="LogContainer"></div><br />     
      <div class="grid-header" style="width:100%">
	    <label id="iplabel">IP Address: 127.0.0.1</label>
      </div>    	
      <table id="gvData" class="tablestyle" cellspacing="0" cellpadding="0" border="0" style="color:#333333;width:860px;border-collapse:separate;">
		<thead>
        <tr class="headerstyle">
			<th title="Icon" scope="col" style="font-size:9pt;">Icon</th>
            <th title="Direction" scope="col" style="font-size:9pt;">Dir</th>
            <th title="Time" scope="col" style="font-size:9pt;">Time</th>
            <th title="Symbol" scope="col" style="font-size:9pt;">Symbol</th>
            <th title="High" scope="col" style="font-size:9pt;">High</th>
            <th title="Low" scope="col" style="font-size:9pt;">Low</th>
            <th title="Price" scope="col" style="font-size:9pt;">Price</th>
            <th title="Volume" scope="col" style="font-size:9pt;">Volume</th>
            <th title="News" scope="col" style="font-size:9pt;">News</th>
		</tr>
        </thead>
        <tbody>
        </tbody>
    </table>
<br />
    </form>
</body>
</html>
