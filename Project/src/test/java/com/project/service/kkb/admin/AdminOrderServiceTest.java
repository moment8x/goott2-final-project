package com.project.service.kkb.admin;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
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
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.CouponCount;
import com.project.vodto.kkb.OrderStatus;
import com.project.vodto.kkb.PendingCancelInfoResponse;
import com.project.vodto.kkb.ProductCancelRequest;
import com.project.vodto.kkb.RefundNoInfo;
import com.project.vodto.kkb.RefundProductInfo;

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
    public void testEditProductCancel() { // 전체
    	
    	//Given
//    	List<String> orderNoList = Arrays.asList("O1701466461394","O1701335516842");
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest cancel1 = ProductCancelRequest.of("O1701747480059-1");
    	cancel1.setQuantity(4);
    	ProductCancelRequest cancel2 = ProductCancelRequest.of("O1701747480059-2");
    	cancel2.setQuantity(2);
    	ProductCancelRequest cancel3 = ProductCancelRequest.of("O1701662611938-1");
    	cancel3.setQuantity(1);
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
    	productOrderNoList.add(cancel3);
    	
    	
    	//When
    	int result = adminOrderService.editProductCancel(productOrderNoList);
    	
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
    	int result = adminOrderDao.savePendingOrderCancelReward(orderNoList);
		
    	//Then
		System.out.println("result : " + result);
		
		assertThat(result).isGreaterThan(0);
	}
    
//    @Test
//    @Transactional
//    public void testConvert() {
//    	
//    	//Given
//    	ProductCancelRequest product1 = new ProductCancelRequest();
//    	product1.setProductOrderNo("O1700034153645-1");
//    	
//    	ProductCancelRequest product2 = new ProductCancelRequest();
//    	product2.setProductOrderNo("O1700034153645-2");
//    	
//    	ProductCancelRequest product3 = new ProductCancelRequest();
//    	product3.setProductOrderNo("O1700034153645-3");
//    	
//    	ProductCancelRequest product4 = new ProductCancelRequest();
//    	product4.setProductOrderNo("O1700034426708-1");
//    	
//    	ProductCancelRequest product5 = new ProductCancelRequest();
//    	product5.setProductOrderNo("O1700034426708-2");
//    	
//    	
//    	List<ProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//    	
//    	//When    	
//    	List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(ProductCancelRequest::getConvertedOrderNo))
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
//    	ProductCancelRequest product1 = new ProductCancelRequest();
//    	product1.setProductOrderNo("O1701466461394-1");
//    	
//    	ProductCancelRequest product2 = new ProductCancelRequest();
//    	product2.setProductOrderNo("O1701466461394-2");
//    	
//    	ProductCancelRequest product3 = new ProductCancelRequest();
//    	product3.setProductOrderNo("O1701466461394-3");
//    	
//    	ProductCancelRequest product4 = new ProductCancelRequest();
//    	product4.setProductOrderNo("O1701338658628-1");
//    	
//    	ProductCancelRequest product5 = new ProductCancelRequest();
//    	product5.setProductOrderNo("O1701338658628-2");
//    	
//    	
//    	List<ProductCancelRequest> productOrderNoList = new ArrayList<>();
//    	productOrderNoList.add(product1);
//    	productOrderNoList.add(product2);
//    	productOrderNoList.add(product3);
//    	productOrderNoList.add(product4);
//    	productOrderNoList.add(product5);
//
//	    List<String> orderNoList = productOrderNoList
//    			.stream()
//    			.collect(Collectors.groupingBy(ProductCancelRequest::getConvertedOrderNo))
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
    	List<ProductCancelRequest> productNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest item1 = new ProductCancelRequest();
    	item1.setProductOrderNo("O1700034153645-1");
    	item1.setQuantity(1);
    	ProductCancelRequest item2 = new ProductCancelRequest();
    	item2.setProductOrderNo("O1700557261699-1");
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
    	List<ProductCancelRequest> productNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest item1 = new ProductCancelRequest();
    	item1.setProductOrderNo("O1701466461394-1");
    	item1.setQuantity(1);
    	ProductCancelRequest item2 = new ProductCancelRequest();
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
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest cancel1 = new ProductCancelRequest();
    	cancel1.setProductOrderNo("O1701338658628-3");
    	cancel1.setQuantity(2);
    	ProductCancelRequest cancel2 = new ProductCancelRequest();
    	cancel2.setProductOrderNo("O1701335073062-1");
    	cancel2.setQuantity(3);
    	
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

    	//    	List<String> orderNoList = Arrays.asList("O1701466461394-1", "O1701466461394-2");
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	
    	ProductCancelRequest cancel1 = new ProductCancelRequest();
    	ProductCancelRequest cancel2 = new ProductCancelRequest();
    	cancel1.setProductOrderNo("O1701466461394-1");
    	cancel2.setProductOrderNo("O1701466461394-2");
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
    	
		//when
    	int result = adminOrderDao.changePendingProductCancelPayments(productOrderNoList);
		
		//then
    	System.out.println("result : " + result);
//		assertThat(result).isGreaterThan(0);
	}
    
    @Test
	@Transactional
	public void testFindOrdersStatusByOrderNo(){
		//given
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest cancel1 = new ProductCancelRequest();
    	ProductCancelRequest cancel2 = new ProductCancelRequest();
    	ProductCancelRequest cancel3 = new ProductCancelRequest();
    	ProductCancelRequest cancel4 = new ProductCancelRequest();
    	
//    	cancel1.setOrderNo("O1701747480059");
//    	cancel2.setOrderNo("O1701747179730");
//    	cancel3.setOrderNo("O1701746759210");
//    	cancel4.setOrderNo("O1701746500489");
    	
    	cancel1.setProductOrderNo("O1701747480059-1");
    	cancel2.setProductOrderNo("O1701747179730-1");
    	cancel3.setProductOrderNo("O1701746759210-1");
    	cancel4.setProductOrderNo("O1701746500489-1");
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
    	productOrderNoList.add(cancel3);
    	productOrderNoList.add(cancel4);
		
		//when
    	List<OrderStatus> orderStatusList = adminOrderDao.findOrdersStatus(productOrderNoList);
    	
    	/* OrderNO 안에 다른 상태인 상품이 들어있으면 제외 */
    	List<String> exclusionOrderNo = Optional.ofNullable(orderStatusList.stream()
    			.filter(e -> !e.getProductStatus().equals("입금전"))
    			.map(OrderStatus::getOrderNo)
    			.collect(Collectors.toList()))
    			.orElseGet(Collections::emptyList);
		
    	/* 입금 전 상태인 OrderNo */
    	List<String> pendingOrderNo = orderStatusList.stream()
    			.filter(e -> exclusionOrderNo.stream()
    					.noneMatch(Predicate.isEqual(e.getOrderNo())))
    					.filter(e -> e.getProductStatus().equals("입금전") && e.getProductOrderNo() == null)
    					.map(OrderStatus::getOrderNo)
	    				.distinct()
	    				.collect(Collectors.toList());
    	
    	/*----------------------------------------------------------------------------------------*/
    	
		/* OrderNO 안에 다른 상태인 상품이 들어있으면 제외 */
    	List<String> exclusionPreShippedOrderNo = Optional.ofNullable(orderStatusList.stream()
    			.filter(e -> !e.getProductStatus().equals("결제완료"))
    			.map(OrderStatus::getOrderNo)
    			.collect(Collectors.toList()))
    			.orElseGet(Collections::emptyList);
		
    	/* 결제완료 상태인 OrderNo */
    	List<String> preShippedOrderNo = orderStatusList.stream()
    			.filter(e -> exclusionPreShippedOrderNo.stream()
    					.noneMatch(Predicate.isEqual(e.getOrderNo())))
    					.filter(e -> e.getProductStatus().equals("결제완료") && e.getProductOrderNo() == null)
    					.map(OrderStatus::getOrderNo)
	    				.distinct()
	    				.collect(Collectors.toList());
    			
    	//then		
    	pendingOrderNo.forEach(no -> System.out.println("입금전 orderNo : " + no));
    	preShippedOrderNo.forEach(no -> System.out.println("결제 완료 orderNo : " + no));
    
	}
    
    @Test
	@Transactional
	public void testFindOrdersStatusByProductOrderNo(){
		//given
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest cancel1 = ProductCancelRequest.of("O1701466461394-1");
    	ProductCancelRequest cancel2 = ProductCancelRequest.of("O1701335516842-1");
    	ProductCancelRequest cancel3 = ProductCancelRequest.of("O1701662611938-1");
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
    	productOrderNoList.add(cancel3);
		
		//when
    	List<OrderStatus> orderStatusList = adminOrderDao.findOrdersStatus(productOrderNoList);
    
    	/* 입금전 상태인 ProductNo */
    	List<ProductCancelRequest> pendingProductNo = orderStatusList.stream()
				.filter(e -> e.getProductStatus().equals("입금전") && e.getOrderNo() == null)
				.map(OrderStatus::getProductOrderNo)
				.map(ProductCancelRequest::of)
				.collect(Collectors.toList());
    	
    	/* 결제완료 상태인 ProductNo */
    	List<String> preShippedProductNo = orderStatusList.stream()
				.filter(e -> e.getProductStatus().equals("결제완료") && e.getOrderNo() == null)
				.map(OrderStatus::getProductOrderNo)
				.collect(Collectors.toList());
		
    			
    	//then		
    	pendingProductNo.forEach(no -> System.out.println("입금전 ProductNo : " + no.getProductOrderNo()));
//    	preShippedProductNo.forEach(no -> System.out.println("결제 완료 ProductNo : " + no));
    	
//    	assertThat(preShippedProductNo.isEmpty()).isTrue();
	}
    
    @Test
	@Transactional
	public void testSavePendingOrderCancel(){
		//given
    	
    	PendingCancelInfoResponse cancelInfo = new PendingCancelInfoResponse();
    	cancelInfo.setDetailedOrderId("361");
    	cancelInfo.setProductId("S000210736183");
    	cancelInfo.setProductOrderNo("O1701466461394-1");
    	
    	PendingCancelInfoResponse cancelInfo2 = new PendingCancelInfoResponse();
    	cancelInfo2.setDetailedOrderId("361");
    	cancelInfo2.setProductId("S000210736183");
    	cancelInfo2.setProductOrderNo("O1701466461394-1");
    	
		
    	List<PendingCancelInfoResponse> cancelInfoList = new ArrayList<PendingCancelInfoResponse>();
    	cancelInfoList.add(cancelInfo);
    	cancelInfoList.add(cancelInfo2);
    	
		//when
    	int result = adminOrderDao.savePendingOrderCancel(cancelInfoList);
		
		//then
    	System.out.println("result : " + result);
	}
    
    @Test
	@Transactional
	public void testSaveOrderCancelRefund(){
		//given
    	List<String> orderNoList = Arrays.asList("O1701747480059");
    	List<PendingCancelInfoResponse> cancelInfoList = adminOrderDao.findCancelInfo(orderNoList);
    	
    	List<RefundNoInfo> refundInfoList = adminOrderDao.findOrderRefundInfo(orderNoList);
		
    	int result = -1;
    	
    	//when
//    	if(adminOrderDao.saveOrderCancel(cancelInfoList) > 0) {
//    		cancelInfoList.forEach(item ->System.out.println("CancelId : " + item.getCancelId()));
//    	};
    	
    	
    	if(adminOrderDao.saveOrderCancel(cancelInfoList) > 0) {
//    		cancelInfoList.forEach(e-> System.out.println("cancelInfoList : cancelID : " +e.getCancelId() + ", Pno : "
//    				+ e.getProductOrderNo()));
//    		refundInfoList.forEach(e-> System.out.println("cancelInfoList : cancelID : " +e.getCancelId() + ", Pno : "
//    				+ e.getProductOrderNo()));
    		
    		refundInfoList.forEach(info -> {
				cancelInfoList.stream()
	                .filter(cancelInfo -> info.getProductOrderNo().equals(cancelInfo.getProductOrderNo()))
	                .findFirst()
	                .ifPresent(cancelInfo -> info.setCancelId(cancelInfo.getCancelId()));
	        });	
    		refundInfoList.forEach(e-> System.out.println("refundInfoList : " +e.getCancelId()));
			
			/* 환불 테이블 insert */
			result = adminOrderDao.saveOrderCancelRefund(refundInfoList);
		}
		
		//then
    	System.out.println("result : " + result);
	}

    
    @Test
	@Transactional
	public void testSaveProductCancelRefund(){
		//given
    	List<ProductCancelRequest> productOrderNoList = new ArrayList<ProductCancelRequest>();
    	ProductCancelRequest cancel1 = ProductCancelRequest.of("O1701747480059-1");
    	ProductCancelRequest cancel2 = ProductCancelRequest.of("O1701747480059-2");
    	ProductCancelRequest cancel3 = ProductCancelRequest.of("O1701662611938-1");
    	
    	productOrderNoList.add(cancel1);
    	productOrderNoList.add(cancel2);
    	productOrderNoList.add(cancel3);
    	
    	int result = -1;
    	
    	/* 환불용 정보 select */
		List<RefundProductInfo> refundInfoList = adminOrderDao.findProductRefundInfo(productOrderNoList);
		
		List<String> productNoList = productOrderNoList.stream()
				.map(ProductCancelRequest::getProductOrderNo)	
				.collect(Collectors.toList());
		
		
		//when
		
		List<PendingCancelInfoResponse> cancelInfoList = adminOrderDao.findProductCancelInfo(productNoList);
		/* 취소 테이블 insert */
	    if(adminOrderDao.saveProductCancel(cancelInfoList) > 0) {
	    	refundInfoList.forEach(info -> {
				cancelInfoList.stream()
	                .filter(request -> info.getProductOrderNo().equals(request.getProductOrderNo()))
	                .findFirst()
	                .ifPresent(request -> info.setCancelId(request.getCancelId()));
	        });		    	
	    	refundInfoList.forEach(e-> System.out.println("refundInfoList : " +e.getCancelId()));
	    	/* 환불 테이블 insert */
			result = adminOrderDao.saveProductCancelRefund(refundInfoList);
		}
	    
		//then
	    System.out.println("result : " + result);
	}
    
}
