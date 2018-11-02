<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-3">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-file"></i> ${(contract.name)!''}</h2>
                <div class="box-icon">
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
            </div>
            <div class="box-content row">
                <div class="col-lg-7 col-md-12">
                    <h3>
                        <small>${(contract.contractId)!''}</small>
                    </h3>
                    <p>合同金额:<b>${(contract.money)!''}</b></p>
                    <p>实际金额:<b>${(contract.realMoney)!''}</b></p>
                    <p>pr:<b>${(contract.pr)!''}</b></p>
                    <p>po:<b>${(contract.po)!''}</b></p>
                    <p>类型:<b>${(contract.type)!''}</b></p>
                    <p>状态:<b>${(contract.status)!''}</b></p>
                    <p>签订时间:<b>${(contract.conformTime?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>开始时间:<b>${(contract.startTime?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>结束时间:<b>${(contract.endTime?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>创建时间:<b>${(contract.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>描述:<b>${(contract.note)!''}</b></p>
                </div>
            </div>
        </div>
    </div>

    <div class="box col-md-9">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-file"></i> 发票列表</h2>
                <div class="box-icon">
                    <a href="#" role="add-invoice" class="btn btn-round btn-default"><i
                            class="glyphicon glyphicon-plus"></i></a>
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
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

<div class="modal fade" id="add_invoice" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">录入发票</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="save" method="post" id="filter">
                        <input type="hidden"  value="${(contract.contractId)!''}"  name="contractId" />
                        <div class="form-group">
                            <label for="money">发票金额</label>
                            <input type="text" class="form-control" name="money" placeholder="money">
                        </div>
                        <div class="form-group">
                            <label for="type">类型</label>
                            <div class="controls">
                                <select id="selectType" data-placeholder="请选择" id="type" name="type">
                                    <option value=""></option>
                                <#list convert('invoiceType')?keys as e >
                                    <option value="${e}">${convert('invoiceType',e)}</option>
                                </#list>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tax">税点</label>
                            <input type="text" class="form-control" name="tax" id="tax" placeholder="税点">
                        </div>
                        <div class="form-group">
                            <label for="offerTime">开具时间</label>
                            <input type="text" class="form-control" id="offerTime" name="offerTime" placeholder="开具时间"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="note">备注</label>
                            <input type="text" class="form-control" name="note" placeholder="备注">
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
        $('body').on('click', '[role="add-invoice"]',function () {
            $('#selectType').chosen({width: '20%'});
            $.showModal("add_invoice", function () {
                $.localFormAjax('filter',function(){
                    alert('操作成功',function(){
                        history.go(0);
                    });
                })
            })
        })

        $('body').on('click','[role="create_payment_btn"]', function () {
            var id = $(this).attr("tag");
            window.location.href = '/payment/add?invoiceId=' + id;
        })
    })
</script>





