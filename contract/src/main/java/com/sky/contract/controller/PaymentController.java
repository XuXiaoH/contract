package com.sky.contract.controller;

import com.alibaba.fastjson.JSONObject;
import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Invoice;
import com.sky.contract.model.Payment;
import com.sky.contract.service.InvoiceService;
import com.sky.contract.service.PaymentService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.DateUtil;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * Created by shiqm on 2018/9/27.
 */

@Controller
@RequestMapping("payment")
@PermissionName("款项管理")
public class PaymentController extends BaseController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private PaymentService paymentService;


    /**
     * 款项列表
     */
    @RequestMapping("list")
    @PermissionName("款项列表")
    void list(ModelMap modelMap) {
        modelMap.put("list",paymentService.getAll());
    }


    /**
     * 录入款项
     */
    @RequestMapping("add")
    @PermissionName(value = "录入款项", show = false)
    void add(
            ModelMap modelMap,
            @Check Long invoiceId
    ) {
        modelMap.put("invoice",invoiceService.get(invoiceId));
        modelMap.put("list",paymentService.getAllByInvoice(invoiceId));
    }


    /**
     * 保存款项
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check Long invoiceId,
            @Check Double money,
            @Check String handleTime,
            @Check String predictTime,
            String note
    ) {
        Payment payment=new Payment();
        payment.setInvoiceId(invoiceId);
        payment.setMoney(money);
        payment.setHandleTime(DateUtil.StringToDate(handleTime));
        payment.setPredictTime(DateUtil.StringToDate(predictTime));
        payment.setNote(note);
        paymentService.save(payment);
        return new Result();
    }


    /**
     * 款项
     */
    @RequestMapping(value = "getPayment", method = RequestMethod.POST)
    @ResponseBody
    JSONObject getPayment(@Check Long invoiceId) {
        List list = paymentService.getAllByInvoice(invoiceId);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", list.size());
        jsonObject.put("rows", list);
        return jsonObject;
    }

    /**
     * 更新数据
     */
    @RequestMapping(value = "updateNote", method = RequestMethod.POST)
    @PermissionName(value = "修改数据", parent = "list")
    @ResponseBody
    Result updateNote(
            @Check Long paymentId,
            @Check Double money,
            @Check Date handleTime,
            @Check Date predictTime,
            String note

    ) {
        Payment payment = new Payment();
        payment.setPaymentId(paymentId);
        payment.setMoney(money);
        payment.setHandleTime(handleTime);
        payment.setPredictTime(predictTime);
        payment.setNote(note);
        if (paymentService.updateNote(payment)) {
            return new Result();
        }
        return new Result("操作失败");
    }

    /**
     * 获取id
     */
    @RequestMapping(value = "getpay", method = RequestMethod.POST)
    @ResponseBody
    Result getpay(
            @Check Long paymentId
    ) {
        return new Result(paymentService.getpay(paymentId));
    }



    /**
     * 完结款项
     */
    @RequestMapping("finish")
    @ResponseBody
    Result finish(
            @Check Long paymentId
    ) {
        if (paymentService.updateStatus(paymentId,Short.valueOf("1"))) {
            return new Result();
        }
        return new Result("操作失败");

    }


}
