<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OpenXmlImportExcel.aspx.cs" Inherits="OpenXml_OpenXmlImportExcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="fCtrl" runat="server" />
        <br />
    </div>
    <div>
        <asp:Button ID="btnUpload" runat="server" Text="Upload" 
            onclick="btnUpload_Click" />
    </div>
    </form>
</body>
</html>
