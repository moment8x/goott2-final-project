package com.project.dao.ksh.order;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.CompleteOrder;
import com.project.vodto.ksh.CompleteOrderItem;
import com.project.vodto.ksh.OrderInfo;
import com.project.vodto.ksh.PaymentDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Inject
	private SqlSession ses; // db랑 연결해줌

	private static String ns = "com.ksh.mappers.OrderMapper";

	@Override
	public int insertNewPayment(PaymentDTO pd) throws Exception {

		return ses.insert(ns + ".insertNewPayment", pd);
	}

	@Override
	public int saveDetailItems(List<DetailOrderItem> itemList) {
		// 테이블 바껴서 수정필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		int count = 0;
		Map<String, Object> map = new HashMap<>();
		map.put("list", itemList);

		// 실행 결과 row 갯수를 리턴합니다.
		count += ses.insert(ns + ".insertDetailOrderItem", map);
		System.out.println(count + "개 insert 완료");
		return count;
	}

	@Override
	public int insertNewNonOrderHistory(NonOrderHistory noh) throws Exception {

		return ses.insert(ns + ".insertNewNonOrderHistory", noh);
	}

	@Override
	public int insertNewOrderHistory(OrderHistory oh) {
		return ses.insert(ns + ".insertNewOrderHistory", oh);
	}

	@Override
	public CompleteOrder getPaymentHistory(String orderNo) {
		return ses.selectOne(ns + ".getPaymentDetail", orderNo);
	}

	@Override
	public List<OrderInfo> getProductInfo(List<String> productId) {
		List<OrderInfo> productInfos = new ArrayList<OrderInfo>();

		if (productId.size() > 1) {
			for (String s : productId) {
				System.out.println(s.toString());
				productInfos.add(ses.selectOne(ns + ".getProductInfo", s));

			}
		} else {
			productInfos.add(ses.selectOne(ns + ".getProductInfo", productId.get(0)));

		}
		return productInfos;
	}

	@Override
	public int saveBankTransfer(PaymentDTO pd) {
		// 무통장입금 테이블 저장
		return ses.insert(ns + ".saveBankTransfer", pd);
	}

	@Override
	public List<ShippingAddress> getShippingAddr(String memberId) throws Exception {

		return ses.selectList(ns + ".getShippingAddr", memberId);
	}

	@Override
	public List<CouponInfos> getCouponInfos(String memberId) throws Exception {

		return ses.selectList(ns + ".getCouponInfos", memberId);
	}

	@Override
	public List<CouponInfos> addCategoryKey(List<CouponInfos> couponInfos) throws Exception {
		for (CouponInfos c : couponInfos) {
			c.setCategoryKey(ses.selectList(ns + ".getCategoryKey", c.getCouponNumber()));
		}

		return couponInfos;
	}

	@Override
	public List<CompleteOrderItem> getDetailOrderItem(String orderNo, List<String> productId) throws Exception {
		List<CompleteOrderItem> orderItems = new ArrayList<CompleteOrderItem>();
		Map<String, Object> map = new HashMap<>();
		map.put("orderNo", orderNo);
		for(String s : productId) {
			map.put("productId", s);
			orderItems.add(ses.selectOne(ns+".getDetailOrderItem", map));
		}

		System.out.println("=========================상희================================");
		System.out.println(orderItems.toString());
		
		

		return orderItems;
	}

	@Override
	public int updateCouponLogs(PaymentDTO pd) throws Exception {
		Timestamp date = new Timestamp(System.currentTimeMillis());
		int count = 0;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", pd.getMemberId());
		params.put("relatedOrder", pd.getOrderNo());

		params.put("usedDate", date);

		for (String coupon : pd.getCouponNumbers()) {
			params.put("coupon", coupon);
			count += ses.update(ns + ".updateCouponLogs", params);
		}
		return count;
	}

	@Override
	public int updatePointLogs(PaymentDTO pd) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		pd.setPointReason("구매");
		params.put("memberId", pd.getMemberId());
		params.put("pointReason", pd.getPointReason());
		params.put("point", pd.getUsedPoints() * -1);
		params.put("relatedOrder", pd.getOrderNo());
		

		return ses.insert(ns + ".updatePointLogs", params);
	}

	@Override
	public int updateRewardLogs(PaymentDTO pd) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		pd.setRewardReason("구매");
		System.out.println(pd.toString());
		params.put("memberId", pd.getMemberId());
		params.put("rewardReason", pd.getRewardReason());
		params.put("reward", pd.getUsedReward() * -1);
		params.put("relatedOrder", pd.getOrderNo());

		return ses.insert(ns + ".updateRewardLogs", params);
	}

	@Override
	public int updateProducts(List<DetailOrderItem> itemList) throws Exception {
		int count = 0;

		System.out.println(itemList.toString());
		Map<String, Object> map = new HashMap<>();
		map.put("list", itemList);

		// 실행 결과 row 갯수를 리턴합니다.
		count += ses.update(ns + ".updateDetailOrderItem", map);
		System.out.println(count + "개 재고 업데이트 완료");
		return count;
	}

	@Override
	public int updateMemberCoupon(PaymentDTO pd) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", pd.getMemberId());
		params.put("usedCouponCount", pd.getCouponNumbers().size());

		return ses.update(ns + ".updateMemberCoupon", params);
	}

	@Override
	public int updateMemberPoints(PaymentDTO pd) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", pd.getMemberId());
		params.put("usedPoints", pd.getUsedPoints());

		return ses.update(ns + ".updateMemberPoints", params);
	}

	@Override
	public int updateMemberRewards(PaymentDTO pd) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", pd.getMemberId());
		params.put("usedRewards", pd.getUsedReward());

		return ses.update(ns + ".updateMemberRewards", params);
	}

	@Override
	public Memberkjy getMemberInfo(String memberId) throws Exception {

		return ses.selectOne(ns + ".getMemberInfo", memberId);
	}

	@Override
	public int updateMemberAcumPayment(int actualPaymentAmount, String memberId) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("actualPaymentAmount", actualPaymentAmount);
		return ses.update(ns+(".updateMeberAcumPayment"), params);
	}

	@Override
	public int getRealAmount(List<String> productId) throws Exception {
		
		return 0;
	}

//	@Override
//	public int insertNewOrder(NonOrderHistory noh) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}

}
