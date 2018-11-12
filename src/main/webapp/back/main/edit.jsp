<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<div style="text-align: center;">
    <form id="editUserInputForm" class="easyui-form" method="post">
        <input type="hidden" name="id" value="${sessionScope.admin.id}">
        <div style="margin-top: 70px;">
            旧密码: <input type="text" name="oldPwd" class="easyui-textbox" data-options="">
        </div>

        <div style="margin-top: 20px;">
            新密码: <input type="text" name="password"  class="easyui-textbox">
        </div>
    </form>
</div>