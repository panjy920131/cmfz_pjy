<%@page pageEncoding="UTF-8" isELIgnored="false" %>

<div style="text-align: center;">
    <form id="saveCourseForm" class="easyui-form" method="post" >
        <div style="margin-top: 70px;">
            名称: <input type="text" name="title" class="easyui-textbox" data-options="required:true">
        </div>
        <div style="margin-top: 20px;">
            标记: <input type="text" name="marking"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            时间: <input type="text" name="createTime"  class="easyui-datebox">
        </div>
    </form>
</div>