package com.sky.contract.model;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by shiqm on 2018/9/27.
 */

@Table(name = "user_role")
public class UserRole {

    @Column
    private Long uid;

    @Column
    private Long roleId;


    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }
}
