<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 合同列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>合同编号</th>
                        <th>名称</th>
                        <th>类型</th>
                        <th>状态</th>
                        <th>描述</th>
                        <th>驳回理由</th>
                        <th>创建时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.contractId)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${convert('contractTypeCover',e.type)}</td>
                            <td>${convert('contractStatusCover',e.status)}</td>
                            <td>${(e.note)!''}</td>
                            <td>${(e.reason)!''}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd"))!''}</td>
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





