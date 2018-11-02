package com.sky.contract.controller;

import com.mcp.validate.annotation.Check;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.Result;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by shiqm on 2018/9/12.
 */

@Controller
public class LoginController extends BaseController {



    /**
     * 首页
     */
    @RequestMapping("/")
    String home() {
        return "redirect:login";
    }

    /**
     * 登陆页
     */
    @RequestMapping("login")
    void login() {
    }


    /**
     * 登陆验证
     */
    @RequestMapping("checkUser")
    @ResponseBody
    Result checkUser(
            @Check(name = "用户名") String username,
            @Check(name = "密码") String password,
            @Check(name = "记住我", defaultValue = "false") boolean remember
    ) {
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        token.setRememberMe(remember);
        try {
            subject.login(token);
        } catch (UnknownAccountException e) {
            return new Result("用户名或密码错误");
        } catch (IncorrectCredentialsException e) {
            return new Result("用户名或密码错误");
        } catch (LockedAccountException e) {
            return new Result("账户已被冻结");
        } catch (Exception e) {
            return new Result("未知错误");
        }
        return new Result();
    }


}
