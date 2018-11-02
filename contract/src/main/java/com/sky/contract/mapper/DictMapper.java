package com.sky.contract.mapper;

import com.sky.contract.model.Dict;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by shiqm on 2018/9/18.
 */

@Mapper
public interface DictMapper extends BaseMapper<Dict> {

    Short getMaxCodeByPid(Long pid);

    List<Dict> getAll();

    String getName(@Param("title")String title,@Param("code") Short code);

}
