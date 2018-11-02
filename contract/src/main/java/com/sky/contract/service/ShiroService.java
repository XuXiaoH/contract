package com.sky.contract.service;

import com.sky.contract.util.shiro.PermissionSource;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by shiqm on 2018/9/18.
 */
@Service
public class ShiroService {

    @Autowired
    private AbstractShiroFilter abstractShiroFilter;

    @Autowired
    private PermissionSource permissionSource;


    /**
     * 重置所有权限
     */
    public void loadChainData() {
        PathMatchingFilterChainResolver pathMatchingFilterChainResolver = (PathMatchingFilterChainResolver) abstractShiroFilter.getFilterChainResolver();
        DefaultFilterChainManager defaultFilterChainManager = (DefaultFilterChainManager) pathMatchingFilterChainResolver.getFilterChainManager();
        defaultFilterChainManager.getFilterChains().clear();
        Map<String, String> map = permissionSource.loadFilterChainDefinitions();
        for (String chainName : map.keySet()) {
            defaultFilterChainManager.createChain(chainName, map.get(chainName));
        }
    }



}
