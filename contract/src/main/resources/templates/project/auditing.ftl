<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 待审核列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>项目编号</th>
                        <th>名称</th>
                        <th>负责人</th>
                        <th>类型</th>
                        <th>描述</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.projectId)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${(e.user.realName)!''}</td>
                            <td>${convert('projectType',e.type)}</td>
                            <td>${(e.note)!''}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                            <td>
                                <@shiro.hasPermission name='/project/update_auditing'>
                                    <button role="auditing_btn" class="btn btn-success btn-xs"
                                            tag="${(e.projectId)!''}">
                                        <i class="glyphicon glyphicon-ok icon-white"></i>
                                        审核
                                    </button>
                                </@shiro.hasPermission>
                                <@shiro.hasPermission name='/project/update_out'>
                                    <button role="out_btn" class="btn btn-danger btn-xs"
                                            tag="${(e.projectId)!''}">
                                        <i class="glyphicon glyphicon-remove icon-white"></i>
                                        驳回
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


<#include "fragment/footer.ftl" >

<script>
    $(function () {
        $('body').on('click', '[role="auditing_btn"]', function () {
            var self = $(this);
            var projectId = self.attr('tag');
            myConfirm("确定审核通过吗?", function () {
                $.localAjax('${base}/project/update_auditing', {projectId: projectId}, function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })

            });
        })
        $('body').on('click', '[role="out_btn"]', function () {
            var self = $(this);
            var projectId = self.attr('tag');
            myConfirm("确定驳回吗?", function () {
                $.localAjax('${base}/project/update_out', {projectId: projectId}, function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })

            });
        })


    })

</script>





