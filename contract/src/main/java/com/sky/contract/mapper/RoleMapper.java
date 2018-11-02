package com.sky.contract.mapper;

import com.sky.contract.model.Role;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by shiqm on 2018/9/18.
 */

@Mapper
public interface RoleMapper extends BaseMapper<Role> {


    public List<Role> getRoleByUid(Long uid);

}
