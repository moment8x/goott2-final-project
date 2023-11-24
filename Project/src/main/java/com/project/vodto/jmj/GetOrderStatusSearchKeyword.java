package com.project.vodto.jmj;

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
public class GetOrderStatusSearchKeyword {
	private String beforeDeposit; //입금전
	private String beforeShipping; //출고전
	private String shipping; //배송중
	private String deliveryCompleted; //배송완료
	private String cancelList; //취소
	private String exchangeList; //교환
	private String returnList; //반품
	private String exchangeApply; //교환신청
	private String returnApply; //반품신청
	
	private String sevenDaysAgo; //일주일
	private String fifteenDaysAgo; //15일
	private String aMonthAgo; //한달
}
