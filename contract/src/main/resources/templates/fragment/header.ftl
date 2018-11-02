<!DOCTYPE html>
<html>
<head>
    <title>合同管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <META HTTP-EQUIV="expires" CONTENT="0">
    <!-- The styles -->
<#include "fragment/css.ftl"  />
<#--<style>-->
<#--.accordion ul{-->
<#--display: block;-->
<#--}-->
<#--</style>-->
</head>

<body>
<!-- topbar starts -->
<div class="navbar navbar-default" role="navigation">
    <div class="navbar-inner">
        <button type="button" class="navbar-toggle pull-left animated flip">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/"> <img alt="Charisma Logo" src="${base}/img/logo20.png" class="hidden-xs"/>
            <span style="font-family: sans-serif;">合同管理</span></a>
        <!-- user dropdown starts -->
        <div class="btn-group pull-right">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs"> <@shiro.principal /></span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">个人管理</a></li>
                <li class="divider"></li>
                <li><a href="/logout">退出</a></li>
            </ul>
        </div>
    </div>
</div>
<!-- topbar ends -->
<div class="ch-container">
    <div class="row">
        <!-- left menu starts -->
        <div class="col-sm-2 col-lg-2">
            <div class="sidebar-nav">
                <div class="nav-canvas">
                    <div class="nav-sm nav nav-stacked">
                    </div>
                    <ul class="nav nav-pills nav-stacked main-menu">
                    <#if menu??>
                        <#list menu as m>
                            <#if (m.list)??>
                                <#if  ((m.list)?size>1)>
                                    <@shiro.hasPermission name=m.url>
                                        <li class="accordion">
                                            <a href="javascript:void(0);"><i
                                                    class="glyphicon glyphicon-plus"></i><span> ${(m.name)!''}</span></a>
                                            <ul class="nav nav-pills nav-stacked" <#if m.url == curPath>
                                                style="display: block;"</#if>>
                                                <#list m.list as e>
                                                    <@shiro.hasPermission name=e.url>
                                                        <li  <#if e.isShow==0> style="display: none;"  </#if>><a
                                                                href="${base}${e.url}"> ${(e.name)!''}</a></li>

                                                    </@shiro.hasPermission>
                                                </#list>
                                            </ul>
                                        </li>
                                    </@shiro.hasPermission>
                                <#elseif (m.list)?size==1>
                                    <#list m.list as e>
                                        <@shiro.hasPermission name=e.url>
                                            <li <#if e.isShow==0> style="display: none;"  </#if>><a class="ajax-link"
                                                                                                    href="${base}${e.url}">
                                                <i class="glyphicon glyphicon-align-justify"></i><span> ${(e.name)!''}</span></a>
                                            </li>
                                        </@shiro.hasPermission>
                                    </#list>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                    </ul>
                </div>
            </div>
        </div>
        <!--/span-->
        <!-- left menu ends -->
        <div id="content" class="col-lg-10 col-sm-10">
            <!-- content starts -->
            <div>
                <ul class="breadcrumb">
                    <li>
                        <a id="page-url-title" href="javascript:void(0);"></a>
                    </li>
                    <li>
                        <a id="page-url-cur-title" href="javascript:void(0);"></a>
                    </li>
                </ul>
            </div>