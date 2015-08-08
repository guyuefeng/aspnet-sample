<%@ Page Language="C#" AutoEventWireup="true" CodeFile="1.aspx.cs" Inherits="JqueryStorm_1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <script language="javascript" type="text/javascript">
          //防止客户端缓存JS文件造成数据更新不及时
          document.write("<script type='text/javascript' src='2.aspx?" + new Date() + "'></scr" + "ipt>");
          document.write("alert('adsfadfadf');");
</script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
