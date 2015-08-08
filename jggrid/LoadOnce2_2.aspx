<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="LoadOnce2_2.aspx.cs" Inherits="jggrid_LoadOnce2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <script type="text/javascript">
        $(document).ready(function() {
            $("#gridTable").jqGrid({
                url: 'handlers/myorder2.ashx',
                datatype: 'json',
                height: 250,
                rowNum: 10,
                rowList: [10, 20, 30],
                colNames: ['订单ID', '客户ID', '送货人', '下单时间'],
                colModel: [
    				    { name: 'OrderID', index: 'OrderID', width: 100 },
                        { name: 'CustomerID', index: 'CustomerID', width: 100 },
                        { name: 'ShipName', index: 'ShipName', width: 160 },
                        { name: 'OrderDate', index: 'OrderDate', width: 160 }
                       ],
                jsonReader: {
                    root: "rows",
                    page: "pageindex",
                    total: "pagecount",
                    records: "total",
                    repeatitems: false
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

    <table id="gridTable">
    </table>
    <div id="gridPager">
    </div>
    
</asp:Content>

