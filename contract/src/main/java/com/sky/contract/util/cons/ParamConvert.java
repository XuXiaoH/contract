package com.sky.contract.util.cons;

import com.sky.contract.model.Dict;
import com.sky.contract.service.DictService;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by shiqm on 2018/9/26.
 */
public class ParamConvert implements TemplateMethodModelEx {

    @Autowired
    private DictService dictService;


    @Override
    public Object exec(List list) throws TemplateModelException {
        if (null != list) {
            String key = list.get(0).toString();
            if (1 == list.size()) {
                switch (key) {
                    case "supplierType":
                        return ConvertCons.SupplierTypeCover.map;
                    case "projectType":
                        return ConvertCons.SupplierTypeCover.map;
                    case "invoiceType":
                        return ConvertCons.InvoiceTypeCover.map;
                    default:
                        return getSource(key);
                }
            } else {
                switch (key) {
                    case "userStatus":
                        return ConvertCons.UserStatusCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "projectType":
                        return ConvertCons.ProjectTypeCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "contractStatusCover":
                        return ConvertCons.ContractStatusCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "contractTypeCover":
                        return ConvertCons.ContractTypeCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "invoiceType":
                        return ConvertCons.InvoiceTypeCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "dictStatus":
                        return ConvertCons.DictStatusCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    case "dictType":
                        return ConvertCons.DictTypeCover.get(Integer.parseInt(String.valueOf(list.get(1))));
                    default:
                        return getName(key, Short.valueOf(String.valueOf(list.get(1))));

                }
            }
        }
        return null;
    }

    public String getName(String title, Short code) {
        return dictService.getName(title, code);
    }

    public List<Dict> getSource(String title) {
        List list = dictService.getAllByTitle(title);
        return list;
    }


}
