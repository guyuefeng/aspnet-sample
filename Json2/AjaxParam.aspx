<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxParam.aspx.cs" Inherits="Json2_AjaxParam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>jQuery Ajax - param </title>
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function console(text) {
            $("#divMsg").append("<div>" + text + "</div>");
        }

        $(function () {
            $("#btnParam").click(function (e) {

                console($.param([1, 2, 3, 4])); //undefined=undefined&undefined=undefined&undefined=undefined&undefined=undefined
                console($.param({ a: 1, b: 2 })); //a=1&b=2

                var myObject = {
                    a: {
                        one: 1,
                        two: 2,
                        three: 3
                    },
                    b: [1, 2, 3]
                };
                var recursiveEncoded = $.param(myObject);
                var recursiveDecoded = decodeURIComponent($.param(myObject));

                console(recursiveEncoded);
                //output：a%5Bone%5D=1&a%5Btwo%5D=2&a%5Bthree%5D=3&b%5B%5D=1&b%5B%5D=2&b%5B%5D=3
                console(recursiveDecoded);
                //output：a[one]=1&a[two]=2&a[three]=3&b[]=1&b[]=2&b[]=3

                var shallowEncoded = $.param(myObject, true);
                var shallowDecoded = decodeURIComponent(shallowEncoded);
                console(shallowEncoded);
                //output：a=%5Bobject+Object%5D&b=1&b=2&b=3
                console(shallowDecoded);
                //output：a=[object+Object]&b=1&b=2&b=3

            });
        })
    </script>

</head>
<body>    
    <input id="inputObj" value="{ name:'liguofeng', age: '999' }" style="width:80%;"/>
    <br />
    <button id="btnParam">$.Param</button>
    <br />
    <div id="divMsg"></div>
</body>
</html>
