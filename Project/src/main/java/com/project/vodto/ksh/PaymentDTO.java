package com.project.vodto.ksh;

import java.sql.Timestamp;
import java.util.List;

import com.project.vodto.DetailOrderItem;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PaymentDTO {
	private String paymentNumber;
	private String orderNo;
	private String nonOrderNo;
	private String paymentMethod;
	private int totalAmount;
	private int shippingFee;
	private int usedReward;
	private int usedPoints;
	private int actualPaymentAmount;
	private Timestamp paymentTime;
	private int amountToPay;
//	private List<String> product_id;
//	private List<Integer> product_price;// quantity
	private List<DetailOrderItem> products;
	private String cardName;
	private String cardNumber;
	private String recipientName;
	private List<String> couponNumbers;
	private String paymentStatus;
	private String memberId;
	private String pointReason;
	private String rewardReason;
	private String impUid;
	private String phoneNumber;
	
	
}
