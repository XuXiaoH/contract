package com.sky.contract.util.cons;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by shiqm on 2018/9/25.
 */
public class Constant {


    /**
     * 图片上传设置
     */

    @Component
    public static class Picture_Upload{

        @Autowired
        private Environment env;

        private static Environment staticEnv;

        @PostConstruct
        public void beforeInit() {
            staticEnv = env;
        }

        public static String getPath() {
            return staticEnv.getProperty("constants.upload.path");
        }

        public static  String Path=null;

        public static final long Limit_Size=0;
    }




    /**
     * 权限类型
     */
    public static final class Permission_Type_Flag {
        /**
         * 页面URL
         */
        public static final Short PAGE_URL = 1;

        /**
         * AJAXURL
         */
        public static final Short AJAX_URL = 0;

    }


    /**
     * 用户状态
     */
    public static final class User_Status_Flag {
        /**
         * 正常
         */
        public static final Short NOMAL = 1;

        /**
         * 冻结
         */
        public static final Short FROZEN = 0;
    }


    /**
     * 合同类型
     */
    public static final class Contract_Type_Flag {
        /**
         * 甲方
         */
        public static final Short A = 0;

        /**
         * 乙方
         */
        public static final Short B = 1;
    }


}
