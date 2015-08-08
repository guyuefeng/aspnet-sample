<%@ Page Title="" Language="C#" MasterPageFile="~/jqgriddemo/Main.master" AutoEventWireup="true" CodeFile="XML_Data.aspx.cs" Inherits="jqgriddemo_XML_Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script type="text/javascript">
    jQuery().ready(function() {
        jQuery("#list1").jqGrid({
            url: 'XML_Data.ashx',
            datatype: "xml",
            colNames: ['Inv No', 'Date', 'Client', 'Amount', 'Tax', 'Total', 'Notes'],
            colModel: [
   		{ name: 'id', index: 'id', width: 75 },
   		{ name: 'invdate', index: 'invdate', width: 90 },
   		{ name: 'name', index: 'name', width: 100 },
   		{ name: 'amount', index: 'amount', width: 80, align: "right" },
   		{ name: 'tax', index: 'tax', width: 80, align: "right" },
   		{ name: 'total', index: 'total', width: 80, align: "right" },
   		{ name: 'note', index: 'note', width: 150, sortable: false }
   	],
            rowNum: 10,
            autowidth: true,
            rowList: [10, 20, 30],
            pager: jQuery('#pager1'),
            sortname: 'id',
            viewrecords: true,
            sortorder: "desc",
            caption: "XML Example"
        }).navGrid('#pager1', { edit: false, add: false, del: false });

    });

					
</script> 

<table id="list1"></table>
<div id="pager1"></div>

</asp:Content>

