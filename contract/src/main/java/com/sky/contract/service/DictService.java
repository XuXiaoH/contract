package com.sky.contract.service;

import com.github.pagehelper.PageHelper;
import com.sky.contract.mapper.DictMapper;
import com.sky.contract.model.Dict;
import com.sky.contract.util.PinyinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by daNuo.
 */

@Service
public class DictService {

    @Autowired
    private DictMapper dictMapper;


    public List<Dict> getAll() {
        PageHelper.orderBy("createAt desc");
        return dictMapper.getAll();
    }

    public List<Dict> getAllParent() {
        Dict dict = new Dict();
        dict.setType(Short.valueOf("0"));
        return dictMapper.select(dict);
    }

    public void save(Dict dict) {
        dictMapper.insertSelective(dict);
    }


    public Short getMaxCode(Long pid) {
        Short temp = dictMapper.getMaxCodeByPid(pid);
        if (temp == null) {
            return Short.valueOf("0");
        }
        return Short.valueOf(String.valueOf(temp.intValue() + 1));
    }

    public List<Dict> getAllByTitle(String title) {
        title = PinyinUtil.cn2Spell(title);
        Dict dict = new Dict();
        dict.setTitle(title);
        dict = dictMapper.selectOne(dict);
        if (dict == null) {
            return new ArrayList<Dict>();
        }
        Dict query = new Dict();
        query.setPid(dict.getDictId());
        PageHelper.orderBy("sort asc");
        return dictMapper.select(query);
    }

    public String getName(String title, Short code) {
        return dictMapper.getName(PinyinUtil.cn2Spell(title), code);
    }


    public boolean update(Dict dict){
        if(dictMapper.updateByPrimaryKeySelective(dict)==1){
            return true;
        }
        return false;
    }

    public Dict get(Long dictId){
        return dictMapper.selectByPrimaryKey(dictId);
    }


    public boolean exist(String title){
        Dict dict=new Dict();
        dict.setTitle(title);
        if(dictMapper.selectCount(dict)>0){
            return true;
        }
        return false;

    }


}
