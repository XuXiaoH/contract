package com.sky.contract.service;

import com.sky.contract.mapper.RoleMapper;
import com.sky.contract.mapper.RolePermissionMapper;
import com.sky.contract.model.Role;
import com.sky.contract.model.RolePermission;
import com.sky.contract.util.PinyinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by shiqm on 2018/9/27.
 */

@Service
public class RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RolePermissionMapper rolePermissionMapper;

    public Role get(Long roleId){
        return roleMapper.selectByPrimaryKey(roleId);
    }


    public List<Role> getAll(){
        return roleMapper.selectAll();
    }


    public void save(String name, Long[] permissionIds) {
        Role role = new Role();
        role.setName(name);
        role.setType(PinyinUtil.cn2Spell(name));
        roleMapper.insertSelective(role);
        insertRolePermissions(role.getRoleId(),permissionIds);
    }

    public void insertRolePermissions(Long roleId,Long[] permissionIds){
        RolePermission rolePermission=new RolePermission();
        rolePermission.setRoleId(roleId);
        rolePermissionMapper.delete(rolePermission);
        if (permissionIds.length > 0) {
            List<RolePermission> list = new ArrayList<>();
            for (int i = 0; i < permissionIds.length; i++) {
                RolePermission temp = new RolePermission();
                temp.setRoleId(roleId);
                temp.setPermissionId(permissionIds[i]);
                list.add(temp);
            }
            rolePermissionMapper.insertList(list);
        }
    }


    public void update(Role role, Long[] permissionIds) {
        role.setType(PinyinUtil.cn2Spell(role.getName()));
        roleMapper.updateByPrimaryKey(role);
        insertRolePermissions(role.getRoleId(),permissionIds);
    }

    public List<Role> getRoleByUid(Long uid){
        return roleMapper.getRoleByUid(uid);
    }

}
