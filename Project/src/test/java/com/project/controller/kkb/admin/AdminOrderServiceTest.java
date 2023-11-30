package com.project.controller.kkb.admin;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.service.kkb.admin.AdminOrderService;
import com.project.service.kkb.admin.OrderProduct;
import com.project.vodto.kkb.DepositProductCancelRequest;
import com.project.vodto.kkb.OrderProductResponse;

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

    private JdbcTemplate jdbcTemplate;

    @Before
    public void setup() {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Test
    @Transactional
    public void testEditDepositOrderCancel() {
    	
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
    public void testEditDepositConfirm() {
		
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
    public void testChangeDepositOrderCancelReward() {
		
    	//Given
    	List<String> orderNoList = Arrays.asList("O1700034153645", "O1700034426708");
    	
    	//When
    	int result = adminOrderRepository.changeDepositOrderCancelReward(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
    @Transactional
    public void testConvert() {
    	
    	//Given
    	DepositProductCancelRequest product1 = new DepositProductCancelRequest();
    	product1.setProductOrderNo("O1700034153645-1");
    	
    	DepositProductCancelRequest product2 = new DepositProductCancelRequest();
    	product2.setProductOrderNo("O1700034153645-2");
    	
    	DepositProductCancelRequest product3 = new DepositProductCancelRequest();
    	product3.setProductOrderNo("O1700034153645-3");
    	
    	DepositProductCancelRequest product4 = new DepositProductCancelRequest();
    	product4.setProductOrderNo("O1700034426708-1");
    	
    	DepositProductCancelRequest product5 = new DepositProductCancelRequest();
    	product5.setProductOrderNo("O1700034426708-2");
    	
    	
    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
    	productOrderNoList.add(product1);
    	productOrderNoList.add(product2);
    	productOrderNoList.add(product3);
    	productOrderNoList.add(product4);
    	productOrderNoList.add(product5);
    	
    	//When    	
    	List<String> orderNoList = productOrderNoList
    			.stream()
    			.collect(Collectors.groupingBy(DepositProductCancelRequest::getConvertedOrderNo))
	            .entrySet().stream()
	            .map(order -> order.getKey())
	            .collect(Collectors.toList());
    	//Then
    	System.out.println("orderNoList: " + orderNoList.toString());
    }
    
    @Test
    @Transactional
    public void testChangeDepositProductCancelHistory() {

	    // Given
    	DepositProductCancelRequest product1 = new DepositProductCancelRequest();
    	product1.setProductOrderNo("O1700034153645-1");
    	
    	DepositProductCancelRequest product2 = new DepositProductCancelRequest();
    	product2.setProductOrderNo("O1700034153645-2");
    	
    	DepositProductCancelRequest product3 = new DepositProductCancelRequest();
    	product3.setProductOrderNo("O1700034153645-3");
    	
    	DepositProductCancelRequest product4 = new DepositProductCancelRequest();
    	product4.setProductOrderNo("O1700034426708-1");
    	
    	DepositProductCancelRequest product5 = new DepositProductCancelRequest();
    	product5.setProductOrderNo("O1700034426708-2");
    	
    	
    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
    	productOrderNoList.add(product1);
    	productOrderNoList.add(product2);
    	productOrderNoList.add(product3);
    	productOrderNoList.add(product4);
    	productOrderNoList.add(product5);

	    List<String> orderNoList = productOrderNoList
    			.stream()
    			.collect(Collectors.groupingBy(DepositProductCancelRequest::getConvertedOrderNo))
	            .entrySet().stream()
	            .map(order -> order.getKey())
	            .collect(Collectors.toList());

	    // When
	    int result = adminOrderRepository.changeDepositProductCancelHistory(orderNoList);

	    // Then
	    assertThat(result).isGreaterThan(0);

    }
    
}
