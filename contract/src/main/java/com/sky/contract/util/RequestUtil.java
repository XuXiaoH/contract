package com.sky.contract.util;

import com.sky.contract.mapper.PermissionMapper;
import com.sky.contract.model.Permission;
import com.sky.contract.util.annotation.Log;
import com.sky.contract.util.annotation.PermissionName;
import com.sky.contract.util.cons.Constant;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by shiqm on 2018/9/18.
 */

@Component
public class RequestUtil {

    @Autowired
    private PermissionMapper permissionMapper;

    @Log
    private Logger logger;


    /**
     * 初始化
     *
     * @param requestMappingHandlerMapping
     * @return
     */
    @Bean
    public CommandLineRunner customPermissionLoader(RequestMappingHandlerMapping requestMappingHandlerMapping) {
        return strings -> {
            logger.info("初始化permission----------------start");
            Map<String, Long> parentInfo = new HashMap<>();
            Map<String, Permission> mapForWaitParentToSave = new HashMap<>();
            Map<RequestMappingInfo, HandlerMethod> map = requestMappingHandlerMapping.getHandlerMethods();
            for (RequestMappingInfo requestMappingInfo : map.keySet()) {
                HandlerMethod method = map.get(requestMappingInfo);
                //看是否有设定的名称描述
                if (!method.hasMethodAnnotation(PermissionName.class)) {
                    continue;
                }
                PermissionName permissionName = method.getMethodAnnotation(PermissionName.class);
                String name = permissionName.value();
                Set<String> set = requestMappingInfo.getPatternsCondition().getPatterns();
                for (String url : set) {
                    //path会转换成范型
                    url = translatePathUrl(url);
                    Permission permission = new Permission(url);
                    //菜单是否已经存在
                    if (permissionMapper.selectCount(permission) > 0) {
                        continue;
                    }
                    //判断是否显示
                    if(!permissionName.show()){
                        permission.setIsShow(Short.valueOf("0"));
                    }
                    //区别ajax接口
                    if (method.hasMethodAnnotation(ResponseBody.class)) {
                        permission.setType(Constant.Permission_Type_Flag.AJAX_URL);
                    }
                    //获取父菜单ID
                    Long parentId;
                    Class beanType = method.getBeanType();
                    RequestMapping controllerMapper = (RequestMapping) beanType.getAnnotation(RequestMapping.class);
                    String parentUrl = controllerMapper.value()[0];
                    //判断指定父级菜单是否已经保存
                    if (!StringUtils.isEmpty(permissionName.parent())) {
                        permission.setName(name);
                        String pointParenUrl = "/" + parentUrl + "/" + permissionName.parent();
                        Permission query = new Permission();
                        query.setUrl(pointParenUrl);
                        if (permissionMapper.selectCount(query) == 0) {
                            //父级菜单未处理时，添加到待处理
                            mapForWaitParentToSave.put(pointParenUrl, permission);
                        } else {
                            query = permissionMapper.selectOne(query);
                            permission.setParentId(query.getPermissionId());
                            permissionMapper.insertSelective(permission);
                        }
                        continue;
                    }
                    if (parentInfo.containsKey(parentUrl)) {
                        parentId = parentInfo.get(parentUrl);
                    } else {
                        Permission parentObj = new Permission(parentUrl);
                        if (permissionMapper.selectCount(parentObj) == 0) {
                            if (beanType.isAnnotationPresent(PermissionName.class)) {
                                PermissionName parentPermissionName = (PermissionName) beanType.getAnnotation(PermissionName.class);
                                parentObj.setName(parentPermissionName.value());
                            } else {
                                parentObj.setName(parentUrl);
                            }
                            permissionMapper.insertSelective(parentObj);
                        } else {
                            parentObj = permissionMapper.selectOne(parentObj);
                        }
                        parentId = parentObj.getPermissionId();
                        parentInfo.put(parentUrl, parentId);
                    }
                    permission.setName(name);
                    permission.setParentId(parentId);
                    permissionMapper.insertSelective(permission);
                    //判断是否有待处理子菜单
                    if (mapForWaitParentToSave.containsKey(permission.getUrl())) {
                        Permission children = mapForWaitParentToSave.get(permission.getUrl());
                        children.setParentId(permission.getPermissionId());
                        permissionMapper.insertSelective(children);
                    }
                }
            }
            //将菜单数据读进缓存
            PermissionCache.list.addAll(permissionMapper.getMenuPermissions());
            logger.info("初始化permission----------------end");
        };
    }

    private String translatePathUrl(String content) {
        Pattern p_script = Pattern.compile("(?<=\\{)(.*?)(?=})");
        Matcher m_script = p_script.matcher(content);
        while (m_script.find()) {
            String temp = m_script.group();
            content = content.replace("{" + temp + "}", "*");
        }
        return content;
    }


}
