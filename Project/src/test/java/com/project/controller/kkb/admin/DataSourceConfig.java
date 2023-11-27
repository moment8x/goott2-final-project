package com.project.controller.kkb.admin;
import java.sql.Driver;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
@Configuration
@ImportResource("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DataSourceConfig {

    @Value("${spring.datasource.driverClassname}")
    private Class<? extends Driver> driverClass;

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Bean(name = "testDataSource")
    public SimpleDriverDataSource testDataSource() {
        SimpleDriverDataSource dataSource = new SimpleDriverDataSource();
        dataSource.setDriverClass(driverClass);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }
}