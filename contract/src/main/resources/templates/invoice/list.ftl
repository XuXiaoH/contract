<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 发票列表</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>发票编号</th>
                        <th>状态</th>
                        <th>类型</th>
                        <th>发票金额</th>
                        <th>税点</th>
                        <th>开具时间</th>
                        <th>备注</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.invoiceId)!''}</td>
                            <td>${(e.status)!''}</td>
                            <td>${(e.type)!''}</td>
                            <td>${(e.money)!''}</td>
                            <td>${(e.tax)!''}</td>
                            <td>${(e.offerTime?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                            <td>${(e.note)!''}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                            <td>
                                <button class="btn btn-info btn-xs" tag="${(e.invoiceId)!''}" role="create_payment_btn">
                                    <i class="glyphicon glyphicon-edit icon-white"></i>
                                    创建回款
                                </button>
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
    $(function(){
        $('body').on('click','[role="create_payment_btn"]', function () {
            var id = $(this).attr("tag");
            window.location.href = '/payment/add?invoiceId=' + id;
        })
    })
</script>





