<#include "fragment/header.ftl" >

<div class="row">
    <div class="box col-md-8">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 增加角色</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" id="submit" class="btn btn-round btn-default ">
                        <i class="glyphicon glyphicon-ok"></i>
                    </a>
                </div>
            </div>
            <div class="box-content">
                <form action="save" method="post" id="filter">
                    <input type="hidden" name="permissionIds" id="permissionIds"/>
                    <div class="form-group">
                        <label for="name">角色名称</label>
                        <input type="text" class="form-control" name="name" placeholder="角色名称">
                    </div>
                    <div class="form-group">
                        <label>设置权限</label>
                        <div id="tree"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<#include "fragment/footer.ftl" >


<script>
    $(function () {
        function transToNode(data) {
            var node = [];
            data.forEach(function (obj) {
                var item = {};
                item.text = obj.name;
                item.dataAttr = [];
                item.dataAttr.push(obj.permissionId);
                item.tags = [];
                if (obj.type == 1) {
                    item.tags.push('页面');
                } else if (obj.type == 0) {
                    item.tags.push('按钮');
                }
                if (obj.list.length > 0) {
                    item.nodes = transToNode(obj.list);
                }
                node.push(item);
            });
            return node;
        }
        function getTree() {
            $.localAjax('get_permission', {}, function (res) {
                var tree = transToNode(res.data);
                $('#tree').treeview({
                    data: tree,
                    showCheckbox: true,
                    levels: 3,
                    hierarchicalCheck: true,//级联勾选
                    propagateCheckEven: true,
                    showBorder: true,
                    showTags: true
                })
            })
        }
        getTree();

        $("#submit").on('click', function () {
            var checkNodes = $('#tree').treeview('getChecked');
            var permissionIds = [];
            checkNodes.forEach(function (node) {
                permissionIds.push(node.dataAttr[0]);
            });
            $("#permissionIds").val(permissionIds.join(","));
            $.localFormAjax('filter',function(){
                alert('操作成功',function(){
                    window.location.href='list';
                })
            })
        })
    })


</script>