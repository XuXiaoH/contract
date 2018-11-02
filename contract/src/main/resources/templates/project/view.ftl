<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-th"></i> 项目信息</h2>
            </div>
            <div class="box-content">
                <div class="tab-pane active" id="info">
                    <h3>${(project.name)!''}
                        <small>${(project.user.realName)!''}</small>
                    </h3>
                    <p>类型:<b>${convert('projectType',project.type)}</b></p>
                    <p>创建时间:<b>${(project.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                    <p>描述:<b>${(project.note)!''}</b></p>
                    <p class="btn-group">
                        <button class="btn btn-default" tag="0" role="add-contract"><i
                                class="glyphicon glyphicon-plus"></i> 合作商合同
                        </button>
                        <button class="btn btn-default" tag="1" role="add-contract"><i
                                class="glyphicon glyphicon-plus"></i> 供应商合同
                        </button>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-th"></i> 合作商合同</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>合同编号</th>
                        <th>名称</th>
                        <th>金额</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if listForA??>
                        <#list listForA as e>
                        <tr>
                            <td>${(e.contractId)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${(e.money?string(',###.##'))!''}</td>
                            <td>
                                ${convert('contractStatusCover',e.status)}
                            </td>
                            <td>${(e.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                            <td>
                                <#if e.status==1>
                                    <span class="label-warning label label-default">等待审核</span>
                                <#elseif e.status==4>
                                    <span class="label-default label">已归档</span>
                                <#else>
                                    <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}"
                                            role="create_invoice_btn">
                                        <i class="glyphicon glyphicon-edit icon-white"></i>
                                        创建发票
                                    </button>
                                    <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}"
                                            role="list_invoice_btn">
                                        <i class="glyphicon glyphicon-edit icon-white"></i>
                                        发票列表
                                    </button>
                                </#if>
                            </td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-th"></i> 供应商合同</h2>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>合同编号</th>
                    <#if project.type==0>
                        <th>所属合作商合同</th>
                    </#if>
                        <th>名称</th>
                        <th>金额</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if listForB??>
                        <#list listForB as e>
                        <tr>
                            <td>${(e.contractId)!''}</td>
                            <#if project.type==0>
                                <td>${(e.parentName)!''}</td>
                            </#if>
                            <td>${(e.name)!''}</td>
                            <td>${(e.money?string(',###.##'))!''}</td>
                            <td> ${convert('contractStatusCover',e.status)}</td>
                            <td>${(e.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                            <td>
                                <#if e.status==1>
                                    <span class="label-warning label label-default">等待审核</span>
                                <#elseif e.status==4>
                                    <span class="label-default label">已归档</span>
                                <#else>
                                    <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}"
                                            role="create_invoice_btn">
                                        <i class="glyphicon glyphicon-edit icon-white"></i>
                                        创建发票
                                    </button>
                                    <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}"
                                            role="list_invoice_btn">
                                        <i class="glyphicon glyphicon-edit icon-white"></i>
                                        发票列表
                                    </button>
                                </#if>
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

<div class="modal fade" id="add_contract" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">录入合同</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="${base}/contract/save" method="post" id="filter-contract">
                        <input type="hidden" name="projectId" value="${(project.projectId)!''}"/>
                        <input type="hidden" id="attachs" name="attachs" value=""/>
                        <input type="hidden" name="type" id="contract_type"/>
                        <div class="form-group">
                            <label for="name">合同名称</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="合同名称">
                        </div>
                        <div class="form-group supplierA" style="display: none;">
                            <label>合作商</label>
                            <div class="controls">
                                <select data-placeholder="请选择" name="supplierId" data-rel="chosen">
                                    <option value=""></option>
                                <#list supplierA as e >
                                    <option value="${(e.supplierId)!''}">${(e.name)!''}</option>
                                </#list>
                                </select>
                            </div>
                        </div>
                        <div class="form-group supplierB" style="display: none;">
                            <label>供应商</label>
                            <div class="controls">
                                <select data-placeholder="请选择" name="supplierZId" data-rel="chosen">
                                    <option value=""></option>
                                <#list supplierB as e >
                                    <option value="${(e.supplierId)!''}">${(e.name)!''}</option>
                                </#list>
                                </select>
                            </div>
                        </div>
                    <#if project.type==0>
                        <div class="form-group listForA" style="display: none;">
                            <label>合作商合同</label>
                            <div class="controls">
                                <select data-placeholder="请选择" name="pid" data-rel="chosen">
                                    <option value=""></option>
                                    <#list listForA as e >
                                        <#if (e.status>1) >
                                            <option value="${(e.contractId)!''}">${(e.name)!''}</option>
                                        </#if>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    </#if>
                        <div class="form-group attach-code">
                            <label for="pr">pr</label>
                            <input type="text" class="form-control" name="pr" id="pr" placeholder="pr">
                        </div>
                        <div class="form-group attach-code">
                            <label for="po">po</label>
                            <input type="text" class="form-control" name="po" id="po" placeholder="po">
                        </div>
                        <div class="form-group">
                            <label for="money">合同金额</label>
                            <input type="text" class="form-control" name="money" id="money" placeholder="金额">
                        </div>
                        <div class="form-group">
                            <label for="realName">实际金额</label>
                            <input type="text" class="form-control" name="realMoney" id="realMoney" placeholder="实际金额">
                        </div>

                        <div class="form-group">
                            <label for="conformTime">签订时间</label>
                            <input type="text" class="form-control" placeholder="点击选择" name="conformTime"
                                   id="conformTime"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;"
                                   readonly>
                        </div>
                        <div class="form-group">
                            <label for="startTime">开始时间</label>
                            <input type="text" class="form-control" name="startTime" id="startTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'#F{$dp.$D(\'conformTime\')}'})"
                                   style="cursor: default;"
                                   readonly>
                        </div>
                        <div class="form-group">
                            <label for="endTime">结束时间</label>
                            <input type="text" class="form-control" name="endTime" id="endTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'#F{$dp.$D(\'startTime\')}'})"
                                   style="cursor: default;"
                                   readonly>
                        </div>
                        <div class="form-group">
                            <label for="note">备注</label>
                            <textarea class="form-control" id="note" name="note" rows="3" placeholder="备注"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="attachImg" class="btn btn-primary">
                                上传合同
                            </label>
                            <input type="file" name="files" id="attachImg" multiple="true" style="display: none"/>
                        </div>
                        <div class="form-group">
                            <div class="pic_after">
                            </div>
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
                    <form action="${base}/invoice/save" method="post" id="filter-invoice">
                        <input type="hidden" id="attachs-invoice" name="attachs" value=""/>
                        <input type="hidden" value="" id="contractId" name="contractId"/>
                        <div class="form-group">
                            <label for="money">发票编号：</label>
                            <input type="text" class="form-control" name="number" placeholder="发票编号">
                        </div>
                        <div class="form-group">
                            <label for="money">发票金额</label>
                            <input type="text" class="form-control" name="money" placeholder="发票金额">
                        </div>
                        <div class="form-group">
                            <label for="selectInvoiceType">类型</label>
                            <div class="controls">
                                <select id="selectInvoiceType" data-placeholder="请选择" name="type">
                                    <option value=""></option>
                                <#list convert('invoiceType')?keys as e >
                                    <option value="${e}">${convert('invoiceType',e)}</option>
                                </#list>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tax">税点</label>
                            <input type="text" class="form-control" name="tax" id="tax" placeholder="不填写为默认值">
                        </div>
                        <div class="form-group">
                            <label for="offerTime">开具时间</label>
                            <input type="text" class="form-control" id="offerTime" name="offerTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="note">备注</label>
                            <input type="text" class="form-control" name="note" placeholder="备注">
                        </div>
                        <div class="form-group">
                            <label for="attachImg-invoice" class="btn btn-primary">
                                上传发票
                            </label>
                            <input type="file" name="files" id="attachImg-invoice" multiple="true"
                                   style="display: none"/>
                        </div>
                        <div class="form-group">
                            <div class="pic_after_invoice">
                            </div>
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


<div class="modal fade" id="list_invoice" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">发票列表</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="add_payment" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" role="close-add-payment"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">录入回款</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="${base}/payment/save" method="post" id="filter-payment">
                        <input type="hidden" name="invoiceId" id="invoiceId" value=""/>
                        <div class="form-group">
                            <label>金额</label>
                            <input type="text" class="form-control" name="money" placeholder="金额">
                        </div>
                        <div class="form-group">
                            <label for="predictTime">预计回款时间</label>
                            <input type="text" class="form-control" name="predictTime" id="predictTime" placeholder="点击选取"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="handleTime">实际回款时间</label>
                            <input type="text" class="form-control" name="handleTime" id="handleTime" placeholder="点击选取"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="note">备注</label>
                            <input type="text" class="form-control" name="note" placeholder="备注">
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" role="close-add-payment" data-dismiss="modal">Close
                </button>
                <button type="button" class="btn btn-primary conform-but">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal_update" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">修改</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="updateNote" method="post" id="filter-update">
                        <input  type="hidden"   value=""  name="paymentId" id="paymentId" />
                        <div class="form-group" role="money">
                            <label>金额</label>
                            <input type="text" class="form-control" name="money" id="update-money" placeholder="金额">
                        </div>
                        <div class="form-group" role="predictTime">
                            <label for="predictTime">预计回款时间</label>
                            <input type="text" class="form-control" name="predictTime" id="update-predictTime" placeholder="点击选取"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;" readonly>
                        </div>
                        <div class="form-group" role="handleTime">
                            <label for="handleTime">实际回款时间</label>
                            <input type="text" class="form-control" name="handleTime" id="update-handleTime" placeholder="点击选取"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"
                                   style="cursor: default;" readonly>
                        </div>
                        <div class="form-group" role="note">
                            <label for="note">备注</label>
                            <input type="text" class="form-control" name="note" id="update-note" placeholder="备注">
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
        $('body').on('click', '[role="add-contract"]',function () {
            var type = $(this).attr("tag");
            if (type == 1) {
                $('.attach-code').hide();
                $('.supplierA').hide();
                $('.supplierB').show();
                $('.listForA').show();
            } else {
                $('.attach-code').show();
                $('.supplierB').hide();
                $('.supplierA').show();
                $('.listForA').hide();
            }
            $('#contract_type').val(type);
            $.showModal("add_contract", function () {
                $.localFormAjax('filter-contract', function () {
                    alert('操作成功', function () {
                        history.go(0);
                    });
                })
            })
        })


        $('body').on('click','[role="create_invoice_btn"]', function () {
            var contractId = $(this).attr("tag");
            $('#selectInvoiceType').chosen({width: '20%'});
            $.showModal("add_invoice", function () {
                $('#contractId').val(contractId);
                $.localFormAjax('filter-invoice', function () {
                    alert('操作成功');
                })
            })
        })


        // 上传合同
        var picArr = new Array();
        $("body").on("change", "#attachImg", function () {
            var self = $(this);
            $.picsUpload(self.attr("id"), function (result) {
                $.each(result.data, function (n, value) {
                    picArr.addToArr(value, $("#attachs"));
                    $('.pic_after').append('<div class="col-xs-6 col-md-3"><button type="button" class="close img-close"><span>×</span></button><img src="'
                            + 'http://192.168.1.118:9091/images/' + value + '" tag="' + value + '" class="img-responsive img-thumbnail"  alt="图片无法访问"></div>');
                });
            });
        })

        // 删除合同
        $("body").on("click", ".img-close", function () {
            var self = $(this);
            var srcVal = self.next().attr('tag');
            picArr.removeByValue(srcVal, $("#attachs"));
            self.parent().remove();
        })


        // 上传发票
        var picInvoiceArr = new Array();
        $("body").on("change", "#attachImg-invoice", function () {
            var self = $(this);
            $.picsUpload(self.attr("id"), function (result) {
                $.each(result.data, function (n, value) {
                    picInvoiceArr.addToArr(value, $("#attachs-invoice"));
                    $('.pic_after_invoice').append('<div class="col-xs-6 col-md-3"><button type="button" class="close img-close-invoice"><span>×</span></button><img src="'
                            + 'http://192.168.1.118:9091/images/' + value + '" tag="' + value + '" class="img-responsive img-thumbnail"  alt="图片无法访问"></div>');
                });
            });
        })

        // 删除发票
        $("body").on("click", ".img-close-invoice", function () {
            var self = $(this);
            var srcVal = self.next().attr('tag');
            picInvoiceArr.removeByValue(srcVal, $("#attachs-invoice"));
            self.parent().remove();
        })

        $('body').on('click', '[role="list_invoice_btn"]',function () {
            var contractId = $(this).attr("tag");
            $('#list_invoice').find('.modal-body').empty();
            $('#list_invoice').find('.modal-body').append('<table id="tb_departments"></table>');
            $('#tb_departments').bootstrapTable({
                url: '${base}/invoice/getInvoice?timestamp=' + new Date().getTime() + '&contractId=' + contractId,
                method: 'post',
                pagination: true,
                sidePagination: "server",
                pageSize: 500,
                detailView: true,
                clickToSelect: true,
                columns: [
                    {
                        field: 'number',
                        title: '发票编号'
                    },
                    {
                        field: 'type',
                        title: '类型',
                        formatter: function (value, row, index) {
                            value = parseInt(value);
                            if (value == 0) {
                                return '普通发票';
                            }
                            if (value == 1) {
                                return '增值税发票';
                            }
                            return "其它"
                        }
                    }, {
                        field: 'money',
                        title: '发票金额'
                    }, {
                        field: 'offerTime',
                        title: '开具时间',
                        formatter: function (value, row, index) {
                            return formatDateTime(value);
                        }
                    }, {
                        field: 'note',
                        title: '备注'
                    }, {
                        field: 'invoiceId',
                        title: '操作',
                        formatter: function (value, row, index) { // 单元格格式化函数
                            var text = '<button class="btn btn-info btn-xs" tag="' + value + '"' +
                                    'role="create_payment_btn" data-index="' + index + '" >' +
                                    '<i class="glyphicon glyphicon-edit icon-white"></i>' +
                                    '创建回款' +
                                    '</button>';
                            return text;
                        }
                    }],
                //无线循环取子表，直到子表里面没有记录
                onExpandRow: function (index, row, $Subdetail) {
                    var invoiceId = row.invoiceId;
                    var cur_table = $Subdetail.html('<table></table>').find('table');
                    $(cur_table).bootstrapTable({
                        url: '${base}/payment/getPayment?invoiceId=' + invoiceId + "&timestamp=" + new Date().getTime(),
                        method: 'post',
                        pagination: true,
                        sidePagination: "server",
                        pageSize: 500,
                        clickToSelect: true,
                        columns: [
                            {
                                field: 'money',
                                title: '金额'
                            }, {
                                field: 'predictTime',
                                title: '预计回款时间',
                                formatter: function (value, row, index) {
                                    return formatDateTime(value);
                                }
                            },
                            {
                                field: 'handleTime',
                                title: '实际回款时间',
                                formatter: function (value, row, index) {
                                    return formatDateTime(value);
                                }
                            },{
                                field: 'status',
                                title: '状态',
                                formatter: function (value, row, index) {
                                    if(parseInt(value)==0){
                                        return "未完结";
                                    }
                                    if(parseInt(value)==1){
                                        return "已完结";
                                    }
                                    return formatDateTime(value);
                                }
                            }, {
                                field: 'note',
                                title: '备注'
                            },{
                                field: 'paymentId',
                                title: '操作',
                                formatter: function (value, row, index) { // 单元格格式化函数
                                    if(row.status==0){
                                        var text = '<button class="btn btn-info btn-xs" tag="' + value + '"' +
                                                'role="update_payment_btn" data-index="' + index + '" >' +
                                                '<i class="glyphicon glyphicon-edit icon-white"></i>' +
                                                '更新为完结' +
                                                '</button>';
                                        return text;
                                    }
                                    var text = '<button class="btn btn-info btn-xs" tag="' + value +'"' +
                                            'role="role-updateNote" data-index="' + index + '" >' +
                                            '<i class="glyphicon glyphicon-edit icon-white"></i>' +
                                            '修改' +
                                            '</button>';
                                    return text;
                                }
                            }]
                    });
                }
            });
            $.showModal("list_invoice", function () {
            });
        })


        $('body').on('click', '[role="create_payment_btn"]', function () {
            var modal = $("#list_invoice");
            modal.modal('hide');
            var invoiceId = $(this).attr("tag");
            var index = $(this).attr("data-index");
            $.showModal("add_payment", function () {
                $('#invoiceId').val(invoiceId);
                $.localFormAjax('filter-payment', function () {
                    alert('操作成功', function () {
                        var table = $('#tb_departments');
                        table.bootstrapTable('collapseRow', index);
                        table.bootstrapTable('expandRow', index);
                        modal.modal('show');
                    });
                })
            })
        })

        $('body').on('click', '[role="close-add-payment"]', function () {
            var modal = $("#list_invoice");
            modal.modal('show');
        })


        $('body').on('click', '[role="update_payment_btn"]', function () {
            var self = $(this);
            var paymentId = self.attr('tag');
            myConfirm("确定款项已完结吗?", function () {
                $.localAjax('${base}/payment/finish', {paymentId: paymentId}, function () {
                    alert('操作成功', function () {
                        self.parent().prev().prev().html("已完结");
                        self.remove();
                    });
                })

            });
        })


        $('body').on('click','[role="role-updateNote"]', function () {
            var self=$(this);
            var paymentId = self.attr("tag");
            $.localAjax("getpay",{paymentId:paymentId},function (res) {
                $("#paymentId").val(res.data.paymentId);
                $("#update-money").val(res.data.money);
                $("#update-predictTime").val(res.predictTime);
                $("#update-handleTime").val(res.handleTime);
                $("#update-note").val(res.data.note);
                $.showModal("modal_update", function () {
                    $.localFormAjax('filter-update', function () {
                        alert('修改成功',function(){
                            history.go(0);
                        });
                    })
                })
            })
        })
    })
</script>