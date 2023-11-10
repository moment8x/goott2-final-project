package com.project.dao.ksh.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderInfo;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;

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
		return count;
	}

	@Override
	public int insertNewOrderHistory(NonOrderHistory noh) throws Exception {

		return ses.insert(ns + ".insertNewOrderHistory", noh);
	}

	@Override
	public Payment getPaymentHistory(String orderNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderInfo> getProductInfo(List<String> product_id) {
		List<OrderInfo> productInfos = new ArrayList<OrderInfo>();

		if (product_id.size() > 1) {
			for (String s : product_id) {
				System.out.println(s.toString());
				productInfos.add(ses.selectOne(ns + ".getProductInfo", s));

			}
		} else {
			productInfos.add(ses.selectOne(ns + ".getProductInfo", product_id.get(0)));

		}
		return productInfos;
	}

	@Override
	public int saveBankTransfer(PaymentDTO pd) {
		// 무통장입금 테이블 저장
		return ses.insert(ns + ".saveBankTransfer", pd);
	}

//	@Override
//	public int insertNewOrder(NonOrderHistory noh) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}

}
