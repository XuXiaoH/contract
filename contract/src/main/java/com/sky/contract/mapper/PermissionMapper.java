package com.sky.contract.mapper;

import com.sky.contract.model.Permission;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by shiqm on 2018/9/18.
 */

@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    List<Permission> getMenuPermissions();

    List<Permission> getAllPermissions();

    List<Permission> getPermissionsByUid(Long uid);


    List<Permission> getPermissionsByRoleId(Long roleId);

}
