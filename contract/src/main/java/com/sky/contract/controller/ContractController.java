package com.sky.contract.controller;

import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Contract;
import com.sky.contract.service.ContractService;
import com.sky.contract.service.ProjectService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.DateUtil;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import com.sky.contract.util.cons.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.ref.PhantomReference;

/**
 * Created by shiqm on 2018/9/27.
 */

@Controller
@RequestMapping("contract")
@PermissionName("合同管理")
public class ContractController extends BaseController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private ContractService contractService;


    /**
     * 录入合同页
     */
    @RequestMapping("add")
    @PermissionName(value = "录入合同", show = false)
    void add(
            ModelMap modelMap,
            @Check Long projectId
    ) {
        modelMap.put("project", projectService.get(projectId));
        modelMap.put("listForA", contractService.getAllByProject(projectId, Constant.Contract_Type_Flag.A));
        modelMap.put("listForB", contractService.getAllByProject(projectId, Constant.Contract_Type_Flag.B));
    }

    /**
     * 保存合同
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check(name = "合同名称") String name,
            String pr,
            String po,
            @Check(name = "合同金额", number = true) Double money,
            @Check(name = "真实金额", number = true) Double realMoney,
            @Check(name = "签订时间") String conformTime,
            @Check(name = "开始时间") String startTime,
            @Check(name = "结束时间") String endTime,
            String note,
            @Check Short type,
            @Check Long projectId,
            String attachs,
            Long supplierId,
            Long supplierZId,
            String pid
    ) {
        if (type.intValue() == 0) {
            if (supplierId == null) {
                return new Result("合作商不能为空");
            }
        } else if (type.intValue() == 1) {
            if (supplierZId == null) {
                return new Result("供应商不能为空");
            }
            supplierId = supplierZId;
        }
        Contract contract = new Contract();
        contract.setName(name);
        contract.setPr(pr);
        contract.setPo(po);
        contract.setMoney(money);
        contract.setRealMoney(realMoney);
        contract.setConformTime(DateUtil.StringToDate(conformTime));
        contract.setStartTime(DateUtil.StringToDate(startTime));
        contract.setEndTime(DateUtil.StringToDate(endTime));
        contract.setNote(note);
        contract.setType(type);
        contract.setProjectId(projectId);
        contract.setAttachs(attachs);
        contract.setSupplierId(supplierId);
        contract.setPid(pid);
        contractService.save(contract);
        return new Result();
    }


    /**
     * 待审核
     */
    @RequestMapping("auditing")
    @PermissionName("待审核列表")
    void auditing(ModelMap modelMap) {
        modelMap.put("list", contractService.getMyContract(Short.valueOf("1")));
    }


    /**
     * 审核状态更新
     */
    @RequestMapping("update_auditing")
    @ResponseBody
    @PermissionName(value = "审核", parent = "auditing")
    Result update_auditing(
            @Check String contractId
    ) {
        contractService.updateStatus(contractId, Short.valueOf("2"));
        return new Result();
    }


    /**
     * 驳回状态更新
     */
    @RequestMapping("update_out")
    @ResponseBody
    @PermissionName(value = "驳回", parent = "auditing")
    Result update_out(
            @Check String contractId
    ) {
        contractService.updateStatus(contractId, Short.valueOf("0"));
        return new Result();
    }


    /**
     * 验收状态更新
     */
    @RequestMapping("update_play")
    @ResponseBody
    @PermissionName(value = "验收", parent = "play")
    Result update_play(
            @Check String contractId
    ) {
        contractService.updateStatus(contractId, Short.valueOf("3"));
        return new Result();
    }

    /**
     * 归档状态更新
     */
    @RequestMapping("update_check")
    @ResponseBody
    @PermissionName(value = "归档", parent = "check")
    Result update_check(
            @Check String contractId
    ) {
        contractService.updateStatus(contractId, Short.valueOf("4"));
        return new Result();
    }

    /**
     * 进行中合同页
     */
    @RequestMapping("play")
    @PermissionName("进行中")
    void play(ModelMap modelMap) {
        modelMap.put("list", contractService.getMyContract(Short.valueOf("2")));
    }

    /**
     * 验收中合同页
     */
    @RequestMapping("check")
    @PermissionName("验收中")
    void check(ModelMap modelMap) {
        modelMap.put("list", contractService.getMyContract(Short.valueOf("3")));
    }

    /**
     * 归档中合同页
     */
    @RequestMapping("finish")
    @PermissionName("归档中")
    void finish(ModelMap modelMap) {
        modelMap.put("list", contractService.getMyContract(Short.valueOf("4")));
    }


    /**
     * 合同列表
     */
    @RequestMapping("list")
    @PermissionName("合同列表")
    void list(ModelMap modelMap) {
        modelMap.put("list", contractService.getAllByStatus(null));
    }


}
