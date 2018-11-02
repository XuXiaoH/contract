package com.sky.contract.util.shiro;

import com.sky.contract.mapper.PermissionMapper;
import com.sky.contract.model.Permission;
import com.sky.contract.model.User;
import com.sky.contract.service.UserService;
import com.sky.contract.util.cons.Status;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by shiqm on 2018/9/12.
 */
public class AuthRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionMapper permissionMapper;




    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.getPrimaryPrincipal();
        String username = user.getUsername();
        Set<String> permissions = new HashSet<>();
        if (username.equals("sky")) {
            permissions.add("*");
        } else {
            List<Permission> list = permissionMapper.getPermissionsByUid(user.getUid());
            list.forEach(p -> permissions.add(p.getUrl()));
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(permissions);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String) token.getPrincipal();
        User user = userService.getUser(username);
        if (user == null) {
            throw new UnknownAccountException(); // 用户名错误
        }
        if (!Status.isSuccess(user.getStatus())) {
            throw new LockedAccountException(); // 账户已被冻结
        }
        // 如果身份认证验证成功，返回一个AuthenticationInfo实现；
        return new SimpleAuthenticationInfo(user, user.getPassword(), getName());
    }
}
