$(document).ready(function(){
    $("#export").dialog({autoOpen:false,zIndex:100});
   
    $("#btnExport").bind("click",function(){
        $("#export").dialog("open");
    });
    
    $("#btnImport").bind("click",function(){
        $("#import").dialog("open");
    });
    
    $("#btnBeginExport").bind("click",function(){
        var fileName = $.trim($("#txtFileName").val());
        if(fileName.length==0){
            alert("请输入要导出的文件名");
            return;
        }
        $("#export").dialog("close");
        var loading = new ol.loading({id:"content"});
        loading.show();
        $.ajax({
            url:'handler/product_category.ashx',
            data:'action=export&fileName='+fileName,
            type:'post',
            dataType:'json',
            success:function(res){
                if(res.message=="success"){
                    loading.hide();
                    $("#download").attr("href","export/"+fileName+".xls");
                    $("#message").dialog("open");
                }
            },
            error:function(res){
                loading.hide();
                alert(res.responseText);
            }
        });
    });
    $('#file_upload').uploadify({
        'uploader'  : 'flash/uploadify.swf',
        'script'    : 'handler/product_category.ashx',
        'cancelImg' : 'image/cancel.png',
        'folder'    : 'import/',
        'auto'      : true,
        'buttonText': '选择上传文件',
        'sizeLimit': 200*1024,
        'fileExt': '*.xls',
        'fileDesc': 'Excel 文件',
        'onSelect':function(e, queueId, fileObj){
            if(fileObj.size>200*1024){
                alert("文件太大，请保持文件在200KB以内");
                return;
            }
        },
        'onComplete':function(event,queueId,fileObj,response,data){
            alert("数据导入成功");
            window.location.href="product_category.aspx";
        }
    });
});