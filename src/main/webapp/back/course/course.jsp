<%@page pageEncoding="UTF-8" isELIgnored="false" %>
    <script>
        $(function () {
            //通过js创建datagrid
            $("#bgs1").datagrid({
                url:'${pageContext.request.contextPath}/course/findAll',//用来请求远程数据
                pagination:true,//显示分页工具栏
                pageNumber:1,//当前页
                pageSize:10,//每页显示记录数
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
                    {title:'cks',field:"cks",checkbox:true},
                    {title:'文章名称',field:'title',width:120,},
                    {title:'标记',field:'marking',width:140},
                    {title:'创建时间',field:'createTime',width:120},
                    {title:'操作',field:'options',width:200,
                        formatter:function(value,row,index){
                            return "<a href='javascript:;' class='options' onclick=\"dellRow('"+row.id+"')\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>"
                        }
                    },

                ]],
                onLoadSuccess:function () {
                    $(".options").linkbutton();
                },
                toolbar:'#tbs',
            });


        });



        //删除一行的事件
        function dellRow(id){
            $.messager.confirm('确认对话框', '您确定要删除吗？', function(r){
                if (r){
                    //获取当前点击id发送ajax请求删除id这个人的信息
                    $.post("${pageContext.request.contextPath}/course/remove",{"id":id},function (result) {//响应成功之后回调
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid数据
                        $("#bgs1").datagrid('reload');//刷新当前datagrid
                    });
                }
            });



        }

       //添加
        function openAddCourseDialog(){
            $("#saveCourseDialog").dialog({
                buttons:[{
                    iconCls:'icon-save',
                    text:'添加',
                    handler:function(){
                        //保存信息
                        $("#saveCourseForm").form('submit',{
                            url:'${pageContext.request.contextPath}/course/add',
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
                                $("#saveCourseDialog").dialog('close');
                                //刷新datagrid
                                $("#bgs1").datagrid('reload');
                            }
                        });
                    }
                },{
                    iconCls:'icon-cancel',
                    text:'关闭',
                    handler:function(){
                        $("#saveCourseDialog").dialog('close');
                    }
                }]
            });
        }

        //批量删除多行
        function deleteAllCourseRows(){
            var rows = $("#bgs1").datagrid('getSelections');
            if(rows.length<=0){
                $.messager.show({title:'提示',msg:"至少选中一行!!!"});
            }else{
                var ids = [];
                for (var i = 0; i < rows.length ; i++) {
                    console.log(rows[i].id);
                    ids.push(rows[i].id);
                }
                $.ajax({
                    url:"${pageContext.request.contextPath}/course/removeAll",
                    type:"POST",
                    traditional:true,//传递数据类型的数据时必须设置这个属性为true
                    data:{id:ids},
                    success:function(result){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除成功!!!"});
                        //刷新datagrid
                        $("#bgs1").datagrid('reload');
                    },
                    error:function(){
                        //消息提示
                        $.messager.show({title:'提示',msg:"删除失败!!!"});
                        //刷新datagrid
                        $("#bgs1").datagrid('reload');
                    }
                })
            }
        }
    </script>




<%--datagrid数据表格--%>
<table id="bgs1"></table>

<%--datagrid工具栏--%>
<div id="tbs">
    <a href="#" class="easyui-linkbutton" onclick="openAddCourseDialog();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a href="#" class="easyui-linkbutton" onclick="deleteAllCourseRows();" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
</div>

<%--添加对话框--%>
        <div id="saveCourseDialog" data-options="href:'${pageContext.request.contextPath}/back/course/insert.jsp',
        draggable:false,iconCls:'icon-save',width:600,height:400,title:'添加功课信息'">
</div>

<%--更新对话框--%>
        <div id="editCourseDialog" data-options="draggable:false,iconCls:'icon-edit',width:600,height:400,
        title:'更新功课信息'"></div>




