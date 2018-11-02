package com.sky.contract.util.core;

import com.sky.contract.util.core.inter.MenuInterceptor;
import com.sky.contract.util.core.inter.ResourceInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by shiqm on 2017/3/17.
 */

@Configuration
public class WebInterceptor extends WebMvcConfigurerAdapter {


    @Bean
    public ResourceInterceptor getResourceInterceptor(){
        return new ResourceInterceptor();
    }

    @Bean
    public MenuInterceptor getMenuInterceptor(){
        return new MenuInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(getResourceInterceptor()).addPathPatterns("/**");
        registry.addInterceptor(getMenuInterceptor()).addPathPatterns("/*/**");
        super.addInterceptors(registry);
    }
}
