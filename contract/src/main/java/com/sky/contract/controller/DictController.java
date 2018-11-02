package com.sky.contract.controller;

import com.mcp.validate.annotation.Check;
import com.sky.contract.model.Dict;
import com.sky.contract.service.DictService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.PinyinUtil;
import com.sky.contract.util.Result;
import com.sky.contract.util.annotation.PermissionName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by daNuo.
 */

@Controller
@RequestMapping("dict")
public class DictController extends BaseController {

    @Autowired
    private DictService dictService;


    /**
     * 字典列表
     */
    @RequestMapping("list")
    @PermissionName(value = "字典列表")
    void list(
            ModelMap modelMap
    ) {
        modelMap.put("list", dictService.getAll());
        modelMap.put("parent", dictService.getAllParent());
    }

    /**
     * 保存
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    Result save(
            @Check Short type,
            Long pid,
            String name,
            Short sort

    ) {
        Dict dict = new Dict();
        dict.setType(type);
        //父级时
        if (dict.getType().intValue() == 0) {
            if (StringUtils.isEmpty(name)) {
                return new Result("名称不能为空");
            }
            dict.setTitle(PinyinUtil.cn2Spell(name));
            if(dictService.exist(dict.getTitle())){
                return new Result("已经存在");
            }
        }
        //子级时
        else {
            if (StringUtils.isEmpty(pid)) {
                return new Result("父级不能为空");
            }
            if (StringUtils.isEmpty(name)) {
                return new Result("名称不能为空");
            }
            dict.setCode(dictService.getMaxCode(pid));
        }
        dict.setPid(pid);
        dict.setName(name);
        dict.setSort(sort);
        dictService.save(dict);
        return new Result();
    }

    /**
     * 更新数据
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @PermissionName(value = "更新数据", parent = "list")
    @ResponseBody
    Result update(
            @Check Long dictId,
            @Check String name,
            @Check(defaultValue = "0") Short sort

    ) {
        Dict dict = new Dict();
        dict.setDictId(dictId);
        dict.setName(name);
        dict.setSort(sort);
        if (dictService.update(dict)) {
            return new Result();
        }
        return new Result("操作失败");
    }

    /**
     * 获取字典
     */
    @RequestMapping(value = "get", method = RequestMethod.POST)
    @ResponseBody
    Result get(
            @Check Long dictId
    ) {
        return new Result(dictService.get(dictId));
    }



}
