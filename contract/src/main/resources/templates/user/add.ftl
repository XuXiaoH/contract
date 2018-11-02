<#include "fragment/header.ftl" >


<div class="row">
    <div class="box col-md-8">
        <div class="box-inner">
            <div class="box-header well">
                <h2><i class="glyphicon glyphicon-edit"></i> 添加用户</h2>
                <div class="box-icon">
                    <a href="javascript:void(0);" id="submit"  class="btn btn-round btn-default "><i class="glyphicon glyphicon-ok"></i></a>
                </div>
            </div>
            <div class="box-content">
                <form  action="save" method="post" id="filter">
                    <div class="form-group">
                        <label for="real_name">真实姓名</label>
                        <input type="text"  class="form-control" name="real_name" id="real_name" placeholder="真实姓名">
                    </div>
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" auto-complete="off" class="form-control" name="username" id="username" placeholder="用户名">
                    </div>
                    <div class="form-group">
                        <label for="password">密码(不填默认123456)</label>
                        <input type="password" auto-complete="off" class="form-control" name="password" id="password" placeholder="密码">
                    </div>
                    <div class="form-group">
                        <label for="note">简称</label>
                        <input type="text" class="form-control" name="note" id="note" placeholder="简称">
                    </div>
                    <div class="form-group">
                        <label for="selectPUser">所属人员</label>
                        <div class="controls">
                            <select id="selectPUser" data-placeholder="请选择" name="pUid">
                                <option value=""></option>
                                <#if users??>
                                    <#list users as e >
                                        <option value="${e.uid}">${e.realName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<#include "fragment/footer.ftl" >

<script>
    $(function(){

        $('#selectPUser').chosen({width: '20%'});
        $("#submit").on('click',function(){
            $.localFormAjax('filter',function(res){
                alert('添加成功',function(){
                   history.go(0);
                });
            })
        })


    })
</script>