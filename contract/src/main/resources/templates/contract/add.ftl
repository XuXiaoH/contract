<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-th"></i> 项目相关</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" role="add-contract" class="btn btn-round btn-default">
                        <i class="glyphicon glyphicon-plus"></i>
                    </a>
                </div>
            </div>
            <div class="box-content">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a href="#info">项目信息</a></li>
                    <li><a href="#a_contract">甲方合同</a></li>
                    <li><a href="#b_contract">丙方合同</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane active" id="info">
                        <h3>${(project.name)!''}
                            <small>${(project.projectId)!''}</small>
                        </h3>
                        <p>负责人:<b>${(project.user.realName)!''}</b></p>
                        <p>类型:<b>${convert('projectType',project.type)}</b></p>
                        <p>状态:<b>${(project.status)!''}</b></p>
                        <p>创建时间:<b>${(project.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</b></p>
                        <p>描述:<b>${(project.note)!''}</b></p>
                    </div>
                    <div class="tab-pane" id="a_contract">
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
                                        <td>${(e.money)!''}</td>
                                        <td>${(e.status)!''}</td>
                                        <td>${(e.createAt?string("yyyy-MM-dd HH:mm:ss"))!''}</td>
                                        <td>
                                            <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="create_invoice_btn">
                                                <i class="glyphicon glyphicon-edit icon-white"></i>
                                                创建发票
                                            </button>
                                        </td>
                                    </tr>
                                    </#list>
                                </#if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane" id="b_contract">
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
                                <#if listForB??>
                                    <#list listForB as e>
                                    <tr>
                                        <td>${(e.contractId)!''}</td>
                                        <td>${(e.name)!''}</td>
                                        <td>${(e.money)!''}</td>
                                        <td>${(e.status)!''}</td>
                                        <td>2018-09-25 12:12:33</td>
                                        <td>
                                            <button class="btn btn-info btn-xs" tag="${(e.contractId)!''}" role="create_invoice_btn">
                                                <i class="glyphicon glyphicon-edit icon-white"></i>
                                                创建发票
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
                    <form action="save" method="post" id="filter">
                        <input type="hidden" name="projectId" value="${(project.projectId)!''}" />
                        <input type="hidden" name="type" id="type" />
                        <div class="form-group">
                            <label for="name">合同名称</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="合同名称">
                        </div>
                        <div class="form-group">
                            <label for="pr">pr</label>
                            <input type="text" class="form-control" name="pr" id="pr" placeholder="pr">
                        </div>
                        <div class="form-group">
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
                            <input type="text" class="form-control"  name="conformTime" name="conformTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})" style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="startTime">开始时间</label>
                            <input type="text" class="form-control" name="startTime" id="startTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})" style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="endTime">结束时间</label>
                            <input type="text" class="form-control" name="endTime" id="endTime" placeholder="点击选择"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})" style="cursor: default;" readonly>
                        </div>
                        <div class="form-group">
                            <label for="note">备注</label>
                            <textarea class="form-control" id="note" name="note" rows="3" placeholder="备注"></textarea>
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
        $('body').on('click','[role="add-contract"]', function () {
            $.showModal("add_contract", function () {
                if($("#a_contract").hasClass('active')){
                    $('#type').val(0);
                }else{
                    $('#type').val(1);
                }
                $.localFormAjax('filter',function(){
                    alert('操作成功',function () {
                        history.go(0);
                    });

                })
            })
        })

        $('body').on('click', '[role="create_invoice_btn"]',function () {
            var id = $(this).attr("tag");
            window.location.href = '/invoice/add?contractId=' + id;
        })

    })
</script>





