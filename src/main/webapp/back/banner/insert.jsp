<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<div style="text-align: center;">
    <form id="savePicInputForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <div style="margin-top: 70px;">
            名称: <input type="text" name="title" class="easyui-textbox" data-options="required:true">
        </div>
        <div style="margin-top: 20px;">
            路径: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            描述: <input type="text" name="description"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            状态: <input type="text" name="status"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            时间: <input type="text" name="creatTime"  class="easyui-datebox">
        </div>
    </form>
</div>