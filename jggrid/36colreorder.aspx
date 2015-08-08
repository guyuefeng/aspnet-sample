<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="36colreorder.aspx.cs" Inherits="jggrid_36colreorder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--<script src="36ajaxing.js" type="text/javascript"> </script>--%>
<script type="text/javascript">


    $(document).ready(function() {
    jQuery("#jqgajax").jqGrid({
    sortable: true,
        url: 'handlers/36ajaxing.ashx',
        datatype: "json",
        colNames: ['Inv No', 'Date', 'Client', 'Amount', 'Tax', 'Total', 'Notes'],
        colModel: [
   		{ name: 'id', index: 'id', width: 55 },
   		{ name: 'invdate', index: 'invdate', width: 90 },
   		{ name: 'name', index: 'name asc, invdate', width: 100 },
   		{ name: 'amount', index: 'amount', width: 80, align: "right" },
   		{ name: 'tax', index: 'tax', width: 80, align: "right" },
   		{ name: 'total', index: 'total', width: 80, align: "right" },
   		{ name: 'note', index: 'note', width: 150, sortable: false }
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
        rowNum: 10,
        width: 700,
        rowList: [10, 20, 30],
        pager: '#pjqgajax',
        sortname: 'invdate',
        viewrecords: true,
        sortorder: "desc",
        caption: "New API Example"
        
        
                       
    });
    

    });
    
    
</script>

<table id="jqgajax"></table>
<div id="pjqgajax"></div>

</asp:Content>

