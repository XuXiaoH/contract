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
                            <td>${convert('contractStatusCover',e.status)}</td>
                            <td>${(e.note)!''}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd"))!''}</td>
                            <td>
                                <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="status-change-btn">
                                    <i class="glyphicon glyphicon-ok"></i>
                                    审核
                                </button>

                                <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="out-btn">
                                    <i class="glyphicon glyphicon-remove"></i>
                                    驳回
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



<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    驳回理由
                </h4>
            </div>
            <div class="modal-body">
                <form action="save" method="post" id="filter">
                <label for="reason">原因</label>
                <input type="text" class="form-control" name="reason" id="reason" placeholder="请输入驳回理由">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close
                </button>
                <button type="button" class="btn btn-primary btnDenyReasonSave">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<#include "fragment/footer.ftl" >


<script>
    $(function () {
        $('body').on('click', '[role="status-change-btn"]',function () {
            var self = $(this);
            var id = self.attr('tag');
            myConfirm("确定要通过审核吗?", function () {
                $.localAjax('./update_auditing', {contractId: id}, function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })
            });
        })

        $('.btnDenyReasonSave').on('click','[add-contract]',function () {
            var reason = $('#reason').val();
            if ($.trim(reason).length==0) {
                return false;
            }
            var contractId = $('#myModal').data("contract-id");
            $('#reason').val('');
            $('#myModal').modal('hide');
            myConfirm("确定要驳回吗?", function () {
                $.localAjax('./update_out', {contractId: contractId, reason: reason}, function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })
            });
        });

        $('body').on('click','[role="out-btn"]', function () {
            var self = $(this);
            var id = self.attr('tag');
            $('#myModal').modal('show');
            $('#myModal').attr('data-contract-id', id);
        })
    })
</script>



