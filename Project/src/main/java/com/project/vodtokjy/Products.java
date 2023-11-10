package com.project.vodtokjy;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


public class Products {
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
	private int page_count;
	private String size;
	private int total_volume;
	private String author_introduction;
	private String introduction_intro;
	private String introduction_detail;
	private String table_of_contents;
	private int notification_subscription;
	private int best_seller_status;
	private String category_key;

	
	
	public Products(String product_id, String product_name, int consumer_price, int supply_price, int selling_price,
			String isbn, String product_image, String product_info_image, String author_translator,
			String original_author, String illustrator, String publisher, Timestamp publication_date, int page_count,
			String size, int total_volume, String author_introduction, String introduction_intro,
			String introduction_detail, String table_of_contents, int notification_subscription, int best_seller_status,
			String category_key) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.consumer_price = consumer_price;
		this.supply_price = supply_price;
		this.selling_price = selling_price;
		this.isbn = isbn;
		this.product_image = product_image;
		this.product_info_image = product_info_image;
		this.author_translator = author_translator;
		this.original_author = original_author;
		this.illustrator = illustrator;
		this.publisher = publisher;
		this.publication_date = publication_date;
		this.page_count = page_count;
		this.size = size;
		this.total_volume = total_volume;
		this.author_introduction = author_introduction;
		this.introduction_intro = introduction_intro;
		this.introduction_detail = introduction_detail;
		this.table_of_contents = table_of_contents;
		this.notification_subscription = notification_subscription;
		this.best_seller_status = best_seller_status;
		this.category_key = category_key;
	}


	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getProduct_id() {
		return product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getConsumer_price() {
		return consumer_price;
	}
	public void setConsumer_price(int consumer_price) {
		this.consumer_price = consumer_price;
	}
	public int getSupply_price() {
		return supply_price;
	}
	public void setSupply_price(int supply_price) {
		this.supply_price = supply_price;
	}
	public int getSelling_price() {
		return selling_price;
	}
	public void setSelling_price(int selling_price) {
		this.selling_price = selling_price;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public String getProduct_info_image() {
		return product_info_image;
	}
	public void setProduct_info_image(String product_info_image) {
		this.product_info_image = product_info_image;
	}
	public String getAuthor_translator() {
		return author_translator;
	}
	public void setAuthor_translator(String author_translator) {
		this.author_translator = author_translator;
	}
	public String getOriginal_author() {
		return original_author;
	}
	public void setOriginal_author(String original_author) {
		this.original_author = original_author;
	}
	public String getIllustrator() {
		return illustrator;
	}
	public void setIllustrator(String illustrator) {
		this.illustrator = illustrator;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Timestamp getPublication_date() {
		return publication_date;
	}
	public void setPublication_date(Timestamp publication_date) {
		this.publication_date = publication_date;
	}
	public int getPage_count() {
		return page_count;
	}
	public void setPage_count(int page_count) {
		this.page_count = page_count;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getTotal_volume() {
		return total_volume;
	}
	public void setTotal_volume(int total_volume) {
		this.total_volume = total_volume;
	}
	public String getAuthor_introduction() {
		return author_introduction;
	}
	public void setAuthor_introduction(String author_introduction) {
		this.author_introduction = author_introduction;
	}
	public String getIntroduction_intro() {
		return introduction_intro;
	}
	public void setIntroduction_intro(String introduction_intro) {
		this.introduction_intro = introduction_intro;
	}
	public String getIntroduction_detail() {
		return introduction_detail;
	}
	public void setIntroduction_detail(String introduction_detail) {
		this.introduction_detail = introduction_detail;
	}
	public String getTable_of_contents() {
		return table_of_contents;
	}
	public void setTable_of_contents(String table_of_contents) {
		this.table_of_contents = table_of_contents;
	}
	public int getNotification_subscription() {
		return notification_subscription;
	}
	public void setNotification_subscription(int notification_subscription) {
		this.notification_subscription = notification_subscription;
	}
	public int getBest_seller_status() {
		return best_seller_status;
	}
	public void setBest_seller_status(int best_seller_status) {
		this.best_seller_status = best_seller_status;
	}
	public String getCategory_key() {
		return category_key;
	}
	public void setCategory_key(String category_key) {
		this.category_key = category_key;
	}


	@Override
	public String toString() {
		return "Products [product_id=" + product_id + ", product_name=" + product_name + ", consumer_price="
				+ consumer_price + ", supply_price=" + supply_price + ", selling_price=" + selling_price + ", isbn="
				+ isbn + ", product_image=" + product_image + ", product_info_image=" + product_info_image
				+ ", author_translator=" + author_translator + ", original_author=" + original_author + ", illustrator="
				+ illustrator + ", publisher=" + publisher + ", publication_date=" + publication_date + ", page_count="
				+ page_count + ", size=" + size + ", total_volume=" + total_volume + ", author_introduction="
				+ author_introduction + ", introduction_intro=" + introduction_intro + ", introduction_detail="
				+ introduction_detail + ", table_of_contents=" + table_of_contents + ", notification_subscription="
				+ notification_subscription + ", best_seller_status=" + best_seller_status + ", category_key="
				+ category_key + "]";
	}
	
	
}
