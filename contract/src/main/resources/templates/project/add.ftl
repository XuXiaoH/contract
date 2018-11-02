<#include "fragment/header.ftl" >
<div class="row">
    <div class="box col-md-8">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-edit"></i> 添加项目</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" id="submit" class="btn btn-round btn-default ">
                        <i class="glyphicon glyphicon-ok"></i></a>
                </div>
            </div>
            <div class="box-content">
                <form action="save" method="post" id="filter">
                    <div class="form-group">
                        <label for="name">项目名称</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="项目名称">
                    </div>
                <#if users?? && (users?size>0)>
                    <div class="form-group">
                        <label for="username">项目负责人</label>
                        <div class="controls">
                            <select data-placeholder="请选择" name="uid" data-rel="chosen">
                                <option value=""></option>
                                <#if (users)??>
                                    <#list users as e>
                                        <option value="${e.uid}">${e.realName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                </#if>

                    <div class="form-group">
                        <label for="type">类型</label>
                        <div class="controls">
                            <select data-placeholder="请选择" id="typeSelect" name="type" data-rel="chosen">
                                <option value=""></option>
                            <#list convert('项目类型') as e >
                                <option value="${(e.code)!''}">${(e.name)!''}</option>
                            </#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group businessType" style="display: none;">
                        <label>项目--业务类型</label>
                        <div class="controls">
                            <select data-placeholder="请选择" name="cType" data-rel="chosen">
                                <option value=""></option>
                            <#list convert('项目业务类型') as e >
                                <option value="${(e.code)!''}">${(e.name)!''}</option>
                            </#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group govType" style="display: none;">
                        <label>项目--行政类型</label>
                        <div class="controls">
                            <select data-placeholder="请选择" name="czType" data-rel="chosen">
                                <option value=""></option>
                            <#list convert('项目行政类型') as e >
                                <option value="${(e.code)!''}">${(e.name)!''}</option>
                            </#list>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="note">备注</label>
                        <textarea class="form-control" id="note" name="note" rows="3" placeholder="备注"></textarea>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<#include "fragment/footer.ftl" >

<script>
    $(function () {
        $('#submit').on('click', function () {
            $.localFormAjax('filter', function () {
                alert('操作成功', function () {
                    window.location.href = 'my';
                });
            })
        })

        $('#typeSelect').change(function () {
            var value = $(this).children('option:selected').val();
            if (value == 0) {
                $('.govType').hide();
                $('.businessType').show();
            } else {
                $('.businessType').hide();
                $('.govType').show();
            }
        })


    })

</script>