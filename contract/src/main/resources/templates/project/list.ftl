<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 项目列表</h2>
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
        $('body').on('click', '[role="create_contract_btn"]',function () {
            var projectId = $(this).attr("tag");
            window.location.href = '/contract/add?projectId=' + projectId;
        })
        $('body').on('click','[role="view_contract_btn"]', function () {
            var projectId = $(this).attr("tag");
            window.location.href = '/project/view?projectId=' + projectId;
        })
    })

</script>





