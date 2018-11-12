<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#aa").combobox({
            url:'${pageContext.request.contextPath}/album/queryByName',
            valueField:'id',
            textField:'title'
        });
    })
</script>

<div style="text-align: center;">
    <form id="insertChapterForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <div style="margin-top: 90px;">
            文章名称: <input type="text" name="title" class="easyui-textbox" >
        </div>
        <div style="margin-top: 20px;">
            下载路径: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            下载时间: <input type="text" name="uploadTime"  class="easyui-datebox">
        </div>
        <div style="margin-top: 20px;">
            专辑所属:
            <input id="aa" name="album_id"  data-options="width:159">
        </div>
    </form>
</div>