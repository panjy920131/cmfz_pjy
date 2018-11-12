<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#editArticleForm").form('load','${pageContext.request.contextPath}/article/queryOne?id=${param.id}');
    })
</script>
<div style="text-align: center;">
    <form id="editArticleForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${param.id}">
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
    </form>
</div>