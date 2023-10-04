package com.project.vodto;

import java.sql.Timestamp;

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
public class Product {
	private String product_id;
	private String product_name;
	private int consumer_price;
	private int supply_price;
	private int selling_price;
	private String isbn;
	private String product_image;
	private String product_info_image;
	private String author_translator;
	private String original_author;
	private String illustrator;
	private String publisher;
	private Timestamp publication_date;
	private int page_coutn;
	private String size;
	private int total_volume;
	private String author_introduction;
	private String introduction_intro;
	private String introduction_detail;
	private String table_of_contents;
	private int notification_subscription;
	private int best_seller_status;
	private String category_key;
}