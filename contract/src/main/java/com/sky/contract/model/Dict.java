package com.sky.contract.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by daNuo.
 */

@Table(name = "dict")
public class Dict {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long dictId;

    @Column
    private Long pid;

    @Column
    private Short code;

    @Column
    private String name;

    @Column
    private String title;

    @Column
    private Short sort;

    @Column
    private Short type;

    @Column
    private Short status;

    @Transient
    private Dict parent;

    @Column(name="createAt")
    private Date createAt;

    @Column(name="updateAt")
    private Date updateAt;


    public Long getDictId() {
        return dictId;
    }

    public void setDictId(Long dictId) {
        this.dictId = dictId;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Short getCode() {
        return code;
    }

    public void setCode(Short code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Short getSort() {
        return sort;
    }

    public void setSort(Short sort) {
        this.sort = sort;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }


    public Dict getParent() {
        return parent;
    }

    public void setParent(Dict parent) {
        this.parent = parent;
    }
}
