<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<div style="text-align: center;">
    <form id="addUserInputForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <div style="margin-top: 40px;">
            电话号码: <input type="text" name="phoneNum"  class="easyui-textbox">&nbsp;&nbsp;&nbsp;&nbsp;
            用户姓名: <input type="text" name="username"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            用户密码: <input type="text" name="password" class="easyui-textbox" >&nbsp;&nbsp;&nbsp;&nbsp;
            盐&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值: <input type="text" name="salt"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            所在省份: <input type="text" name="province"  class="easyui-textbox">&nbsp;&nbsp;&nbsp;&nbsp;
            所在城市: <input type="text" name="city"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            法&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名: <input type="text" name="nickName"  class="easyui-textbox">&nbsp;&nbsp;&nbsp;&nbsp;
            性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:
            <select class="easyui-combobox" name="sex"  data-options="width:159">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
        <div style="margin-top: 20px;">
            签&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名: <input type="text" name="sign"  class="easyui-textbox">&nbsp;&nbsp;&nbsp;&nbsp;
            头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态: <input type="text" name="status"  class="easyui-textbox">&nbsp;&nbsp;&nbsp;&nbsp;
            注册时间: <input type="text" name="joinTime"  class="easyui-datebox">
        </div>
    </form>
</div>