<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetCustomer.aspx.cs" Inherits="GetJson_GetCustomer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="jqueryPager/pagination.css" rel="stylesheet" type="text/css" />
    <script src="jqueryPager/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="jqueryPager/jquery.pagination.js" type="text/javascript"></script>
    
    <script type="text/javascript">
    
        var orderby="";
        
        $().ready(function() {
             InitData(0);

            $("#pageTheme").change(function(){
                $("#Pagination").attr('class',$(this).val());
            });
                     
        });
        
        function pageselectCallback(page_id, jq) {
            InitData(page_id);
        }
        
        function InitData(pageindx)
        {
            var tbody = "";
           
            $.ajax({
               type: "POST",//用POST方式传输
               dataType:"json",//数据格式:JSON
               url:'GetCustomer.ashx',//目标地址
               data:"p="+(pageindx+1)+"&orderby="+orderby,
               beforeSend:function(){$("#divload").show(); $("#Pagination").hide();},//发送数据之前
               complete:function(){$("#divload").hide();  $("#Pagination").show()},//接收数据完毕
               success:function(json) {
                        $("#customerTable tr:gt(0)").remove();
                        var productData = json.Customers;
                        $.each(productData, function(i, n) {
                            var trs = "";
                            trs += "<tr><td>" + n.CustomerID + "</td><td>" + n.CompanyName + "</td><td>" + n.ContactName + "</td><td>" + n.City + "</td><td>" + n.Phone + "</td></tr>";

                            tbody += trs;
                        });

                        $("#customerTable").append(tbody);

                        $("#customerTable tr:gt(0):odd").attr("class", "odd");
                        $("#customerTable tr:gt(0):even").attr("class", "enen");
                        
                        
                        $("#customerTable tr:gt(0)").hover(function(){
                            $(this).addClass('mouseover');
                        },function(){
                            $(this).removeClass('mouseover');
                        });
                }});
            
                $("#Pagination").pagination(<%=pagecount %>, {
                    callback: pageselectCallback,
                    prev_text: '« 上一页',
                    next_text: '下一页 »',
                    items_per_page:20,
		            num_display_entries:6,
		            current_page:pageindx,
		            num_edge_entries:2
                });
            
        }

        function Sort(ordercolumn,ordertipid)
        {
            
            var ordertype="";//1:desc,0:asc
            var $orderimg = $("#"+ordertipid);
            if($orderimg.html()!="")
            {
                var imgsrc = $("img",$orderimg).attr("src");
                
                if(imgsrc.indexOf("asc")>-1){
                 $(".ordertip").empty();
                   $orderimg.html("&nbsp;<img src=\"images/sort_desc.gif\" align=\"absmiddle\">");
                
                    ordertype = 1;
                }
                else
                { $(".ordertip").empty();
                    $orderimg.html("&nbsp;<img src=\"images/sort_asc.gif\" align=\"absmiddle\">");
                   
                    ordertype = 0;
                }
            }
            else
            {
             $(".ordertip").empty();
                 $orderimg.html("&nbsp;<img src=\"images/sort_desc.gif\" align=\"absmiddlke\">");
                    ordertype = 1;
            }
            
            orderby = ordercolumn+"_"+ordertype;
            
            InitData(0);
        } 

        
    </script>
    
    
    
    <style type="text/css">
        table{width:600px;border:solid 1px #666;background-color:#eee}
        table tr{line-height:23px}
        table tr th{background-color:#ccc;color:#fff}
        .odd{background-color:#fff}
        .enen{ background-color:#BCF5C4}
        .mouseover{ background-color:blue;}
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divload" style="top:50%; right:50%;position:absolute; padding:0px; margin:0px; z-index:999">
        <img src="images/spinner3-greenie.gif" /></div>
    <div>
    
        <table cellpadding=5 cellspacing=1 width=620 id="customerTable" align=center>
            <tr>
                <th style="width:100px"><a style="cursor:pointer;" onclick="Sort('CustomerID','CustomerID');return false;">客户编号</a><span id="CustomerID" class="ordertip"></span></th>
                <th style="width:200px"><a style="cursor:pointer;" onclick="Sort('CompanyName','CompanyName');return false;">公司名称</a><span id="CompanyName" class="ordertip"></span></th>
                <th style="width:200px"><a style="cursor:pointer;" onclick="Sort('ContactName','ContactName');return false;">联系人</a><span id="ContactName" class="ordertip"></span></th>
                <th style="width:120px"><a style="cursor:pointer;" onclick="Sort('City','City');return false;">城市</a><span id="City" class="ordertip"></span></th>
                <th style="width:120px"><a style="cursor:pointer;" onclick="Sort('Phone','Phone');return false;">电话</a><span id="Phone" class="ordertip"></span></th>
            </tr>
        </table>
    
    </div>
    <div id="Pagination" class="digg" ></div>
    <div style=" text-align:center;">分页样式:
    <select id="pageTheme">
        <option value="digg">digg</option>
        <option value="meneame">meneame</option>
        <option value="flickr">flickr</option>
        <option value="sabrosus">sabrosus</option>
        <option value="scott">scott</option>
        <option value="black">black</option>
        <option value="black2">black2</option>
        <option value="black-red">black-red</option>
        <option value="grayr">grayr</option>
        <option value="yellow">yellow</option>
        <option value="jogger">jogger</option>
        <option value="starcraft2">starcraft2</option>
        <option value="tres">tres</option>
        <option value="megas512">megas512</option>
        <option value="technorati">technorati</option>
        <option value="youtube">youtube</option>
        <option value="msdn">msdn</option>
        <option value="badoo">badoo</option>
        <option value="manu">manu</option>
        <option value="viciao">viciao</option>
        <option value="green-black">green-black</option>
        <option value="yahoo2">yahoo2</option>
   
    </select>
    </div>
    </form>
</body>
</html>