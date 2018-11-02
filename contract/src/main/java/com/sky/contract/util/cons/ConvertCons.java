package com.sky.contract.util.cons;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by shiqm on 2018/9/29.
 */
public class ConvertCons {

    public static final class UserStatusCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"冻结");
            map.put(1,"正常");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class SupplierTypeCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"合作商");
            map.put(1,"供应商");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class ProjectTypeCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"运营");
            map.put(1,"购置");
        }
        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class ProjectStatusCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"驳回");
            map.put(1,"待审核");
            map.put(2,"进行中");
        }
        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class DictStatusCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"隐藏");
            map.put(1,"显示");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class DictTypeCover {
        public static final Map<Integer, String> map = new HashMap();
        static {
            init();
        }
        public static void init() {
            map.put(0,"父级");
            map.put(1,"子级");
        }
        public static String get(Integer key) {
            return map.get(key);
        }
    }




    public static final class ContractStatusCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"驳回");
            map.put(1,"待审核");
            map.put(2,"进行中");
            map.put(3,"验收");
            map.put(4,"归档");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }

    public static final class ContractTypeCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"甲方合同");
            map.put(1,"乙方合同");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }


    public static final class InvoiceTypeCover {
        public static final Map<Integer, String> map = new HashMap();

        static {
            init();
        }

        public static void init() {
            map.put(0,"普通发票");
            map.put(1,"增值税发票");
        }

        public static String get(Integer key) {
            return map.get(key);
        }
    }


}
