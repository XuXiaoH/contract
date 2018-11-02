<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 权限列表</h2>
            </div>
            <div class="box-content">
                <table id="tb_departments"></table>
            </div>
        </div>
    </div>
</div>

<#include "fragment/footer.ftl" >

<script>
    $(function () {
        $('#tb_departments').bootstrapTable({
            url: '${base}/permission/get_list?timestamp=' + new Date().getTime(),
            method: 'post',
            pagination: true,                //是否显示分页（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageSize: 500,                     //每页的记录行数（*）
            detailView: true,//父子表
            clickToSelect: true,
            columns: [
                {
                    field: 'name',
                    title: '菜单名称'
                }, {
                    field: 'url',
                    title: 'URL'
                }, {
                    field: 'type',
                    title: '类型'
                }, {
                    field: 'sort',
                    title: '排序',
                    formatter: function (value, row, index) { // 单元格格式化函数
                        var text = '<div class="input-group">'
                                + '<input type="text" class="form-control" tag="' + row.permissionId + '" value="' + value + '">'
                                + '<div class="input-group-addon update-sort" style="cursor: pointer;">edit</div>'
                                + '</div>';
                        return text;
                    }
                }],
            //无线循环取子表，直到子表里面没有记录
            onExpandRow: function (index, row, $Subdetail) {
                var parentId = row.permissionId;
                var cur_table = $Subdetail.html('<table></table>').find('table');
                $(cur_table).bootstrapTable({
                    url: '${base}/permission/get_list?parent_id=' + parentId + "&timestamp=" + new Date().getTime(),
                    method: 'post',
                    pagination: true,                //是否显示分页（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageSize: 500,                     //每页的记录行数（*）
                    detailView: true,//父子表
                    clickToSelect: true,
                    columns: [
                        {
                            field: 'name',
                            title: '菜单名称'
                        }, {
                            field: 'url',
                            title: 'URL'
                        }, {
                            field: 'type',
                            title: '类型'
                        }, {
                            field: 'sort',
                            title: '排序',
                            formatter: function (value, row, index) { // 单元格格式化函数
                                var text = '<div class="input-group">'
                                        + '<input type="text" class="form-control" tag="' + row.permissionId + '" value="' + value + '">'
                                        + '<div class="input-group-addon update-sort" style="cursor: pointer;">edit</div>'
                                        + '</div>';
                                return text;
                            }
                        }],
                    onExpandRow: function (index, row, $Subdetail) {
                        var parentId = row.permissionId;
                        var cur_table = $Subdetail.html('<table></table>').find('table');
                        $(cur_table).bootstrapTable({
                            url: '${base}/permission/get_list?parent_id=' + parentId + "&timestamp=" + new Date().getTime(),
                            method: 'post',
                            pagination: true,                //是否显示分页（*）
                            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                            pageSize: 500,                     //每页的记录行数（*）
                            clickToSelect: true,
                            columns: [
                                {
                                    field: 'name',
                                    title: '按钮名称'
                                }, {
                                    field: 'type',
                                    title: '类型'
                                }]
                        });
                    }
                });
            }
        });
        $("#tb_departments").on('click','.update-sort',function() {
            var pref = $(this).prev();
            var permissionId = pref.attr("tag");
            var sort = pref.val();
            $.localAjax('update_sort',{permissionId:permissionId,sort:sort},function(){
                alert('操作成功');
            })
        })

    });




</script>


