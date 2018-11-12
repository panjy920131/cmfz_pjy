<%@page pageEncoding="UTF-8" isELIgnored="false" %>
    <script>
        $(function () {
            //通过js创建datagrid
            $("#bgs").datagrid({
                url:'${pageContext.request.contextPath}/article/queryAll',//用来请求远程数据
                fit:true,
                fitColumns:true,
                columns:[[
                    {title:'cks',field:"cks",checkbox:true},
                    //{title:'上师名称',field:'niname',width:120},
                    {title:'文章名称',field:'title',width:120,},
                    {title:'路径',field:'imgPath',width:140},
                    {title:'内容',field:'content',width:120},
                    {title:'上传时间',field:'publishDate',width:120},
                    {title:'操作',field:'options',width:200,
                        formatter:function(value,row,index){
                            return "<a href='javascript:;' class='options' onclick=\"dellRow('"+row.id+"')\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>&nbsp;&nbsp;" +
                                "<a href='javascript:;' class='options' onclick=\"openEditArticleDialog('"+row.id+"')\" data-options=\"iconCls:'icon-edit',plain:true\">更新</a>";
                        }
                    },

                ]],
                onLoadSuccess:function () {
                    $(".options").linkbutton();
                },
                toolbar:'#tbs',
                view: detailview,
                detailFormatter: function(rowIndex, rowData){
                    return '<table><tr>' +
                        '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/'+rowData.imgPath+'" style="height:55px;"></td>' +
                        '<td style="border:0">' +
                        '<p>Title: ' + rowData.title + '</p>' +
                        '<p>Content: ' + rowData.content + '</p>' +
                        '</td>' +
                        '</tr></table>';
                }
            });
        });


        //打开修改的对话框
        function openEditArticleDialog(id){
            $("#editArticleDialog").dialog({
                href:'${pageContext.request.contextPath}/back/article/update.jsp?id='+id,
                buttons:[
                    {
                        iconCls:'icon-edit',
                        text:"修改",
                        handler:function(){
                            $("#editArticleForm").form('submit',{
                                url:"${pageContext.request.contextPath}/article/motify",
                                success:function (result) {//注意一定是json字符串  使用需要转为js对象
                                    var resultObject=$.parseJSON(result);
                                    if(resultObject.success){
                                        //提示信息
                                        $.messager.show({title:'提示',msg:"修改成功!!!"});
                                    }else{
                                        //提示信息
                                        $.messager.show({title:'提示',msg:resultObject.message});
                                    }
                                    //关闭dialog
                                    $("#editArticleDialog").dialog('close');
                                    //刷新datagrid
                                    $("#bgs").datagrid('reload');
                                }
                            })
                        }
                    },
                    {
                        iconCls:'icon-cancel',
                        text:"取消",
                        handler:function(){
                            $("#editArticleDialog").dialog('close');
                        }
                    },
                ]
            });

        }

        //删除一行的事件
        function dellRow(id){
            $.messager.confirm('确认对话框', '您确定要删除吗？', function(r){
                if (r){
                    //获取当前点击id发送ajax请求删除id这个人的信息
                    $.post("${pageContext.request.contextPath}/article/remove",{"id":id},function (result) {//响应成功之后回调
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid数据
                        $("#bgs").datagrid('reload');//刷新当前datagrid
                    });
                }
            });



        }

       //添加
        function openAddArticleDialog(){
            $("#saveArticleDialog").dialog({
                buttons:[{
                    iconCls:'icon-save',
                    text:'添加',
                    handler:function(){
                        //保存信息
                        $("#saveArticleForm").form('submit',{
                            url:'${pageContext.request.contextPath}/article/add',
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
                                $("#saveArticleDialog").dialog('close');
                                //刷新datagrid
                                $("#bgs").datagrid('reload');
                            }
                        });
                    }
                },{
                    iconCls:'icon-cancel',
                    text:'关闭',
                    handler:function(){
                        $("#saveArticleDialog").dialog('close');
                    }
                }]
            });
        }

        //批量删除多行
        function deleteAllRows(){
            var rows = $("#bgs").datagrid('getSelections');
            if(rows.length<=0){
                $.messager.show({title:'提示',msg:"至少选中一行!!!"});
            }else{
                var ids = [];
                for (var i = 0; i < rows.length ; i++) {
                    console.log(rows[i].id);
                    ids.push(rows[i].id);
                }
                $.ajax({
                    url:"${pageContext.request.contextPath}/article/removeAll",
                    type:"POST",
                    traditional:true,//传递数据类型的数据时必须设置这个属性为true
                    data:{id:ids},
                    success:function(result){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid
                        $("#bgs").datagrid('reload');
                    },
                    error:function(){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除失败!!!"});
                        //刷新datagrid
                        $("#bgs").datagrid('reload');
                    }
                })
            }
        }
    </script>




<%--datagrid数据表格--%>
<table id="bgs"></table>

<%--datagrid工具栏--%>
<div id="tbs">
    <a href="#" class="easyui-linkbutton" onclick="openAddArticleDialog();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="deleteAllRows();" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
</div>

<%--添加对话框--%>
        <div id="saveArticleDialog" data-options="href:'${pageContext.request.contextPath}/back/article/insert.jsp',
        draggable:false,iconCls:'icon-save',width:600,height:400,title:'添加文章信息'">
</div>

<%--更新对话框--%>
        <div id="editArticleDialog" data-options="draggable:false,iconCls:'icon-edit',width:600,height:400,
        title:'更新文章信息'"></div>




