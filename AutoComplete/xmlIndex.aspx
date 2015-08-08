<%@ Page Language="C#" AutoEventWireup="true" CodeFile="xmlIndex.aspx.cs" Inherits="AutoComplete_xmlIndex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>  
    <title>智能提醒实例-数据源为xml文件</title>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery-ui-1.8.16.custom.min.js"></script>
	<script>
	$(function() {
		$.ajax({
			url: "data.xml",
			dataType: "xml",
			success: function( xmlResponse ) {
			    //获取XML文件的数据
				var data = $( "language", xmlResponse ).map(function() {
					return {
						value: $( "name", this ).text()
					};
				}).get();
				//自动补全设置
				$( "#xmlQuery" ).autocomplete({
					source: data,
					minLength: 1
				});
			}
		});
	});
	</script>

  </head>
  
  <body>
    <div class="demo">
		<div class="ui-widget">
			<label for="tags">tags: </label>
			<input id="xmlQuery" />
		</div>
	</div>
  </body>
</html>
