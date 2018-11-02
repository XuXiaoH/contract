<#include "fragment/header.ftl" >



<div class="row">
    <div class="box col-md-8">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-edit"></i> 添加供应商</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" id="submit" class="btn btn-round btn-default "><i
                            class="glyphicon glyphicon-ok"></i></a>
                </div>
            </div>
            <div class="box-content">
                <form action="save" method="post" id="filter">
                    <input type="hidden" id="attachs" name="attachs" value=""/>
                    <div class="form-group">
                        <label for="name">供应商名称</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="供应商名称">
                    </div>
                    <div class="form-group">
                        <label for="selectType">合同类型</label>
                        <div class="controls">
                            <select id="selectType" data-placeholder="请选择" name="type" data-rel="chosen">
                                <option value=""></option>
                            <#list convert('供应商合同类型') as e >
                                <option value="${(e.code)!''}">${(e.name)!''}</option>
                            </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <labelfor
                        ="selectType">业务类型</label>
                        <div class="controls">
                            <select id="selectBusinessType" data-placeholder="请选择" name="cType" data-rel="chosen">
                                <option value=""></option>
                            <#list convert('供应商业务类型') as e >
                                <option value="${(e.code)!''}">${(e.name)!''}</option>
                            </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="govcode">组织机构代码</label>
                        <input type="text" class="form-control" name="govcode" id="govcode" placeholder="组织机构代码">
                    </div>

                    <div class="form-group">
                        <label for="mobile">联系方式</label>
                        <input type="text" class="form-control" name="mobile" id="mobile" placeholder="联系方式">
                    </div>
                    <div class="form-group">
                        <label for="bank">开户行</label>
                        <input type="text" class="form-control" name="bank" id="bank" placeholder="开户行">
                    </div>
                    <div class="form-group">
                        <label for="bankCode">银行卡号</label>
                        <input type="text" class="form-control" name="bankCode" id="bankCode" placeholder="银行卡号">
                    </div>
                    <div class="form-group">
                        <label for="note">备注</label>
                        <textarea class="form-control" id="note" name="note" rows="3" placeholder="备注"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="attachImg" class="btn btn-primary">
                            上传相关附件
                        </label>
                        <input type="file" name="files" id="attachImg" multiple="true"
                               style="display: none"/>
                    </div>
                    <div class="form-group">
                        <div class="pic_after">
                        </div>
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
                    window.location.href = 'list';
                });
            })
        })

        // 上传
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

    })
</script>

