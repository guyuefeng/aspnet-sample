<%@ Control Language="C#" AutoEventWireup="true" CodeFile="pagination1.ascx.cs" Inherits="userControl_pagination1" %>
<style type="text/css">
.pagination{
 overflow:hidden;
 margin:0;
 padding:10px 10px 6px 10px;
 _zoom:1;
}
.pagination *{
 display:inline;
 float:left;
 margin:0;
 padding:0;
 font-size:12px;
}
.currentPage b{
 float:none;
 color:#f00;
}
.pagination li{
 list-style:none;
 margin:0 5px;
}
.pagination li li{
 position:relative;
 margin:-2px 0 0;
 font-family: Arial, Helvetica, sans-serif
}
.firstPage a,.previousPage a,.nextPage a,.lastPage a{
 overflow:hidden;
 height:0;
 text-indent:-9999em;
 border-top:8px solid #fff;
 border-bottom:8px solid #fff;
}
.pagination li li a{
 margin:0 1px;
 padding:0 4px;
 border:3px double #fff;
 +border-color:#eee;
 background:#eee;
 color:#06f;
 text-decoration:none;
}
.pagination li li a:hover{
 background:#f60;
 border-color:#fff;
 +border-color:#f60;
 color:#fff;
}
li.firstPage{
 margin-left:40px;
 border-left:3px solid #06f;
}
.firstPage a,.previousPage a{
 border-right:12px solid #06f;
}
.firstPage a:hover,.previousPage a:hover{
 border-right-color: #f60;
}
.nextPage a,.lastPage a{
 border-left:12px solid #06f;
}
.nextPage a:hover,.lastPage a:hover{
 border-left-color:#f60;
}
li.lastPage{
 border-right:3px solid #06f;
}
li li.currentState a{
 position:relative;
 margin:-1px 3px;
 padding:1px 4px;
 border:3px double #fff;
 +border-color:#f60;
 background:#f60;
 color:#fff;
}
li.currentState,.currentState a,.currentState a:hover{
 border-color:#fff #ccc;
 cursor:default;
}
</style>
<div class="pagination">
    <ul>
        <li>
            <%=paginationStr%><br />
        </li>
    </ul>
</div>
