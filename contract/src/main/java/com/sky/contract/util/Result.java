package com.sky.contract.util;


/**
 * Created by shiqm on 2018/9/15.
 */
public class Result {

    private int code;

    private String message;

    private Object data;

    public Result() {
        this.code = 10000;
        this.message = "success";
    }

    public Result(String message) {
        this.code = 9999;
        this.message = message;
    }

    public Result(Object data) {
        this.code = 10000;
        this.message = "success";
        this.data = data;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Result append(Object data) {
        this.data = data;
        return this;
    }


}
