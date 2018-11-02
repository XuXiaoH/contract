package com.sky.contract.service;

import com.sky.contract.mapper.UserMapper;
import com.sky.contract.mapper.UserRoleMapper;
import com.sky.contract.model.User;
import com.sky.contract.model.UserRole;
import com.sky.contract.util.cons.Constant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by shiqm on 2018/9/13.
 */

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    public User getUser(String username) {
        return userMapper.selectOne(new User(username));
    }

    public List<User> getAll() {
        return userMapper.selectAll();
    }

    public List<User> getAllUser() {
        return userMapper.getAllUser();
    }

    public int save(User user) {
        return userMapper.insertSelective(user);
    }


    public boolean exist(User user) {
        if (userMapper.selectCount(user) > 0) {
            return true;
        }
        return false;
    }

    public boolean frozen(Long uid) {
        User user = new User();
        user.setUid(uid);
        user.setStatus(Constant.User_Status_Flag.FROZEN);
        if (userMapper.updateByPrimaryKeySelective(user) == 1) {
            return true;
        }
        return false;
    }

    public boolean thaw(Long uid) {
        User user = new User();
        user.setUid(uid);
        user.setStatus(Constant.User_Status_Flag.NOMAL);
        if (userMapper.updateByPrimaryKeySelective(user) == 1) {
            return true;
        }
        return false;
    }

    public void updateRoles(Long uid, Long[] roleIds) {
        UserRole userRole = new UserRole();
        userRole.setUid(uid);
        userRoleMapper.delete(userRole);
        if (roleIds.length > 0) {
            List<UserRole> list = new ArrayList<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRole temp = new UserRole();
                temp.setUid(uid);
                temp.setRoleId(roleIds[i]);
                list.add(temp);
            }
            userRoleMapper.insertList(list);
        }
    }

    public List<Long> getAllChildrenIds(Long uid) {
        List<Long> list = userMapper.getAllChildren(uid);
        for (int i = 0; i < list.size(); i++) {
            Long tempId = list.get(i);
            list.addAll(this.getAllChildrenIds(tempId));
        }
        return list;
    }


    public List<Long> getMyIds() {
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        List<Long> ids = this.getAllChildrenIds(user.getUid());
        ids.add(user.getUid());
        return ids;
    }

    public List<User> getAllChildrenUsers(Long uid) {
        List<Long> ids = this.getAllChildrenIds(uid);
        if (ids==null || ids.size()==0) {
            return null;
        }
        return userMapper.getUserByIds(this.getAllChildrenIds(uid));
    }


}
