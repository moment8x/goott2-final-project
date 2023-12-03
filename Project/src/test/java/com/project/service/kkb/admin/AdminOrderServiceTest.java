package com.project.service.kkb.admin;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.CouponCount;
import com.project.vodto.kkb.DepositProductCancelRequest;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = DataSourceConfig.class)
public class AdminOrderServiceTest {
	
	@Autowired
    private AdminOrderService adminOrderService;
	
	@Autowired
	private AdminOrderDAO adminOrderDao;

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
        List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
        
        //When
        int result = adminOrderService.editDepositOrderCancel(orderNoList);
        
        //Then
        System.out.println("result : " + result);
       
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
    	int result = adminOrderDao.changeDepositOrderCancelReward(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
//    @Test
//    @Transactional
//    public void testConvert() {
//    	
//    	//Given
//    	DepositProductCancelRequest product1 = new DepositProductCancelRequest();
//    	product1.setProductOrderNo("O1700034153645-1");
//    	
//    	DepositProductCancelRequest product2 = new DepositProductCancelRequest();
//    	product2.setProductOrderNo("O1700034153645-2");
//    	
//    	DepositProductCancelRequest product3 = new DepositProductCancelRequest();
//    	product3.setProductOrderNo("O1700034153645-3");
//    	
//    	DepositProductCancelRequest product4 = new DepositProductCancelRequest();
//    	product4.setProductOrderNo("O1700034426708-1");
//    	
//    	DepositProductCancelRequest product5 = new DepositProductCancelRequest();
//    	product5.setProductOrderNo("O1700034426708-2");
//    	
//    	
//    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//    	
//    	//When    	
//    	List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(DepositProductCancelRequest::getConvertedOrderNo))
//	            .entrySet().stream()
//	            .map(order -> order.getKey())
//	            .collect(Collectors.toList());
//    	//Then
//    	System.out.println("orderNoList: " + orderNoList.toString());
//    }
    
//    @Test
//    @Transactional
//    public void testChangeDepositProductCancelHistory() {
//
//	    // Given
//    	DepositProductCancelRequest product1 = new DepositProductCancelRequest();
//    	product1.setProductOrderNo("O1701466461394-1");
//    	
//    	DepositProductCancelRequest product2 = new DepositProductCancelRequest();
//    	product2.setProductOrderNo("O1701466461394-2");
//    	
//    	DepositProductCancelRequest product3 = new DepositProductCancelRequest();
//    	product3.setProductOrderNo("O1701466461394-3");
//    	
//    	DepositProductCancelRequest product4 = new DepositProductCancelRequest();
//    	product4.setProductOrderNo("O1701338658628-1");
//    	
//    	DepositProductCancelRequest product5 = new DepositProductCancelRequest();
//    	product5.setProductOrderNo("O1701338658628-2");
//    	
//    	
//    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//
//	    List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(DepositProductCancelRequest::getConvertedOrderNo))
//	            .entrySet().stream()
//	            .map(order -> order.getKey())
//	            .collect(Collectors.toList());
//
//	    // When
//	    int result = adminOrderDao.changeDepositProductCancelHistory(orderNoList);
//
//	    // Then
//	    assertThat(result).isGreaterThan(0);
//
//    }
    
    @Test
	@Transactional
	public void testFindDepositProductCancelCoupon(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
		//when
    	List<CheckedCoupons> checkedCouponsList = adminOrderDao.findDepositProductCancelCoupon(orderNoList);
    	
		//then
    	System.out.println("CheckedCoupons:");
    	
    	for (CheckedCoupons checkedCoupons : checkedCouponsList) {
    	    System.out.println("OrderNo: " + checkedCoupons.getOrderNo());

    	    List<CouponCount> coupons = checkedCoupons.getCoupons();

    	    for (CouponCount coupon : coupons) {
    	        System.out.println("CouponNumber: " + coupon.getCouponNumber() + ", Count: " + coupon.getCount());
    	    }

    	    System.out.println();
    	}
	}
    
    @Test
	@Transactional
	public void testChangeDepositProductCancelCoupon(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
    	/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
		List<CheckedCoupons> couponList = adminOrderDao.findDepositProductCancelCoupon(orderNoList);
		
		//when
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		int result = adminOrderDao.changeDepositProductCancelCoupon(couponList);
		
		//then
		System.out.println("result : " + result);
	}
    
    @Test
	@Transactional
	public void testChangeDepositProductCancelReward(){
		//given
    	List<String> productNoList = Arrays.asList("O1701466461394-1","O1701335516842-1");
		
		//when
    	int result = adminOrderDao.changeDepositProductCancelReward(productNoList);
		
		//then
    	System.out.println("result : " + result);
//    	assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testChangeDepositProductCancelPoint(){
		//given
    	List<String> productNoList = Arrays.asList("O1701466461394-1","O1701335516842-1");
		
		//when
    	int result = adminOrderDao.changeDepositProductCancelPoint(productNoList);
		
		//then
    	System.out.println("result : " + result);
//    	assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testChangeDepositProductCancelMember(){
		//given
		List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
    	/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
		List<CheckedCoupons> couponList = adminOrderDao.findDepositProductCancelCoupon(orderNoList);
    	List<CanceledCoupons> canceledCoupons = CanceledCoupons.convert(couponList);
		
    	for(CanceledCoupons coupon : canceledCoupons) {
    		System.out.println(coupon.getOrderNo());
    		System.out.println(coupon.getCouponCount());
    	}
    	//when
    	
		int result = adminOrderDao.changeDepositProductCancelMember(canceledCoupons);
		
		//then
		System.out.println("result : " + result);
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditDepositProductCancel(){
		//given
    	List<DepositProductCancelRequest> productOrderNoList = new ArrayList<DepositProductCancelRequest>();
    	DepositProductCancelRequest cancel1 = new DepositProductCancelRequest();
    	cancel1.setProductOrderNo("O1701466461394-1");
    	DepositProductCancelRequest cancel2 = new DepositProductCancelRequest();
    	cancel2.setProductOrderNo("O1701335516842-1");
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
		
		//when
		int result = adminOrderService.editDepositProductCancel(productOrderNoList);
		
		//then
		System.out.println("result : " + result);
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditCompleteShipment(){
		//given
    	List<String> productNoList = Arrays.asList("O1701466461394-1","O1701335516842-1");
		
		//when
    	int result = adminOrderDao.changeCompleteShipment(productNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditShipped(){
		//given
    	List<String> productNoList = Arrays.asList("O1701466461394-1", "O1701335516842-1");
		
		//when
    	int result = adminOrderDao.changeShipped(productNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
}
