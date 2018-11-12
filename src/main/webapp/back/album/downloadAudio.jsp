<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<div style="text-align: center;">
    <form id="savePicInputForm" class="easyui-form" method="post" >

        <div style="margin-top: 70px;">
            <a href="${pageContext.request.contextPath}/album/download?fileName=${param.downPath}
    &openStyle=attachment" class="easyui-linkbutton">下载</a>
        </div>
        <div style="margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/album/download?fileName=${param.downPath}
    &openStyle=inline" class="easyui-linkbutton">在线打开</a>
        </div>
    </form>
</div>