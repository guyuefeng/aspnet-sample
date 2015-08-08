<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="jggrid_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type ="text/javascript" >
    var mydata = [
{ id: "1", invdate: "2012-05-24", name: "test1", note: "note", tax: "10.00", total: "2111.00", sort: 1 },
{ id: "2", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 3 },
{ id: "2", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 4 },

{ id: "3", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 6 },
{ id: "4", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 4 },
{ id: "52", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 3 },
{ id: "6", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 12 },
{ id: "7", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 13 },
{ id: "8", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 14 },
{ id: "9", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 15 },
{ id: "12", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 16 },
{ id: "22", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 18 },
{ id: "32", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 20 },
{ id: "42", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 21 },
{ id: "52", invdate: "2012-01-24", name: "test2", note: "note", tax: "20.00", total: "3111.00", sort: 22 }
];

$(document).ready(function() {
    $("#gridtable").jqGrid({
        data: mydata,
        datatype: "local",
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
        sortname: 'id',
        sortorder: 'desc',
        pager: "#gridpager",
        viewrecords: true,
        caption: "Manipulating Array Data"
    });
});

</script>

<table id="gridtable"></table>

<div id="gridpager"></div>
</asp:Content>

