package com.project.controller.kkb.admin;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.service.kkb.admin.AdminOrderService;


@RunWith(SpringRunner.class)
@ContextConfiguration(classes = DataSourceConfig.class)
public class AdminOrderServiceTest {
	
	@Autowired
    private AdminOrderService adminOrderService;
	@Autowired
	private AdminOrderDAO adminOrderRepository;

    @Autowired
    @Qualifier("testDataSource")
    private DriverManagerDataSource dataSource; 

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Before
    public void setup() {
        jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Test
    @Transactional
    public void testEditDepositOrderCancel() throws Exception {
    	
    	//Given
        List<String> orderNoList = Arrays.asList("O1700812765494", "O1700794968572");
        
        //When
        int result = adminOrderService.editDepositOrderCancel(orderNoList);
        
        //Then
        System.out.println("result : " + result);

        assertThat(result).isGreaterThan(0);
       
    }
    
    @Test
    @Transactional
    public void testEditDepositConfirm() throws Exception {
		
    	//Given
    	List<String> orderNoList = Arrays.asList("O1700034153645", "O1700034426708");
    	
    	//When
    	int result = adminOrderService.editDepositConfirm(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
    @Transactional
    public void testChangeDepositOrderCancelReward() throws Exception {
		
      //Given
    	List<String> orderNoList = Arrays.asList("O1700034153645", "O1700034426708");
    	
    	//When
    	int result = adminOrderRepository.changeDepositOrderCancelReward(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
}
