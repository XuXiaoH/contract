<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 角色列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.name)!''}</td>
                            <td>
                               <@shiro.hasPermission name='/role/get_permission_user'>
                                <button tag="${e.roleId}" class="btn btn-info btn-xs" role="permission-setting">
                                    <i class="glyphicon glyphicon-edit icon-white"></i>
                                    编辑权限
                                </button>
                               </@shiro.hasPermission>
                            </td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="permission_setting" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">权限设置</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="save" method="post" id="filter">
                        <input type="hidden" name="roleId" id="role_id"/>
                        <input type="hidden" name="permissionIds" id="permissionIds"/>
                        <div class="form-group">
                            <label for="name">角色名称</label>
                            <input type="text" class="form-control" name="name" id="role_name" placeholder="角色名称">
                        </div>
                        <div class="form-group">
                            <label>设置权限</label>
                            <div id="tree"></div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary conform-but">保存</button>
            </div>
        </div>
    </div>
</div>



<#include "fragment/footer.ftl" >


<script>
    $(function () {

        function transToNode(data) {
            var node = [];
            data.forEach(function (obj) {
                var item = {};
                item.text = obj.name;
                item.dataAttr = [];
                item.dataAttr.push(obj.permissionId);
                item.tags = [];
                item.state = {};
                item.state.checked = transToChecked(obj.permissionId);
                if (obj.type == 1) {
                    item.tags.push('页面');
                } else if (obj.type == 0) {
                    item.tags.push('按钮');
                }
                if (obj.list.length > 0) {
                    item.nodes = transToNode(obj.list);
                }
                node.push(item);
            });
            return node;
        }
        var target;
        function transToChecked(permissionId) {
            if (target == undefined || target == null || target.length == 0) {
                return false;
            }
            for (var i = 0; i < target.length; i++) {
                var temp = target[i];
                if (permissionId == temp.permissionId) {
                    target.slice(i, 1);
                    return true;
                }
            }
            return false;
        }

        function getTree(roleId, callback) {
            $.localAjax('get_permission_user', {roleId: roleId}, function (res) {
                $("#role_name").val(res.data.e.name);
                $("#role_id").val(roleId);
                target = res.data.target;
                var tree = transToNode(res.data.list);
                $('#tree').treeview({
                    data: tree,
                    showCheckbox: true,
                    levels: 3,
                    hierarchicalCheck: true,//级联勾选
                    propagateCheckEven: true,
                    showBorder: true,
                    showTags: true
                });
                callback();
            })
        }

        $('body').on('click','[role="permission-setting"]', function () {
            var self = $(this);
            var roleId = self.attr('tag');
            getTree(roleId, function () {
                $.showModal("permission_setting", function () {
                    var checkNodes = $('#tree').treeview('getChecked');
                    var permissionIds = [];
                    checkNodes.forEach(function (node) {
                        permissionIds.push(node.dataAttr[0]);
                    });
                    $("#permissionIds").val(permissionIds.join(","));
                    $.localFormAjax('filter', function () {
                        alert('操作成功', function () {
                            $("#permission_setting").modal('hide');
                        })
                    })
                })
            });
        })


    })


</script>



