<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="ServerPagin（Final）.aspx.cs" Inherits="jggrid_ServerPagin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <script type="text/javascript">
        $(document).ready(function() {
            $("#gridTable").jqGrid({
                url: 'handlers/myorder3.ashx',
                datatype: 'json',
                width: 800,
                height: 400,
                rowNum: 10,
                rowList: [20, 50, 100],
                colNames: ['订单ID', '客户ID', '送货人', '下单时间'],
                colModel: [
    				    { name: 'OrderID', index: 'OrderID', width: 200 },
                        { name: 'CustomerID', index: 'CustomerID', width: 200 },
                        { name: 'ShipName', index: 'ShipName', width: 200 },
                        { name: 'OrderDate', index: 'OrderDate', width: 200 }
                       ],
                jsonReader: {
                    repeatitems: false,
                    root: function(obj) { return obj.rows; },
                    page: function(obj) { return obj.pageindex; },
                    total: function(obj) { return obj.pagecount; },
                    records: function(obj) { return obj.total; }
                },
                prmNames: {
                    page: 'PageIndex',
                    rows: 'PageSize',
                    sort: 'OrderBy',
                    order: 'Sort'
                },
                loadonce: false,
                sortname: 'OrderID',
                sortorder: 'desc',
                pager: "#gridPager",
                viewrecords: true,
                caption: "Manipulating Array Data"
            });
        });
        
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            function content_resize() {
                var grid = $("#gridTable");
                var h = $(window).height() - grid.offset().top - 50;
                $('.ui-jqgrid-bdiv').css("height", h);
            }

            $(window).wresize(content_resize);

            content_resize();
        });
    </script>

    <table id="gridTable">
    </table>
    <div id="gridPager">
    </div>
    
</asp:Content>

