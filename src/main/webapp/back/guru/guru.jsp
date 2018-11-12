<%@page pageEncoding="UTF-8" isELIgnored="false" %>
    <script>
        $(function () {
            //通过js创建datagrid
            $("#d").datagrid({
                url:'${pageContext.request.contextPath}/guru/findAll',//用来请求远程数据
                pagination:true,//显示分页工具栏
                pageNumber:1,//当前页
                pageSize:5,//每页显示记录数
                pageList:[2,5,10,15,20,30,500],
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
                    {title:'名字',field:'niname',width:120,},
                    {title:'头像路径',field:'headPic',width:140},
                    {title:'性别',field:'sex',width:120},
                    {title:'options',field:'options',width:200,
                        formatter:function(value,row,index){
                            return "<a href='javascript:;' class='options' onclick=\"delRow('"+row.id+"')\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>&nbsp;&nbsp;" +
                                "<a href='javascript:;' class='options' onclick=\"openEditGuruDialog('"+row.id+"')\" data-options=\"iconCls:'icon-edit',plain:true\">更新</a>";
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
                        '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/'+rowData.headPic+'" style="height:55px;"></td>' +
                        '<td style="border:0">' +
                        '<p>NiName: ' + rowData.niname + '</p>' +
                        '<p>Sex: ' + rowData.sex + '</p>' +
                        '</td>' +
                        '</tr></table>';
                }


            });


        });


        //打开修改的对话框
        function openEditGuruDialog(id){
            $("#editGuruDialog").dialog({
                href:'${pageContext.request.contextPath}/back/guru/update.jsp?id='+id,
                buttons:[
                    {
                        iconCls:'icon-edit',
                        text:"修改",
                        handler:function(){
                            $("#insertGuruInputForm").form('submit',{
                                url:"${pageContext.request.contextPath}/guru/motify",
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
                                    $("#editGuruDialog").dialog('close');
                                    //刷新datagrid
                                    $("#d").datagrid('reload');
                                }
                            })
                        }
                    },
                    {
                        iconCls:'icon-cancel',
                        text:"取消",
                        handler:function(){
                            $("#editGuruDialog").dialog('close');
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
                    $.post("${pageContext.request.contextPath}/guru/remove",{"id":id},function (result) {//响应成功之后回调
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid数据
                        $("#d").datagrid('reload');//刷新当前datagrid
                    });
                }
            });



        }

       //添加
        function openAddGuruDialog(){
            $("#saveGuruDialog").dialog({
                buttons:[{
                    iconCls:'icon-save',
                    text:'添加',
                    handler:function(){
                        //保存信息
                        $("#insertPicInputForm").form('submit',{
                            url:'${pageContext.request.contextPath}/guru/add',
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
                                $("#saveGuruDialog").dialog('close');
                                //刷新datagrid
                                $("#d").datagrid('reload');
                            }
                        });
                    }
                },{
                    iconCls:'icon-cancel',
                    text:'关闭',
                    handler:function(){
                        $("#saveGuruDialog").dialog('close');
                    }
                }]
            });
        }

        //批量删除多行
        function delBatchRows(){
            var rows = $("#d").datagrid('getSelections');
            if(rows.length<=0){
                $.messager.show({title:'提示',msg:"至少选中一行!!!"});
            }else{
                var ids = [];
                for (var i = 0; i < rows.length ; i++) {
                    console.log(rows[i].id);
                    ids.push(rows[i].id);
                }
                $.ajax({
                    url:"${pageContext.request.contextPath}/guru/removeAll",
                    type:"POST",
                    traditional:true,//传递数据类型的数据时必须设置这个属性为true
                    data:{id:ids},
                    success:function(result){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid
                        $("#d").datagrid('reload');
                    },
                    error:function(){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除失败!!!"});
                        //刷新datagrid
                        $("#d").datagrid('reload');
                    }
                })
            }
        }
    </script>




<%--datagrid数据表格--%>
<table id="d"></table>

<%--datagrid工具栏--%>
<div id="tb">
    <a href="#" class="easyui-linkbutton" onclick="openAddGuruDialog();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <%--<a href="#" class="easyui-linkbutton" onclick="openSavePicDialog();" data-options="iconCls:'icon-save',plain:true">保存</a>--%>
    <a href="#" class="easyui-linkbutton" onclick="delBatchRows();" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
</div>

<%--添加对话框--%>
        <div id="saveGuruDialog" data-options="href:'${pageContext.request.contextPath}/back/guru/insert.jsp',
        draggable:false,iconCls:'icon-save',width:600,height:400,title:'添加上师信息'">
</div>

<%--更新对话框--%>
        <div id="editGuruDialog" data-options="draggable:false,iconCls:'icon-edit',width:600,height:400,
        title:'更新上师信息'"></div>




