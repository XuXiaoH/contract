<#include "fragment/header.ftl" >


<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 用户列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>状态</th>
                        <th>简称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.username)!''}</td>
                            <td>${(e.realName)!''}</td>
                            <td>
                                <#if e.status==1>
                                    <span role="status-change" class="label-default label label-success">正常</span>
                                <#else>
                                    <span role="status-change" class="label-default label label-warning">冻结</span>
                                </#if>
                            </td>
                            <td>${(e.note)!''}</td>
                            <td>
                                <#if e.username!='sky'>
                                    <@shiro.hasPermission name='/user/get_role'>
                                        <button role="role-setting" tag="${(e.uid)!''}"
                                                class="btn btn-info btn-xs">
                                            <i class="glyphicon glyphicon-edit icon-white"></i>
                                            设置角色
                                        </button>
                                    </@shiro.hasPermission>

                                    <#if e.status==1>
                                        <@shiro.hasPermission name='/user/frozen'>
                                        <button role="status-change-btn" tag="${(e.uid)!''}"
                                                class="btn btn-warning btn-xs">
                                            冻结
                                        </button>
                                        </@shiro.hasPermission>
                                    <#else>
                                        <@shiro.hasPermission name='/user/thaw'>
                                        <button role="status-change-btn" tag="${(e.uid)!''}"
                                                class="btn btn-success btn-xs">
                                            解冻
                                        </button>
                                        </@shiro.hasPermission>
                                    </#if>
                                </#if>
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

<div class="modal fade" id="role_setting" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">角色设置</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">请选择角色</label>
                        <div class="controls role_select">
                        </div>
                    </div>
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

        function transToChosenData(data) {
            var resData = [];
            data.forEach(function (o) {
                resData.push({key: o.roleId, val: o.name})
            });
            return resData;
        }

        $('body').on('click','[role="role-setting"]', function () {
            var self = $(this);
            var uid = self.attr('tag');
            $.localAjax('get_role', {uid: uid}, function (res) {
                var data = transToChosenData(res.data.list);
                var target = transToChosenData(res.data.target);
                $.chosenSetting($('.role_select'), 'role_select', data, target, {
                    width: '100%',
                    placeholder_text_multiple: '选择角色'
                });
                $.showModal("role_setting", function () {
                    var values = $('#role_select').val();
                    var roleIds='';
                    if (values != null || values != undefined) {
                        roleIds=values.join(',');
                    }
                    $.localAjax('set_role', {uid: uid, roleIds: roleIds}, function () {
                        alert('操作成功', function () {
                            $("#role_setting").modal('hide');
                        });
                    })
                })
            })
        })

        $('body').on('click','[role="status-change-btn"]', function () {
            var self = $(this);
            var statusLabel = self.closest("tr").find('[role="status-change"]');
            var uid = self.attr('tag');
            //冻结
            if (self.hasClass('btn-warning')) {
                myConfirm("确定要冻结用户吗?", function () {
                    $.localAjax('./frozen', {uid: uid}, function () {
                        alert('操作成功', function () {
                            self.removeClass('btn-warning');
                            self.addClass('btn-success');
                            self.html("解冻");
                            statusLabel.removeClass('label-success');
                            statusLabel.addClass('label-warning');
                            statusLabel.html("冻结");
                        });
                    })
                });
            }
            //解冻
            else {
                myConfirm("确定要解冻用户吗?", function () {
                    $.localAjax('./thaw', {uid: uid}, function () {
                        alert('操作成功', function () {
                            self.removeClass('btn-success');
                            self.addClass('btn-warning');
                            self.html("冻结");
                            statusLabel.removeClass('label-warning');
                            statusLabel.addClass('label-success');
                            statusLabel.html("正常");
                        });
                    })
                });
            }
        })
    })
</script>