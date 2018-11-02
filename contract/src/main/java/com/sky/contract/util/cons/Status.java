package com.sky.contract.util.cons;

/**
 * Created by shiqm on 2018/9/17.
 */
public class Status {

    private static final Short OK = 1;

    public static boolean isSuccess(Short status) {
        if (status.compareTo(OK) == 0) {
            return true;
        }
        return false;
    }


}
