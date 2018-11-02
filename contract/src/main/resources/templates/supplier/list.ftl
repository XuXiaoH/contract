<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 供应商列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>供应商编号</th>
                        <th>供应商名称</th>
                        <th>合同类型</th>
                        <th>业务类型</th>
                        <th>组织机构代码</th>
                        <th>联系方式</th>
                        <th>开户行</th>
                        <th>银行卡号</th>
                        <th>创建时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.supplierId)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${convert('供应商合同类型',e.type)}</td>
                            <td>${convert('供应商业务类型',e.cType)}</td>
                            <td>${(e.govcode)!''}</td>
                            <td>${(e.mobile)!''}</td>
                            <td>${(e.bank)!''}</td>
                            <td>${(e.bankCode)!''}</td>
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





