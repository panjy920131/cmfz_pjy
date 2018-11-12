<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function(){
        $("#saveAlbumDetailsForm").form('load','${pageContext.request.contextPath}/album/queryOne?id=${param.id}')
        })
</script>
<div style="text-align: center;">
    <form id="saveAlbumDetailsForm" class="easyui-form" method="post" enctype="multipart/form-data">
        <img src="${pageContext.request.contextPath}/${param.img}" style="width:90px;height:90px;margin-top:15px;">
        <div style="margin-top: 22px;">
            名称: <input type="text" name="title" class="easyui-textbox" >
        </div>
        <div style="margin-top: 20px;">
            时间: <input type="text" name="publishDate"  class="easyui-textbox">
        </div>
        <div style="margin-top: 20px;">
            数量: <input type="text" name="counts"  class="easyui-textbox">
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