package com.sky.contract.service;

import com.sky.contract.mapper.PermissionMapper;
import com.sky.contract.model.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by shiqm on 2018/9/25.
 */

@Service
public class PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    public List<Permission> getAllPermissionForTree() {
        List<Permission> list = permissionMapper.selectAll();
        List<Permission> result = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Permission permission = list.get(i);
            if (permission.getParentId() == 0) {
                result.add(permission);
            }
            installTree(permission, list, i);
        }
        return result;
    }

    private void installTree(Permission target, List<Permission> list, int i) {
        for (int m = i; m < list.size(); m++) {
            Permission permission = list.get(m);
            if (target.getPermissionId().compareTo(permission.getParentId()) == 0) {
                target.getList().add(permission);
            }
        }
    }


    public List<Permission> getPermissionsByRoleId(Long roleId){
        return permissionMapper.getPermissionsByRoleId(roleId);
    }

}
