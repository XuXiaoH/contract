package com.sky.contract.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.mcp.validate.annotation.Check;
import com.sky.contract.mapper.PermissionMapper;
import com.sky.contract.model.Permission;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.PermissionCache;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * Created by shiqm on 2018/9/25.
 */
@Controller
@RequestMapping("permission")
@PermissionName("权限管理")
public class PermissionController extends BaseController {

    @Autowired
    private PermissionMapper permissionMapper;


    /**
     * 权限列表页
     */
    @RequestMapping("list")
    @PermissionName("权限列表")
    void list() {
    }


    /**
     * 获取权限列表数据
     */
    @RequestMapping(value = "get_list",method = RequestMethod.POST)
    @ResponseBody
    Object get_list(@Check(defaultValue = "0") Long parent_id) {
        Permission permission = new Permission();
        permission.setParentId(parent_id);
        List list = permissionMapper.select(permission);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", list.size());
        jsonObject.put("rows", list);
        return jsonObject;
    }

    /**
     * 获取权限列表数据
     */
    @RequestMapping(value = "update_sort",method = RequestMethod.POST)
    @ResponseBody
    Result update_sort(
            @Check Long permissionId,
            @Check Short sort
    ) {
        Permission permission = new Permission();
        permission.setPermissionId(permissionId);
        permission.setSort(sort);
        permissionMapper.updateByPrimaryKeySelective(permission);
        PermissionCache.list.clear();
        PermissionCache.list.addAll(permissionMapper.getMenuPermissions());
        return new Result();
    }


}
