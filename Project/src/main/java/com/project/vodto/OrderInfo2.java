package com.project.vodto;

import java.sql.Timestamp;
import java.util.List;

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
public class OrderInfo2 {
	private List<String> product_id;
	private String non_order_no;
	private List<Integer> product_quantity;
	
}
