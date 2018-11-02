<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 回款列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>付款ID</th>
                        <th>状态</th>
                        <th>金额</th>
                        <th>付款时间</th>
                        <th>备注</th>
                        <th>创建时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.paymentId)!''}</td>
                            <td>
                                <#if e.status==0>
                                未付款
                                <#elseif e.status==1>
                                已完结
                                <#else>
                                未知
                                </#if>
                            </td>
                            <td>${(e.money)!''}</td>
                            <td>${(e.handleTime?string("yyyy-MM-dd"))!''}</td>
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





