package com.sky.contract.controller;

import com.alibaba.fastjson.JSONObject;
import com.mcp.validate.annotation.Check;
import com.sky.contract.model.User;
import com.sky.contract.service.RoleService;
import com.sky.contract.service.UserService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import com.sky.contract.util.cons.Status;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by shiqm on 2018/9/12.
 */

@Controller
@RequestMapping("user")
@PermissionName("用户管理")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    /**
     * 用户列表页
     */
    @RequestMapping("list")
    @PermissionName("用户列表")
    void list(ModelMap map) {
        map.put("list", userService.getAll());
    }

    /**
     * 添加用户页
     */
    @RequestMapping("add")
    @PermissionName("添加用户")
    void add(ModelMap map) {
        map.put("users",userService.getAllUser());
    }

    /**
     * 保存用户信息
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check String username,
            @Check(defaultValue = "123456") String password,
            @Check String real_name,
            String note,
            Long pUid
    ) {
        User user = new User();
        user.setUsername(username);
        if (userService.exist(user)) {
            return new Result("用户名已经存在");
        }
        user.setPassword(new Md5Hash(password).toHex());
        user.setRealName(real_name);
        user.setNote(note);
        user.setpUid(pUid);
        if (userService.save(user) == 1) {
            return new Result();
        }
        return new Result("保存出错");
    }

    /**
     * 冻结用户
     */
    @RequestMapping("frozen")
    @PermissionName(value = "冻结用户", parent = "list")
    @ResponseBody
    Result frozen(
            @Check Long uid
    ) {
        if (userService.frozen(uid)) {
            return new Result();
        }
        return new Result("操作失败");

    }

    /**
     * 解冻用户
     */
    @RequestMapping("thaw")
    @PermissionName(value = "解冻用户", parent = "list")
    @ResponseBody
    Result thaw(
            @Check Long uid
    ) {
        if (userService.thaw(uid)) {
            return new Result();
        }
        return new Result("操作失败");
    }

    /**
     * 获取用户角色
     */
    @RequestMapping(value = "get_role", method = RequestMethod.POST)
    @ResponseBody
    @PermissionName(value = "设置角色", parent = "list")
    Result get_role(Long uid) {
        JSONObject data = new JSONObject();
        data.put("list", roleService.getAll());
        data.put("target", roleService.getRoleByUid(uid));
        return new Result(data);

    }

    /**
     * 更新用户角色
     */
    @RequestMapping(value = "set_role", method = RequestMethod.POST)
    @ResponseBody
    Result set_role(
            @Check Long uid,
            Long[] roleIds
    ) {
        userService.updateRoles(uid,roleIds);
        return new Result();
    }


}
