package com.project.etc.ksh;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

@Configuration
@PropertySource("classpath:application.properties")
public class SendMessageConfig {

    @Bean
     public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
           return new PropertySourcesPlaceholderConfigurer();
     }
 
}
