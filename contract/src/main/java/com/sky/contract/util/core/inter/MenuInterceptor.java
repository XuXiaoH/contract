package com.sky.contract.util.core.inter;

import com.sky.contract.util.PermissionCache;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by shiqm on 2018/9/25.
 */
public class MenuInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        HttpSession httpSession = httpServletRequest.getSession();
        if (httpSession.getAttribute("menu") == null) {
            httpSession.setAttribute("menu", PermissionCache.list);
        }
        String curPath = httpServletRequest.getServletPath().split("/")[1];
        httpSession.setAttribute("curPath", curPath);
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
