package com.sky.contract.util.db;

import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import tk.mybatis.spring.annotation.MapperScan;

import javax.sql.DataSource;

/**
 * Created by shiqm on 2018/9/13.
 */
@Configuration
@MapperScan(basePackages = "com.sky.contract.mapper", sqlSessionTemplateRef = "contractSessionTemplate")
public class DBConfig {

    @Bean("contractDataSource")
    @ConfigurationProperties("spring.datasource.contract")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean("contractSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Qualifier("contractDataSource") DataSource dataSource,@Qualifier("modelInterceptor") ModelInterceptor modelInterceptor) throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        bean.setPlugins(new Interceptor[]{modelInterceptor});
        bean.setTypeHandlers(new TypeHandler[]{new MyDateTypeHandle()});
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper//*.xml"));
        return bean.getObject();
    }

    @Bean("contractTransactionManager")
    public DataSourceTransactionManager transactionManager(@Qualifier("contractDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean("contractSessionTemplate")
    public SqlSessionTemplate sqlSessionTemplate(@Qualifier("contractSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }



}
