<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-3">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-file"></i> 发票信息</h2>
                <div class="box-icon">
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
            </div>
            <div class="box-content row">
                <div class="col-lg-7 col-md-12">
                    <h3>
                        <small>${(invoice.invoiceId)!''}</small>
                    </h3>
                    <p>发票类型:<b>${(invoice.type)!''}</b></p>
                    <p>发票状态:<b>${(invoice.status)!''}</b></p>
                    <p>发票金额:<b>${(invoice.money)!''}</b></p>
                    <p>税点:<b>${(invoice.tax)!''}</b></p>
                    <p>开票时间:<b>${(invoice.offerTime?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>描述:<b>${(invoice.note)!''}</b></p>
                    <p>创建时间:<b>${(invoice.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                </div>
            </div>
        </div>
    </div>

    <div class="box col-md-9">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-file"></i> 回款列表</h2>
                <div class="box-icon">
                    <a href="#" role="add-payment" class="btn btn-round btn-default"><i
                            class="glyphicon glyphicon-plus"></i></a>
                    <a href="#" class="btn btn-minimize btn-round btn-default"><i
                            class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>付款ID</th>
                        <th>状态</th>
                        <th>类型</th>
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
                            <td>${(e.status)!''}</td>
                            <td>${(e.type)!''}</td>
                            <td>${(e.money)!''}</td>
                            <td>${(e.handleTime?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
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

<div class="modal fade" id="add_payment" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">录入回款</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="save" method="post" id="filter">
                        <input  type="hidden" name="invoiceId" value="${(invoice.invoiceId)!''}"  />
                        <div class="form-group">
                            <label for="money">金额</label>
                            <input type="text" class="form-control" name="money" id="money" placeholder="金额">
                        </div>
                        <div class="form-group">
                            <label for="handleTime">付款时间</label>
                            <input type="text" class="form-control" name="handleTime" id="handleTime" placeholder="付款时间"
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
        $('body').on('click','[role="add-payment"]', function () {
            $.showModal("add_payment", function () {
                $.localFormAjax('filter',function(){
                    alert('操作成功',function(){
                        history.go(0);
                    });
                })
            })
        })
    })
</script>





