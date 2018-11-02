package com.sky.contract.util.shiro;

import com.sky.contract.mapper.PermissionMapper;
import com.sky.contract.model.Permission;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by shiqm on 2018/9/18.
 */
public class PermissionSource {

    @Autowired
    private PermissionMapper permissionMapper;


    public LinkedHashMap<String, String> loadFilterChainDefinitions() {
        LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap();
        filterChainDefinitionMap.put("/logout", "logout");
        // 配置不会被拦截的链接 顺序判断
        List<Permission> list = permissionMapper.selectAll();
        list.forEach(p -> {
                    filterChainDefinitionMap.put(p.getUrl(), "authc,perms[" + p.getUrl() + "]");
                }
        );
        return filterChainDefinitionMap;
    }

}
