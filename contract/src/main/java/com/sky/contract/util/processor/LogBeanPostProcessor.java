package com.sky.contract.util.processor;

import com.sky.contract.util.annotation.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.ReflectionUtils;


/**
 * Created by shiqm on 2018/9/15.
 */

@Configuration
public class LogBeanPostProcessor implements BeanPostProcessor {


    @Override
    public Object postProcessBeforeInitialization(Object o, String s) throws BeansException {
        Class clazz = o.getClass();
        initializeLog(o, clazz);
        return o;
    }

    @Override
    public Object postProcessAfterInitialization(Object o, String s) throws BeansException {
        return o;
    }


    private void initializeLog(final Object bean, final Class<? extends Object> clazz) {
        ReflectionUtils.doWithFields(clazz, field -> {
            boolean visable = field.isAccessible();
            try {
                field.setAccessible(true);
                if (field.get(bean) == null) {
                    field.set(bean, LoggerFactory.getLogger(clazz));
                }
            } catch (Exception e) {
                throw new BeanInitializationException(String.format(
                        "初始化logger失败!bean=%s;field=%s", bean, field));
            } finally {
                field.setAccessible(visable);
            }
        }, field -> {
            if (field.getAnnotation(Log.class) == null) {
                return false;
            }
            if (!field.getType().isAssignableFrom(Logger.class)) {
                return false;
            }
            return true;
        });
    }




}
