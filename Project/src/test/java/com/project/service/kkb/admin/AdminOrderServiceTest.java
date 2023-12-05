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
import com.project.vodto.kkb.PendingProductCancelRequest;

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
    public void testEditPendingOrderCancel() { // 전체
    	
    	//Given
        List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
        
        //When
        int result = adminOrderService.editPendingOrderCancel(orderNoList);
        
        //Then
        System.out.println("result : " + result);
       
    }
    
    @Test
    @Transactional
    public void testEditPreShipped() {
		
    	//Given
    	List<String> orderNoList = Arrays.asList("O1700034153645", "O1700034426708");
    	
    	//When
    	int result = adminOrderService.editPreShipped(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
    @Transactional
    public void testChangePendingOrderCancelReward() {
		
    	//Given
    	List<String> orderNoList = Arrays.asList("O1700034153645", "O1700034426708");
    	
    	//When
    	int result = adminOrderDao.changePendingOrderCancelReward(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
//    @Test
//    @Transactional
//    public void testConvert() {
//    	
//    	//Given
//    	PendingProductCancelRequest product1 = new PendingProductCancelRequest();
//    	product1.setProductOrderNo("O1700034153645-1");
//    	
//    	PendingProductCancelRequest product2 = new PendingProductCancelRequest();
//    	product2.setProductOrderNo("O1700034153645-2");
//    	
//    	PendingProductCancelRequest product3 = new PendingProductCancelRequest();
//    	product3.setProductOrderNo("O1700034153645-3");
//    	
//    	PendingProductCancelRequest product4 = new PendingProductCancelRequest();
//    	product4.setProductOrderNo("O1700034426708-1");
//    	
//    	PendingProductCancelRequest product5 = new PendingProductCancelRequest();
//    	product5.setProductOrderNo("O1700034426708-2");
//    	
//    	
//    	List<PendingProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//    	
//    	//When    	
//    	List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(PendingProductCancelRequest::getConvertedOrderNo))
//	            .entrySet().stream()
//	            .map(order -> order.getKey())
//	            .collect(Collectors.toList());
//    	//Then
//    	System.out.println("orderNoList: " + orderNoList.toString());
//    }
    
//    @Test
//    @Transactional
//    public void testChangePendingProductCancelHistory() {
//
//	    // Given
//    	PendingProductCancelRequest product1 = new PendingProductCancelRequest();
//    	product1.setProductOrderNo("O1701466461394-1");
//    	
//    	PendingProductCancelRequest product2 = new PendingProductCancelRequest();
//    	product2.setProductOrderNo("O1701466461394-2");
//    	
//    	PendingProductCancelRequest product3 = new PendingProductCancelRequest();
//    	product3.setProductOrderNo("O1701466461394-3");
//    	
//    	PendingProductCancelRequest product4 = new PendingProductCancelRequest();
//    	product4.setProductOrderNo("O1701338658628-1");
//    	
//    	PendingProductCancelRequest product5 = new PendingProductCancelRequest();
//    	product5.setProductOrderNo("O1701338658628-2");
//    	
//    	
//    	List<PendingProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//
//	    List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(PendingProductCancelRequest::getConvertedOrderNo))
//	            .entrySet().stream()
//	            .map(order -> order.getKey())
//	            .collect(Collectors.toList());
//
//	    // When
//	    int result = adminOrderDao.changePendingProductCancelHistory(orderNoList);
//
//	    // Then
//	    assertThat(result).isGreaterThan(0);
//
//    }
    
    @Test
	@Transactional
	public void testFindPendingProductCancelCoupon(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
		//when
    	List<CheckedCoupons> checkedCouponsList = adminOrderDao.findPendingProductCancelCoupon(orderNoList);
    	
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
	public void testChangePendingProductCancelCoupon(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
    	/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
		List<CheckedCoupons> couponList = adminOrderDao.findPendingProductCancelCoupon(orderNoList);
		
		//when
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		int result = adminOrderDao.changePendingProductCancelCoupon(couponList);
		
		//then
		System.out.println("result : " + result);
	}
    
    @Test
	@Transactional
	public void testChangePendingProductCancelReward(){
		//given
//    	("O1701466461394-1","O1701335516842-1");
    	List<PendingProductCancelRequest> productNoList = new ArrayList<PendingProductCancelRequest>();
    	PendingProductCancelRequest item1 = new PendingProductCancelRequest();
    	item1.setProductOrderNo("O1701466461394-1");
    	item1.setQuantity(1);
    	PendingProductCancelRequest item2 = new PendingProductCancelRequest();
    	item2.setProductOrderNo("O1701335516842-1");
    	item2.setQuantity(1);
    	productNoList.add(item1);
    	productNoList.add(item2);
		
		//when
    	int result = adminOrderDao.changePendingProductCancelReward(productNoList);
    	int result2 = adminOrderDao.changePendingProductCancelPoint(productNoList);
		
		//then
    	System.out.println("result : " + result);
    	System.out.println("result2 : " + result2);
//    	assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testChangePendingProductCancelPoint(){
		//given
    	List<PendingProductCancelRequest> productNoList = new ArrayList<PendingProductCancelRequest>();
    	PendingProductCancelRequest item1 = new PendingProductCancelRequest();
    	item1.setProductOrderNo("O1701466461394-1");
    	item1.setQuantity(1);
    	PendingProductCancelRequest item2 = new PendingProductCancelRequest();
    	item2.setProductOrderNo("O1701335516842-1");
    	item2.setQuantity(1);
    	productNoList.add(item1);
    	productNoList.add(item2);
		
		//when
    	int result = adminOrderDao.changePendingProductCancelPoint(productNoList);
		
		//then
    	System.out.println("result : " + result);
//    	assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testChangePendingProductCancelMember(){
		//given
		List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	
    	/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
		List<CheckedCoupons> couponList = adminOrderDao.findPendingProductCancelCoupon(orderNoList);
    	List<CanceledCoupons> canceledCoupons = CanceledCoupons.convert(couponList);
		
    	for(CanceledCoupons coupon : canceledCoupons) {
    		System.out.println(coupon.getOrderNo());
    		System.out.println(coupon.getCouponCount());
    	}
    	//when
    	
		int result = adminOrderDao.changePendingProductCancelMember(canceledCoupons);
		
		//then
		System.out.println("result : " + result);
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditPendingProductCancel(){
		//given
    	List<PendingProductCancelRequest> productOrderNoList = new ArrayList<PendingProductCancelRequest>();
    	PendingProductCancelRequest cancel1 = new PendingProductCancelRequest();
    	cancel1.setProductOrderNo("O1701466461394-1");
    	PendingProductCancelRequest cancel2 = new PendingProductCancelRequest();
    	cancel2.setProductOrderNo("O1701335516842-1");
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
		
		//when
		int result = adminOrderService.editPendingProductCancel(productOrderNoList);
		
		//then
		System.out.println("result : " + result);
		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditShipped(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394-1","O1701335516842-1");
		
		//when
    	int result = orderNoList.get(0).contains("-") 
				? adminOrderService.editShippedByProductNo(orderNoList)
				: adminOrderService.editShippedByNo(orderNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testEditInTransit(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394-1", "O1701335516842-1");
		
		//when
    	int result = orderNoList.get(0).contains("-") 
				? adminOrderService.editInTransitByProductNo(orderNoList)
				: adminOrderService.editInTransitByNo(orderNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testChangePendingProductCancelPayments(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701466461394-1", "O1701466461394-2");
		
		//when
    	int result = adminOrderDao.changePendingProductCancelPayments(orderNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
}
