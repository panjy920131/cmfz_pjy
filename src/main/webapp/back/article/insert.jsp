<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#a").combobox({
            url:'${pageContext.request.contextPath}/guru/findByName',
            valueField:'id',
            textField:'niname'
        });
    })
</script>
<div style="text-align: center;">
    <form id="saveArticleForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <div style="margin-top: 70px;">
            名称: <input type="text" name="title" class="easyui-textbox" data-options="required:true">
        </div>
        <div style="margin-top: 20px;">
            路径: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            简介: <input type="text" name="content"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            时间: <input type="text" name="publishDate"  class="easyui-datebox">
        </div>
        <div style="margin-top: 20px;">
            所属: <input id="a"  name="guru_id"  data-options="width:159">
        </div>
    </form>
</div>