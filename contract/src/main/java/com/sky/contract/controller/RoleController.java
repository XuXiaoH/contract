package com.sky.contract.controller;

import com.alibaba.fastjson.JSONObject;
import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Role;
import com.sky.contract.service.PermissionService;
import com.sky.contract.service.RoleService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Created by shiqm on 2018/9/18.
 */

@Controller
@RequestMapping("role")
@PermissionName("角色管理")
public class RoleController extends BaseController {

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private RoleService roleService;


    /**
     * 角色列表页
     */
    @RequestMapping("list")
    @PermissionName("角色列表")
    void list(ModelMap map) {
        map.put("list", roleService.getAll());
    }


    /**
     * 添加角色页
     */
    @RequestMapping("add")
    @PermissionName("添加角色")
    void add() {
    }

    /**
     * 保存 or 更新角色
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            Long roleId,
            @Check String name,
            Long[] permissionIds
    ) {
        if (roleId != null) {
            Role role=new Role();
            role.setRoleId(roleId);
            role.setName(name);
            roleService.update(role, permissionIds);
        }else{
            roleService.save(name, permissionIds);
        }
        return new Result();
    }

    /**
     *获取可分配所有权限
     */
    @RequestMapping("get_permission")
    @ResponseBody
    Result get_permission() {
        return new Result(permissionService.getAllPermissionForTree());
    }


    /**
     *根据角色ID 获取所有权限
     */
    @RequestMapping("get_permission_user")
    @ResponseBody
    @PermissionName(value = "编辑权限",parent = "list")
    Result get_permission_user(Long roleId) {
        JSONObject data = new JSONObject();
        data.put("e", roleService.get(roleId));
        data.put("list", permissionService.getAllPermissionForTree());
        data.put("target", permissionService.getPermissionsByRoleId(roleId));
        return new Result(data);
    }


}
