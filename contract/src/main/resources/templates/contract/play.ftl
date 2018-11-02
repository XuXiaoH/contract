<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-user"></i> 进行中</h2>
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
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.contractId)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${convert('contractTypeCover',e.type)}</td>
                            <td> ${convert('contractStatusCover',e.status)}</td>
                            <td>${(e.note)!''}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd"))!''}</td>
                            <td>
                                <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="status-change-btn">
                                    <i class="glyphicon glyphicon-edit icon-white"></i>
                                    验收
                                </button>
                                <#--<button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="create_invoice_btn">-->
                                    <#--<i class="glyphicon glyphicon-edit icon-white"></i>-->
                                    <#--创建发票-->
                                <#--</button>-->
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
        $('body').on('click','[role="create_invoice_btn"]', function () {
            var id = $(this).attr("tag");
            window.location.href = '/invoice/add?contractId=' + id;
        })

        $('body').on('click', '[role="status-change-btn"]',function () {
            var self = $(this);
            var id = self.attr('tag');
            myConfirm("确定要通过验收吗?", function () {
                $.localAjax('./update_play', {contractId: id}, function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })
            });
        })



    })
</script>


