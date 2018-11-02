package com.sky.contract.controller;

import com.alibaba.fastjson.JSONObject;
import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Invoice;
import com.sky.contract.service.ContractService;
import com.sky.contract.service.InvoiceService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.DateUtil;
import com.sky.contract.util.Result;
import com.sky.contract.util.TemplateUtils;
import com.sky.contract.util.annotation.PermissionName;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by shiqm on 2018/9/27.
 */

@Controller
@RequestMapping("invoice")
@PermissionName("发票管理")
public class InvoiceController extends BaseController{

    @Autowired
    private ContractService contractService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private TemplateUtils templateUtils;

    /**
     * 录入发票页
     */
    @RequestMapping("add")
    @PermissionName(value = "录入发票", show = false)
    void add(
            ModelMap modelMap,
            @Check String contractId
    ) {
        modelMap.put("contract", contractService.get(contractId));
        modelMap.put("list", invoiceService.getALlByContract(contractId));
    }

    /**
     * 发票列表页
     */
    @RequestMapping("list")
    @PermissionName("发票列表")
    void list(ModelMap modelMap) {
        modelMap.put("list", invoiceService.getAll());
    }

    /**
     * 保存发票
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check String contractId,
            @Check String number,
            @Check Short type,
            @Check(name = "金额",number = true) Double money,
            @Check(defaultValue = "0") Double tax,
            @Check(name = "开具时间") String offerTime,
            String note,
            String attachs
    ) {
        Invoice invoice = new Invoice();
        invoice.setContractId(contractId);
        invoice.setNumber(number);
        invoice.setType(type);
        invoice.setMoney(money);
        invoice.setTax(tax);
        invoice.setOfferTime(DateUtil.StringToDate(offerTime));
        invoice.setNote(note);
        invoice.setAttachs(attachs);
        invoiceService.save(invoice);
        return new Result();
    }

    /**
     * 发票
     */
    @RequestMapping(value = "getInvoice", method = RequestMethod.POST)
    @ResponseBody
    JSONObject getInvoice(@Check String contractId) {
        List list = invoiceService.getALlByContract(contractId);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", list.size());
        jsonObject.put("rows", list);
        return jsonObject;
    }

}
