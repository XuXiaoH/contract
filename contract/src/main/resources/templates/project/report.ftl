<#include "fragment/header.ftl" >

<div class=" row">
    <div class="col-md-3 col-sm-3 col-xs-6">
        <a  class="well top-block" href="#">
            <i class="glyphicon glyphicon-book blue"></i>
            <div>合同数</div>
            <div>${(contractNum)!''}</div>
        </a>
    </div>

    <div class="col-md-3 col-sm-3 col-xs-6">
        <a  class="well top-block" href="#">
            <i class="glyphicon glyphicon-list-alt green"></i>
            <div>发票数</div>
            <div>${(invoiceNum)!''}</div>
        </a>
    </div>

    <div class="col-md-3 col-sm-3 col-xs-6">
        <a  class="well top-block" href="#">
            <i class="glyphicon glyphicon-user red"></i>
            <div>供应商数量</div>
            <div>0</div>
        </a>
    </div>

    <div class="col-md-3 col-sm-3 col-xs-6">
        <a  class="well top-block" href="#">
            <i class="glyphicon glyphicon-bookmark yellow"></i>
            <div>利润</div>
            <div>${(money?string(',###.##'))!''}</div>
        </a>
    </div>

</div>


<#include "fragment/footer.ftl" >