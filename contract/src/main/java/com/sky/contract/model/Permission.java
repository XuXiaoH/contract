package com.sky.contract.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by shiqm on 2018/9/18.
 */
@Table
public class Permission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long permissionId;

    @Column
    private String name;

    @Column
    private String url;

    @Column
    private Long parentId;

    @Column
    private Short type;

    @Column
    private Short sort;

    @Column
    private Short isShow;

    @Transient
    private List<Permission> list = new ArrayList<>();


    public Permission() {
    }

    public Permission(String url) {
        this.url = url;
    }

    public Long getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(Long permissionId) {
        this.permissionId = permissionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public Short getSort() {
        return sort;
    }

    public void setSort(Short sort) {
        this.sort = sort;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public List<Permission> getList() {
        return list;
    }

    public void setList(List<Permission> list) {
        this.list = list;
    }

    public Short getIsShow() {
        return isShow;
    }

    public void setIsShow(Short isShow) {
        this.isShow = isShow;
    }
}
