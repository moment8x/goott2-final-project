package com.project.service.kkb.admin;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
@Configuration
@ImportResource("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DataSourceConfig {

	  @Value("${spring.datasource.driverClassname}")
	    private String driverClassName;

	    @Value("${spring.datasource.url}")
	    private String url;

	    @Value("${spring.datasource.username}")
	    private String username;

	    @Value("${spring.datasource.password}")
	    private String password;

	    @Bean(name = "testDataSource")
	    public DriverManagerDataSource testDataSource() {
	        DriverManagerDataSource dataSource = new DriverManagerDataSource();
	        dataSource.setDriverClassName(driverClassName);
	        dataSource.setUrl(url);
	        dataSource.setUsername(username);
	        dataSource.setPassword(password);
	        return dataSource;
	    }
}