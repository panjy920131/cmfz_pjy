<%@page pageEncoding="UTF-8" isELIgnored="false" %>
    <script>
        $(function () {
            //通过js创建datagrid
            $("#dg1").datagrid({
                url:'${pageContext.request.contextPath}/banner/findAll',//用来请求远程数据
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
                fitColumns:true,//  自动展开/收缩列的大小
                columns:[[
                    {title:'cks',field:"cks",checkbox:true},
                    {title:'id',field:'id',width:110},
                    {title:'名字',field:'title',width:120,},
                    {title:'路径',field:'imgPath',width:140},
                    {title:'标题',field:'description',width:120},
                    {title:'状态',field:'status',width:120},
                    {title:'时间',field:'creatTime',width:120},
                    {title:'options',field:'options',width:200,
                        formatter:function(value,row,index){
                            return "<a href='javascript:;' class='options' onclick=\"delRow('"+row.id+"')\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>&nbsp;&nbsp;" +
                                "<a href='javascript:;' class='options' onclick=\"openEditUserDialog('"+row.id+"')\" data-options=\"iconCls:'icon-edit',plain:true\">更新</a>";
                        }
                    },

                ]],
                onLoadSuccess:function () {
                    $(".options").linkbutton();
                },
                toolbar:'#tb',
                view: detailview,
                detailFormatter: function(rowIndex, rowData){
                    return '<table><tr>' +
                        '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/'+rowData.imgPath+'" style="height:55px;"></td>' +
                        '<td style="border:0">' +
                        '<p>Attribute: ' + rowData.title + '</p>' +
                        '<p>Status: ' + rowData.status + '</p>' +
                        '</td>' +
                        '</tr></table>';
                }


            });


        });


        //打开修改的对话框
        function openEditUserDialog(id){
            $("#editPicDialog").dialog({
                href:'${pageContext.request.contextPath}/back/banner/update.jsp?id='+id,
                buttons:[
                    {
                        iconCls:'icon-edit',
                        text:"修改",
                        handler:function(){
                            $("#editPicInputForm").form('submit',{
                                url:"${pageContext.request.contextPath}/banner/motify",
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
                                    $("#editPicDialog").dialog('close');
                                    //刷新datagrid
                                    $("#dg1").datagrid('reload');
                                }
                            })
                        }
                    },
                    {
                        iconCls:'icon-cancel',
                        text:"取消",
                        handler:function(){
                            $("#editPicDialog").dialog('close');
                        }
                    },
                ]
            });

        }

        //删除一行的事件
        function delRow(id){
            $.messager.confirm('确认对话框', '您确定要删除吗？', function(r){
                if (r){
                    //获取当前点击id发送ajax请求删除id这个人的信息
                    $.post("${pageContext.request.contextPath}/banner/remove",{"id":id},function (result) {//响应成功之后回调
                         $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid数据
                        $("#dg1").datagrid('reload');//刷新当前datagrid
                    });
                }
            });
        }

       //添加
        function openAddPicDialog(){
            $("#savePicDialog").dialog({
                buttons:[{
                    iconCls:'icon-save',
                    text:'添加',
                    handler:function(){
                        //保存信息
                        $("#savePicInputForm").form('submit',{
                            url:'${pageContext.request.contextPath}/banner/add',
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
                                $("#savePicDialog").dialog('close');
                                //刷新datagrid
                                $("#dg1").datagrid('reload');
                            }
                        });
                    }
                },{
                    iconCls:'icon-cancel',
                    text:'关闭',
                    handler:function(){
                        $("#savePicDialog").dialog('close');
                    }
                }]
            });
        }

        //批量删除多行
        function delBatchRows(){
            var rows = $("#dg1").datagrid('getSelections');
            if(rows.length<=0){
                $.messager.show({title:'提示',msg:"至少选中一行!!!"});
            }else{
                var ids = [];
                for (var i = 0; i < rows.length ; i++) {
                    ids.push(rows[i].id);
                }
                $.ajax({
                    url:"${pageContext.request.contextPath}/banner/removeAll",
                    type:"POST",
                    traditional:true,//传递数据类型的数据时必须设置这个属性为true
                    data:{id:ids},
                    success:function(result){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid
                        $("#dg1").datagrid('reload');
                    },
                    error:function(){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除失败!!!"});
                        //刷新datagrid
                        $("#dg1").datagrid('reload');
                    }
                })
            }
        }
    </script>




<%--datagrid数据表格--%>
<table id="dg1"></table>

<%--datagrid工具栏--%>
<div id="tb">
    <a href="#" class="easyui-linkbutton" onclick="openAddPicDialog();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="delBatchRows();" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
</div>

<%--添加图片对话框--%>
        <div id="savePicDialog" data-options="href:'${pageContext.request.contextPath}/back/banner/insert.jsp',
        draggable:false,iconCls:'icon-save',width:600,height:400,title:'添加图片信息'">
</div>

<%--更新图片对话框--%>
        <div id="editPicDialog" data-options="draggable:false,iconCls:'icon-edit',width:600,height:400,
        title:'更新图片信息'"></div>




