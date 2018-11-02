package com.sky.contract.mapper;

import com.sky.contract.model.User;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by shiqm on 2018/9/13.
 */

@Mapper
public interface UserMapper extends BaseMapper<User> {

    List<User> getAllUser();

    List<Long> getAllChildren(@Param("pUid")Long uid);

    List<User> getUserByIds(@Param("ids") List<Long> ids);

}
