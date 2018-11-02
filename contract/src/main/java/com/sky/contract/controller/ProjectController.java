package com.sky.contract.controller;

import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Contract;
import com.sky.contract.model.Project;
import com.sky.contract.model.User;
import com.sky.contract.service.*;
import com.sky.contract.util.ArithUtil;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import com.sky.contract.util.cons.Constant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by shiqm on 2018/9/27.
 */

@Controller
@RequestMapping("project")
@PermissionName("项目管理")
public class ProjectController extends BaseController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @Autowired
    private ContractService contractService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private SupplierService supplierService;


    /**
     * 我的项目
     */
    @RequestMapping("my")
    @PermissionName("我的项目")
    void my(ModelMap modelMap) {
        modelMap.put("list", projectService.getMyProject());
    }


    /**
     * 项目列表页
     */
    @RequestMapping("list")
    @PermissionName("项目列表")
    void list(ModelMap modelMap) {
        modelMap.put("list", projectService.getAll());
    }


    /**
     * 项目列表页
     */
    @RequestMapping("report")
    @PermissionName(value = "项目报表", show = false)
    void report(ModelMap modelMap, @Check Long projectId) {
        List<Contract> aList = contractService.getAllByProject(projectId, Constant.Contract_Type_Flag.A);
        double money = 0;
        int invoiceNum = 0;
        for (int i = 0; i < aList.size(); i++) {
            Contract contract = aList.get(i);
            money = ArithUtil.add(money, contract.getRealMoney());
            invoiceNum += invoiceService.count(contract.getContractId());
        }
        List<Contract> bList = contractService.getAllByProject(projectId, Constant.Contract_Type_Flag.B);
        double supplierMoney = 0;
        for (int i = 0; i < bList.size(); i++) {
            Contract contract = bList.get(i);
            supplierMoney = ArithUtil.add(supplierMoney, contract.getRealMoney());
            invoiceNum += invoiceService.count(contract.getContractId());
        }
        modelMap.put("money", ArithUtil.mul(money, supplierMoney));
        modelMap.put("contractNum", aList.size() + bList.size());
        modelMap.put("invoiceNum", invoiceNum);
    }


    /**
     * 添加项目页
     */
    @RequestMapping("add")
    @PermissionName("添加项目")
    void add(ModelMap modelMap) {
        modelMap.put("users", userService.getAllChildrenUsers(this.getUser().getUid()));
    }

    /**
     * 保存项目
     */

    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check(name = "项目名称") String name,
            Long uid,
            @Check(name ="类型") Short type,
            Short cType,
            Short czType,
            String note
    ) {
        if(type.intValue()==0){
            if(cType==null){
                return new Result("运营类型不能为空");
            }
        }else if(type.intValue()==1){
            if(czType==null){
                return new Result("行政类型不能为空");
            }
            cType=czType;
        }
        if (uid == null || uid.intValue() == 0) {
            uid = this.getUser().getUid();
        }
        Project project = new Project(name, uid, type, note);
        project.setcType(cType);
        projectService.save(project);
        return new Result();
    }


    /**
     * 项目总览页
     */
    @RequestMapping("view")
    @PermissionName(value = "项目总览", show = false)
    void view(ModelMap modelMap, @Check Long projectId) {
        modelMap.put("project", projectService.get(projectId));
        modelMap.put("listForA", contractService.getAllByProject(projectId, Constant.Contract_Type_Flag.A));
        modelMap.put("listForB", contractService.getContractByProjectIdAndType(projectId, Constant.Contract_Type_Flag.B));
        //获取供应商信息
        modelMap.put("supplierA", supplierService.getAllByType(Short.valueOf("0")));
        modelMap.put("supplierB", supplierService.getAllByType(Short.valueOf("1")));
    }

    /**
     * 待审核列表
     */
    @RequestMapping("auditing")
    @PermissionName("待审核列表")
    void auditing(ModelMap modelMap) {
        modelMap.put("list",projectService.getMyProjectByStatus(Short.valueOf("1")));
    }

    /**
     * 审核状态更新
     */
    @RequestMapping("update_auditing")
    @ResponseBody
    @PermissionName(value = "审核",parent = "auditing")
    Result update_auditing(
            @Check Long projectId
    ){
        if(projectService.updateStatus(projectId,Short.valueOf("2"))){
            return new Result();
        }
        return new Result("审核失败");
    }

    /**
     * 驳回状态更新
     */
    @RequestMapping("update_out")
    @ResponseBody
    @PermissionName(value = "驳回",parent = "auditing")
    Result update_out(
            @Check Long projectId
    ){
        if(projectService.updateStatus(projectId,Short.valueOf("0"))){
            return new Result();
        }
        return new Result("驳回失败");
    }





//    /**
//     * 项目统计页
//     */
//    @RequestMapping("statistic")
//    @PermissionName("项目统计")
//    void statistic() {
//    }

}
