package com.project.vodto;

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
public class Rating {
	private String product_id;
	private float rating;
	private int participation_count;
	private int highest_rating;
	private int lowest_rating;
}