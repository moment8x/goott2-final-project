package com.project.vodto.kjy;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class Products {
	private String productId;
	private String beforeProductId;
	private String productName;
	private int consumerPrice;
	private int supplyPrice;
	private int sellingPrice;
	private String isbn;
	private String productInfoImage;
	private String authorTranslator;
	private String originalAuthor;
	private String illustrator;
	private String publisher;
	private Timestamp publicationDate;
	private String pageCount;
	private String size;
	private int totalVolume;
	private String authorIntroduction;
	private String introductionIntro;
	private String introductionDetail;
	private String tableOfContents;
	private int notificationSubscription;
	private int bestSellerStatus;
	private String categoryKey;
	private int currentQuantity;
	private String productImage;
	private List<String> productImages;
	
}
