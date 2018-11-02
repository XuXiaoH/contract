package com.sky.contract.model;


import javax.persistence.*;
import java.util.Date;

/**
 * Created by shiqm on 2018/9/29.
 */

@Table(name = "project")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long projectId;

    @Column
    private String name;

    @Column
    private Long uid;

    @Column
    private Short type;

    @Column
    private Short cType;

    @Column
    private Short status;

    @Column
    private String note;

    @Column(name="createAt")
    private Date createAt;

    @Column(name="updateAt")
    private Date updateAt;

    @Transient
    private User user;


    public Project() {
    }

    public Project(String name, Long uid, Short type, String note) {
        this.name = name;
        this.uid = uid;
        this.type = type;
        this.note = note;
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Short getcType() {
        return cType;
    }

    public void setcType(Short cType) {
        this.cType = cType;
    }
}
