﻿<%@ Page Title="" Language="C#" MasterPageFile="~/jggrid/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="jggrid_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script type="text/javascript">
        var mydata = [
        { id: "1", invdate: "2010-05-24", name: "test", note: "note", tax: "10.00", total: "2111.00" },
        { id: "2", invdate: "2010-05-25", name: "test2", note: "note2", tax: "20.00", total: "320.00" },
        { id: "3", invdate: "2007-09-01", name: "test3", note: "note3", tax: "30.00", total: "430.00" },
        { id: "4", invdate: "2007-10-04", name: "test", note: "note", tax: "10.00", total: "210.00" },
        { id: "5", invdate: "2007-10-05", name: "test2", note: "note2", tax: "20.00", total: "320.00" },
        { id: "6", invdate: "2007-09-06", name: "test3", note: "note3", tax: "30.00", total: "430.00" },
        { id: "7", invdate: "2007-10-04", name: "test", note: "note", tax: "10.00", total: "210.00" },
        { id: "8", invdate: "2007-10-03", name: "test2", note: "note2", amount: "300.00", tax: "21.00", total: "320.00" },
        { id: "9", invdate: "2007-09-01", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" }, 
        { id: "11", invdate: "2007-10-01", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "12", invdate: "2007-10-02", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "13", invdate: "2007-09-01", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" },
        { id: "14", invdate: "2007-10-04", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "15", invdate: "2007-10-05", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "16", invdate: "2007-09-06", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" },
        { id: "17", invdate: "2007-10-04", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "18", invdate: "2007-10-03", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "19", invdate: "2007-09-01", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" },
        { id: "21", invdate: "2007-10-01", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "22", invdate: "2007-10-02", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "23", invdate: "2007-09-01", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" },
        { id: "24", invdate: "2007-10-04", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "25", invdate: "2007-10-05", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "26", invdate: "2007-09-06", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00" },
        { id: "27", invdate: "2007-10-04", name: "test", note: "note", amount: "200.00", tax: "10.00", total: "210.00" },
        { id: "28", invdate: "2007-10-03", name: "test2", note: "note2", amount: "300.00", tax: "20.00", total: "320.00" },
        { id: "29", invdate: "2007-09-01", name: "test3", note: "note3", amount: "400.00", tax: "30.00", total: "430.00"}];
        
        $(document).ready(function() {
            $("#gridTable").jqGrid({
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

