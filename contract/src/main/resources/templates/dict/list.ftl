<#include "fragment/header.ftl" >
<div class="row">
    <div class="box col-md-12">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-book"></i> 字典列表</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" id="add_btn" class="btn btn-default box-text"><i
                            class="glyphicon glyphicon-plus"></i>创建</a>
                </div>
            </div>
            <div class="box-content">
                <table class="table table-striped table-bordered bootstrap-datatable datatable responsive">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>父ID</th>
                        <th>名称</th>
                        <th>标志</th>
                        <th>状态</th>
                        <th>类型</th>
                        <th>排序</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if list??>
                        <#list list as e>
                        <tr>
                            <td>${(e.dictId)!''}</td>
                            <td>${(e.parent.name)!''}</td>
                            <td>${(e.name)!''}</td>
                            <td>${(e.title)!''}</td>
                            <td>${convert('dictStatus',e.status)!''}</td>
                            <td>${convert('dictType',e.type)!''}</td>
                            <td>${(e.sort)!''}</td>
                            <td>
                                <@shiro.hasPermission name='/dict/update'>
                                    <button role="role-update" tag="${(e.dictId)!''}"
                                            class="btn btn-info btn-xs">
                                        <i class="glyphicon glyphicon-edit icon-white"></i>
                                        修改
                                    </button>
                                </@shiro.hasPermission>
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

<div class="modal fade" id="modal_add" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="padding: 15px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    <span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加字典</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form action="save" method="post" id="filter">
                        <div class="form-group">
                            <label class="radio-inline">
                                <input type="radio" name="type" checked value="0"> 父级
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" value="1"> 子级
                            </label>
                        </div>
                        <div class="form-group" role="selectParent" style="display: none">
                            <label for="selectParent">父级</label>
                            <div class="controls">
                                <select data-placeholder="请选择" name="pid" data-rel="chosen">
                                    <option value=""></option>
                                <#if parent??>
                                    <#list parent as e>
                                        <option value="${e.dictId}">${e.name}</option>
                                    </#list>
                                </#if>
                                </select>
                            </div>
                        </div>
                        <div class="form-group" role="name">
                            <label for="name">名称</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="名称">
                        </div>
                        <div class="form-group" role="sort">
                            <label for="sort">排序</label>
                            <input type="text" class="form-control" value="0" name="sort" id="sort" placeholder="排序">
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
                    <form action="update" method="post" id="filter-update">
                        <input  type="hidden"   value=""  name="dictId" id="dictId" />
                        <div class="form-group" role="name">
                            <label>名称</label>
                            <input type="text" class="form-control" name="name" id="update-name" placeholder="名称">
                        </div>
                        <div class="form-group" role="sort">
                            <label>排序</label>
                            <input type="text" class="form-control"   name="sort"  id="update-sort" placeholder="排序">
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
        $("#add_btn").on('click', function () {
            $.showModal("modal_add", function () {
                $.localFormAjax('filter', function () {
                    alert('保存成功',function(){
                        history.go(0);
                    });

                })
            })
        })

        $('input[type=radio][name=type]').change(function () {
            if (this.value == 0) {
                $("[role='selectParent']").hide();
            }
            else if (this.value == 1) {
                $("[role='selectParent']").show();
            }
        });

        $('body').on('click','[role="role-update"]', function () {
            var self=$(this);
            var dictId = self.attr("tag");
            $.localAjax("get",{dictId:dictId},function (res) {
                $("#dictId").val(res.data.dictId);
                $("#update-name").val(res.data.name);
                $("#update-sort").val(res.data.sort);
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





