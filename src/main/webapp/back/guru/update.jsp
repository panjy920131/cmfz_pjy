<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#insertGuruInputForm").form('load','${pageContext.request.contextPath}/guru/queryOne?id=${param.id}');
    })
</script>
<div style="text-align: center;">
    <form id="insertGuruInputForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${param.id}">
        <div style="margin-top: 70px;">
            名称: <input type="text" name="niname" class="easyui-textbox" data-options="required:true">
        </div>
        <div style="margin-top: 20px;">
            路径: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            性别:
            <select class="easyui-combobox" name="sex"  data-options="width:159">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>

    </form>
</div>