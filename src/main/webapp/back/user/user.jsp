<%@page pageEncoding="UTF-8" isELIgnored="false" %>
    <script>
        $(function () {
            //通过js创建datagrid
            $("#dgr").datagrid({
                url:'${pageContext.request.contextPath}/me/findAll',//用来请求远程数据
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
                    {title:'电话号码',field:'phoneNum',width:120,},
                    {title:'用户名',field:'username',width:140},
                    {title:'密码',field:'password',width:120},
                    {title:'盐值',field:'salt',width:120},
                    {title:'省份',field:'province',width:120},
                    {title:'城市',field:'city',width:120},
                    {title:'法名',field:'nickName',width:120},
                    {title:'性别',field:'sex',width:120},
                    {title:'签名',field:'sign',width:120},
                    {title:'头像',field:'headPic',width:120},
                    {title:'状态',field:'status',width:120},
                    {title:'注册时间',field:'joinTime',width:120},
                    {title:'options',field:'options',width:200,
                        formatter:function(value,row,index){
                            return "<a href='javascript:;' class='options' onclick=\"delRow('"+row.id+"')\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>&nbsp;&nbsp;" +
                                "<a href='javascript:;' class='options' onclick=\"openUpdateUserDialog('"+row.id+"')\" data-options=\"iconCls:'icon-edit',plain:true\">更新</a>";
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
                        '<p>Username: ' + rowData.username + '</p>' +
                        '<p>Status: ' + rowData.status + '</p>' +
                        '</td>' +
                        '</tr></table>';
                }


            });


        });


        //打开修改的对话框
        function openUpdateUserDialog(id){
            $("#updateUserDialog").dialog({
                href:'${pageContext.request.contextPath}/back/user/update.jsp?id='+id,
                buttons:[
                    {
                        iconCls:'icon-edit',
                        text:"修改",
                        handler:function(){
                            $("#updateUserForm").form('submit',{
                                url:"${pageContext.request.contextPath}/me/motify",
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
                                    $("#updateUserDialog").dialog('close');
                                    //刷新datagrid
                                    $("#dgr").datagrid('reload');
                                }
                            })
                        }
                    },
                    {
                        iconCls:'icon-cancel',
                        text:"取消",
                        handler:function(){
                            $("#updateUserDialog").dialog('close');
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
                    $.post("${pageContext.request.contextPath}/me/remove",{"id":id},function (result) {//响应成功之后回调
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid数据
                        $("#dgr").datagrid('reload');//刷新当前datagrid
                    });
                }
            });



        }


    </script>




<%--datagrid数据表格--%>
<table id="dgr"></table>

<%--datagrid工具栏
<div id="tb">

    <a href="#" class="easyui-linkbutton" onclick="deleteUserAllRows();" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
</div>--%>


<%--更新对话框--%>
        <div id="updateUserDialog" data-options="draggable:false,iconCls:'icon-edit',width:600,height:400,
        title:'更新用户信息'"></div>




