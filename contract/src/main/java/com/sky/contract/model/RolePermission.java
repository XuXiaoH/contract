package com.sky.contract.model;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by shiqm on 2018/9/27.
 */
@Table(name = "role_permission")
public class RolePermission {

    @Column
    private Long roleId;

    @Column
    private Long permissionId;


    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(Long permissionId) {
        this.permissionId = permissionId;
    }
}
