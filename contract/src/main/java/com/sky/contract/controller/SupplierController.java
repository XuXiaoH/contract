package com.sky.contract.controller;

import com.mcp.validate.annotation.Check;
import com.sky.contract.mapper.SupplierMapper;
import com.sky.contract.model.Supplier;
import com.sky.contract.service.DictService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.PinyinUtil;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by shiqm on 2018/9/27.
 */

@Controller
@RequestMapping("supplier")
@PermissionName("供应商管理")
public class SupplierController extends BaseController {


    @Autowired
    private SupplierMapper supplierMapper;

    @Autowired
    private DictService dictService;

    /**
     * 供应商管理列表
     */
    @RequestMapping("list")
    @PermissionName("供应商管理列表")
    void list(ModelMap modelMap) {
        modelMap.put("list", supplierMapper.selectAll());
    }

    /**
     * 供应商添加页
     */
    @RequestMapping("add")
    @PermissionName("添加供应商")
    void add() {}

    /**
     * 供应商保存
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check String name,
            @Check Short type,
            @Check Short cType,
            String note,
            @Check String govcode,
            @Check String mobile,
            @Check String bank,
            @Check String bankCode,
            String attachs
    ) {
        Supplier supplier = new Supplier(name, type, govcode, mobile, bank, bankCode);
        supplier.setcType(cType);
        supplier.setNote(note);
        supplier.setAttachs(attachs);
        supplierMapper.insertSelective(supplier);
        return new Result();
    }

}
