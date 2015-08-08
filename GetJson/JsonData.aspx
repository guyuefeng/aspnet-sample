<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JsonData.aspx.cs" Inherits="GetJson_JsonData" %>

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
            alert(page_id);
            InitData(page_id);
        }
        
        function InitData(pageindx)
        {
            var tbody = "";
           
            $.ajax({
               type: "POST",//用POST方式传输
               dataType:"json",//数据格式:JSON
               url:'JsonData.ashx',//目标地址
               data:"p="+(pageindx+1)+"&orderby="+orderby,
               beforeSend:function(){$("#divload").show(); $("#Pagination").hide();},//发送数据之前
               complete:function(){$("#divload").hide();  $("#Pagination").show()},//接收数据完毕
               success:function(json) {
                        $("#productTable tr:gt(0)").remove();
                        var productData = json.Products;
                        $.each(productData, function(i, n) {
                            var trs = "";
                            trs += "<tr><td>" + n.orderid + "</td><td>" + n.customerid + "</td><td>" + n.shipname + "</td><td>" + n.shipcity + "</td></tr>";

                            tbody += trs;
                        });

                        $("#productTable").append(tbody);

                        $("#productTable tr:gt(0):odd").attr("class", "odd");
                        $("#productTable tr:gt(0):even").attr("class", "enen");
                        
                        
                        $("#productTable tr:gt(0)").hover(function(){
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
        table{ width:600px; background-color:#ffffff}
      table th{ height:24px; background-color:#037E12; color:White;}
      .odd{ background-color:#5FD66C}
      .enen{ background-color:#BCF5C4}
      .mouseover{ background-color:blue;}
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divload" style="top:50%; right:50%;position:absolute; padding:0px; margin:0px; z-index:999">
        <img src="images/spinner3-greenie.gif" /></div>
    <div>
    
        <table cellpadding=5 cellspacing=1 width=620 id="productTable" align=center>
            <tr>
                <th style="width:100px"><a style="cursor:pointer;" onclick="Sort('orderid','productid');return false;">orderid</a><span id="productid" class="ordertip"></span></th>
                <th style="width:200px"><a style="cursor:pointer;" onclick="Sort('customerid','ProductName');return false;">customerid</a><span id="ProductName" class="ordertip"></span></th>
                <th style="width:200px"><a style="cursor:pointer;" onclick="Sort('shipname','UnitPrice');return false;">shipname</a><span id="UnitPrice" class="ordertip"></span></th>
                <th style="width:120px"><a style="cursor:pointer;" onclick="Sort('shipcity','Discontinued');return false;">shipcity</a><span id="Discontinued" class="ordertip"></span></th>
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