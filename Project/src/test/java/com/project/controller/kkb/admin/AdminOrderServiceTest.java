package com.project.controller.kkb.admin;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.project.vodto.kkb.DepositProductCancelRequest;


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
    	DepositProductCancelRequest list1 = new DepositProductCancelRequest();
    	list1.setProductOrderNoList(Arrays.asList("O1700034153645-1", "O1700034153645-2", "O1700034153645-3"));
    	
    	DepositProductCancelRequest list2 = new DepositProductCancelRequest();
    	list2.setProductOrderNoList(Arrays.asList("O1700034426708-1", "O1700034426708-2"));
    	
    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
    	productOrderNoList.add(list1);
    	productOrderNoList.add(list2);
    	
    	//When
    	List<String> orderNoList = productOrderNoList
				.stream()
				.map(DepositProductCancelRequest::getOrderNo)	
				.collect(Collectors.toList());
    	//Then
    	System.out.println(orderNoList.toString());
    }
    
    @Test
    @Transactional
    public List<Map<String, Object>> testChangeDepositProductCancelHistory() {
    	
    	//Given
    	DepositProductCancelRequest list1 = new DepositProductCancelRequest();
    	list1.setProductOrderNoList(Arrays.asList("O1700812765494-1", "O1700812765494-2", "O1700812765494-3"));
    	
    	DepositProductCancelRequest list2 = new DepositProductCancelRequest();
    	list2.setProductOrderNoList(Arrays.asList("O1700034426708-1", "O1700034426708-2"));
    	
    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
    	productOrderNoList.add(list1);
    	productOrderNoList.add(list2);
    	
    	List<DepositProductCancelRequest> convertedNoList = 
				productOrderNoList.stream()
					.map(info -> {
							info.setConvertedOrderNo();
							return info;
						})
					.collect(Collectors.toList());
    	
    	//When
    	int result = adminOrderRepository.changeDepositProductCancelHistory(convertedNoList);
    	
    	//Then
    	assertThat(result).isGreaterThan(0);
    	
    	String sql = "SELECT delivery_status"
    			+ " FROM order_history"
    			+ " WHERE order_no = 'O1700812765494'";
    	
    	return jdbcTemplate.queryForList(sql);
    	
    }
    
}
