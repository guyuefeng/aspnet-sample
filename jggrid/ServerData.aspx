<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="ServerData.aspx.cs" Inherits="jggrid_ServerData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


  <script type="text/javascript">

        
        $(document).ready(function() {
        $("#gridTable").jqGrid({
                url : 'test.json',
                datatype: 'json',
                height: 150,
                rowNum: 10,
                rowList: [10, 20, 30],
                colNames: ['Inv No', 'Date', 'Client', 'Amount', 'Tax', 'Total', 'Notes'],
                colModel: [
    				    { name: 'id', index: 'id', width: 60, sorttype: "int" },
                        { name: 'invdate', index: 'invdate', width: 90, sorttype: "date", formatter: "date" },
                        { name: 'name', index: 'name', width: 100 },
                        { name: 'amount', index: 'amount', width: 80, align: "right", sorttype: "float", formatter: "number" },
                        { name: 'tax', index: 'tax', width: 80, align: "right", sorttype: "float" },
                        { name: 'total', index: 'total', width: 80, align: "right", sorttype: "float" },
                        { name: 'note', index: 'note', width: 150, sortable: false }
                       ],
                jsonReader: {
                    repeatitems: false,
                    root: function(obj) { return obj; },
                    page: function(obj) { return 1; },
                    total: function(obj) { return 1; },
                    records: function(obj) { return obj.length; }
                },
                loadonce: true,
                sortname: 'id',
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

