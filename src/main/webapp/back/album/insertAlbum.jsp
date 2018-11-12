<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<div style="text-align: center;">
    <form id="insertAlbumForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <div style="margin-top: 60px;">
            名称: <input type="text" name="title" class="easyui-textbox" >
        </div>
        <div style="margin-top: 20px;">
            时间: <input type="text" name="publishDate"  class="easyui-datebox">
        </div>
        <div style="margin-top: 20px;">
            封面: <input type="text" name="file"  class="easyui-filebox">
        </div>
        <div style="margin-top: 20px;">
            级别: <input type="text" name="star"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            作者: <input type="text" name="author"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            播音: <input type="text" name="broadCast"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            简介: <input type="text" name="brief"  class="easyui-textbox">
        </div>
    </form>
</div>