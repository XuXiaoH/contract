package com.sky.contract.model;


import javax.persistence.*;
import java.util.Date;

/**
 * Created by shiqm on 2018/9/29.
 */

@Table(name = "supplier")
public class Supplier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long supplierId;

    @Column
    private String name;

    @Column
    private Short type;

    @Column
    private Short cType;

    @Column
    private String govcode;

    @Column
    private String mobile;

    @Column
    private String bank;

    @Column
    private String note;

    @Column
    private String bankCode;

    @Column
    private String attachs;


    @Column(name="createAt")
    private Date createAt;

    @Column(name="updateAt")
    private Date updateAt;


    public Supplier() {
    }

    public Supplier(String name, Short type, String govcode, String mobile, String bank, String bankCode) {
        this.name = name;
        this.type = type;
        this.govcode = govcode;
        this.mobile = mobile;
        this.bank = bank;
        this.bankCode = bankCode;
    }

    public Long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public String getGovcode() {
        return govcode;
    }

    public void setGovcode(String govcode) {
        this.govcode = govcode;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
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

    public Short getcType() {
        return cType;
    }

    public void setcType(Short cType) {
        this.cType = cType;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getAttachs() {
        return attachs;
    }

    public void setAttachs(String attachs) {
        this.attachs = attachs;
    }
}
