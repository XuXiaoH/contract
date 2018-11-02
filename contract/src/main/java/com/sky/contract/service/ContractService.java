package com.sky.contract.service;

import com.github.pagehelper.PageHelper;
import com.sky.contract.mapper.ContractMapper;
import com.sky.contract.model.Contract;
import com.sky.contract.model.Project;
import com.sky.contract.model.User;
import com.sky.contract.util.DateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by shiqm on 2018/9/29.
 */

@Service
public class ContractService {

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private ProjectService projectService;


    public List<Contract> getAllByProject(Long projectId, Short type) {
        Contract contract = new Contract();
        contract.setProjectId(projectId);
        contract.setType(type);
        return contractMapper.select(contract);
    }

    private String createBusinessContractId(Date date, String preId) {
        String prex = "S";
        int year = DateUtil.getYear(date);
        int month = DateUtil.getMonth(date);
        if (StringUtils.isEmpty(preId)) {
            return prex + DateUtil.DateToString(date, "yyMM001");
        }
        String str = preId.substring(1, preId.length() - 3);
        Date temp = DateUtil.StringToDate(str, "yyMM");
        int tempYear = DateUtil.getYear(temp);
        int tempMonth = DateUtil.getMonth(temp);
        if (year > tempYear) {
            return prex + DateUtil.DateToString(date, "yyMM001");
        }
        if (month > tempMonth) {
            return prex + DateUtil.DateToString(date, "yyMM001");
        }
        str = preId.substring(preId.length() - 3, preId.length());
        int cur = Integer.parseInt(str) + 1;
        return prex + DateUtil.DateToString(date, "yyMM") + trans2Index(cur);
    }

    private String trans2Index(int num) {
        if (num < 10) {
            return "00" + num;
        }
        if (num < 100) {
            return "0" + num;
        }
        if (num < 1000) {
            return String.valueOf(num);
        }
        return "";
    }


    private String createBuyContractId(Date date, String preId) {
        String prex = "E";
        int year = DateUtil.getYear(date);
        if (StringUtils.isEmpty(preId)) {
            return prex + DateUtil.DateToString(date, "yy001");
        }
        String str = preId.substring(1, preId.length() - 3);
        Date temp = DateUtil.StringToDate(str, "yy");
        int tempYear = DateUtil.getYear(temp);
        if (year > tempYear) {
            return prex + DateUtil.DateToString(date, "yy001");
        }
        str = preId.substring(preId.length() - 3, preId.length());
        int cur = Integer.parseInt(str) + 1;
        return prex + DateUtil.DateToString(date, "yy") + trans2Index(cur);
    }

    public String createContractId(Short projectType, Date date, String preId) {
        //购置类项目，编号E
        if (projectType.intValue() == 0) {
            return createBusinessContractId(date, preId);
        }
        return createBuyContractId(date, preId);
    }

    public void save(Contract contract) {
        String id;
        //父合同
        if (StringUtils.isEmpty(contract.getPid())) {
            Project project = projectService.get(contract.getProjectId());
            Date date = new Date();
            PageHelper.startPage(1, 1);
            PageHelper.orderBy("createAt desc");
            List<Contract> list;
            if(project.getType()==0){
                list = contractMapper.getContractByProjectTypeAndContractType(project.getType(),contract.getType());
            }else{
                list = contractMapper.getContractByProjectTypeAndContractType(project.getType(),null);
            }
            if (list==null || list.size() == 0) {
                id = createContractId(project.getType(), date, null);
            } else {
                Contract temp = list.get(0);
                String tempId = temp.getContractId();
                id = createContractId(project.getType(), date, tempId);
            }
        }
        //子合同
        else {
            PageHelper.startPage(1, 1);
            PageHelper.orderBy("createAt desc");
            Contract query = new Contract();
            query.setPid(contract.getPid());
            List<Contract> list = contractMapper.select(query);
            if (list.size() == 0) {
                id = createChildrenId(contract.getPid(), null);
            } else {
                Contract temp = list.get(0);
                String tempId = temp.getContractId();
                id = createChildrenId(contract.getPid(), tempId);
            }
        }
        contract.setContractId(id);
        contractMapper.insertSelective(contract);
    }


    private String createChildrenId(String contractId, String preId) {
        if (StringUtils.isEmpty(preId)) {
            return "C" + contractId.split("S")[1] + "01";
        }
        int cur = Integer.parseInt(preId.split(contractId.split("S")[1])[1]) + 1;
        return "C" + contractId.split("S")[1] + trans2ChildrenIndex(cur);
    }

    private String trans2ChildrenIndex(int num) {
        if (num < 10) {
            return "0" + num;
        }
        if (num < 100) {
            return String.valueOf(num);
        }
        return "";
    }


    public Contract get(String contractId) {
        return contractMapper.selectByPrimaryKey(contractId);
    }


    public List<Contract> getAllByStatus(Short status) {
        Contract contract = new Contract();
        contract.setStatus(status);
        return contractMapper.select(contract);
    }


    public void updateStatus(String contractId, Short status) {
        Contract contract = new Contract();
        contract.setContractId(contractId);
        contract.setStatus(status);
        contractMapper.updateByPrimaryKeySelective(contract);
    }


    public List<Contract> getMyContract(Short status) {
        List<Long> ids = userService.getMyIds();
        return contractMapper.getContractByUsers(ids, status);
    }

    public List<Contract> getContractByProjectIdAndType(Long projectId, Short type) {
        return contractMapper.getContractByProjectIdAndType(projectId, type);
    }


}
