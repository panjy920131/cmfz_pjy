<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $('#tt').treegrid({
            url:'${pageContext.request.contextPath}/album/queryAll',
            pagination:true,//显示分页工具栏
            pageNumber:1,//当前页
            pageSize:5,//每页显示记录数
            pageList:[5,10,15,20,30,500],
            striped:true,
            rowNumbers:true,
            singleSelect:false,
            ctrlSelect:true,
            remoteSort:false,
            multiSort:true,
            fit:true,
            fitColumns:true,
            idField:'id',
            treeField:'title',
            toolbar:'#tb1',
            columns:[[
                //{title:'id',field:'id',width:100},
                {title:'名字',field:'title',width:100},
                {title:'下载路径',field:'downPath',width:100},
                {title:'文章大小',field:'size',width:100},
                {title:'文章时长',field:'duration',width:100}
            ]]
        });
    })

    //添加专辑
    function openAddAlbumDialog(){
        $("#addAlbumDialog").dialog({
            buttons:[{
                iconCls:'icon-save',
                text:'添加',
                handler:function(){
                    //保存信息
                    $("#insertAlbumForm").form('submit',{
                        url:'${pageContext.request.contextPath}/album/add',
                        success:function(result){//响应的一定是json格式字符串   使用应该先转为js对象
                            var resultObject=$.parseJSON(result);
                            if(resultObject.success){
                                //提示信息
                                $.messager.show({title:'提示',msg:"添加成功!!!"});
                            }else{
                                //提示信息
                                $.messager.show({title:'提示',msg:resultObject.message});
                            }
                            //关闭对话框
                            $("#addAlbumDialog").dialog('close');
                            //刷新
                            $("#tt").treegrid('reload');
                        }
                    });
                }
            },{
                iconCls:'icon-cancel',
                text:'关闭',
                handler:function(){
                    $("#addAlbumDialog").dialog('close');
                }
            }]
        });
    }

    //添加文章
    function openAddChapterDialog(){
        $("#addChapterDialog").dialog({
            buttons:[{
                iconCls:'icon-save',
                text:'添加',
                handler:function(){
                    //保存信息
                    $("#insertChapterForm").form('submit',{
                        url:'${pageContext.request.contextPath}/chapter/add',
                        success:function(result){//响应的一定是json格式字符串   使用应该先转为js对象
                            var resultObject=$.parseJSON(result);
                            if(resultObject.success){
                                //提示信息
                                $.messager.show({title:'提示',msg:"添加成功!!!"});
                            }else{
                                //提示信息
                                $.messager.show({title:'提示',msg:resultObject.message});
                            }
                            //关闭对话框
                            $("#addChapterDialog").dialog('close');
                            //刷新
                            $("#tt").treegrid('reload');
                        }
                    });
                }
            },{
                iconCls:'icon-cancel',
                text:'关闭',
                handler:function(){
                    $("#addChapterDialog").dialog('close');
                }
            }]
        });
    }

    //专辑详情
    function openAlbumDetailsDialog(){

        var jQuery = $("#tt").treegrid('getSelected');
        if(jQuery==null ||jQuery.size!=null){
            $.messager.show({title:'提示',msg:"请选中一个专辑!!!"});
        }else{
            $("#albumDetailsDialog").dialog({
                href:'${pageContext.request.contextPath}/back/album/albumDetails.jsp?id='+jQuery.id+"&img="+jQuery.coverImg,
            })
        }
    }

    //下载音频
    function openDownloadAudioDialog() {
        var c=$("#tt").treegrid('getSelected');
        $("#downloadAudioDialog").dialog({
            href:'${pageContext.request.contextPath}/back/album/downloadAudio.jsp?downPath='+c.downPath,
        })
    }
</script>
<%--工具栏--%>
<div id="tb1">
    <a href="#" class="easyui-linkbutton" onclick="openAlbumDetailsDialog();" data-options="iconCls:'icon-edit',plain:true">专辑详情</a>
    <a href="#" class="easyui-linkbutton" onclick="openAddAlbumDialog();" data-options="iconCls:'icon-save',plain:true">添加专辑</a>
    <a href="#" class="easyui-linkbutton" onclick="openAddChapterDialog();" data-options="iconCls:'icon-save',plain:true">添加章节</a>
    <a href="#" class="easyui-linkbutton" onclick="openDownloadAudioDialog();" data-options="iconCls:'icon-add',plain:true">下载音频</a>
</div>
<table id="tt" ></table>



<div id="albumDetailsDialog" data-options="href:'${pageContext.request.contextPath}/back/album/albumDetails.jsp',
        draggable:false,iconCls:'icon-save',width:500,height:470,title:'专辑详情'">
</div>
<div id="addAlbumDialog" data-options="href:'${pageContext.request.contextPath}/back/album/insertAlbum.jsp',
        draggable:false,iconCls:'icon-save',width:500,height:470,title:'添加专辑信息'">
</div>
<div id="addChapterDialog" data-options="href:'${pageContext.request.contextPath}/back/album/insertChapter.jsp',
        draggable:false,iconCls:'icon-save',width:500,height:470,title:'添加章节信息'">
</div>
<div id="downloadAudioDialog" data-options="href:'${pageContext.request.contextPath}/back/album/downloadAudio.jsp',
        draggable:false,iconCls:'icon-save',width:500,height:470,title:'下载音频'">
</div>
