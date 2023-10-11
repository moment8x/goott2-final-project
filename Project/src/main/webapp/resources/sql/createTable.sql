use test;

-- table DDL
CREATE TABLE `non_order_history` (
  `non_order_no` int(11) NOT NULL COMMENT '주문 번호',
  `non_member_id` varchar(50) NOT NULL COMMENT '비회원ID',
  `invoice_number` varchar(14) DEFAULT NULL COMMENT '송장 번호',
  `recipient_name` varchar(90) NOT NULL COMMENT '수령자 이름',
  `recipient_phone_number` varchar(15) NOT NULL COMMENT '수령자 전화 번호',
  `order_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '주문 시간',
  `zip_code` varchar(30) NOT NULL COMMENT '우편번호',
  `shipping_address` varchar(60) NOT NULL COMMENT '배송지 주소',
  `detailed_shipping_adress` varchar(60) NOT NULL COMMENT '배송지 상세 주소',
  `delivery_status` varchar(12) DEFAULT NULL COMMENT '배송 상태',
  `delivery_message` varchar(300) DEFAULT NULL COMMENT '배송 메세지',
  `non_deleted_date` datetime NOT NULL COMMENT '삭제 예정일',
  `non_password` varchar(100) NOT NULL COMMENT '비밀번호',
  `non_email` varchar(30) NOT NULL COMMENT '이메일',
  PRIMARY KEY (`non_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비회원 주문 내역';

CREATE TABLE `upload_file` (
  `uf_no` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail_filename` varchar(30) NOT NULL COMMENT '썸네일 파일명',
  `extension` varchar(5) NOT NULL COMMENT '확장자',
  `original_filename` varchar(90) NOT NULL COMMENT '원본 이름',
  `new_filename` varchar(90) DEFAULT NULL COMMENT '새 이름(경로 포함)',
  `file_size` int(11) NOT NULL COMMENT '파일 사이즈',
  PRIMARY KEY (`uf_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='업로드 파일';

CREATE TABLE `member` (
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `password` varchar(90) NOT NULL COMMENT '비밀번호',
  `name` varchar(90) NOT NULL COMMENT '이름',
  `phone_number` varchar(15) DEFAULT NULL COMMENT '핸드폰번호',
  `registeration_date` datetime NOT NULL COMMENT '가입일',
  `gender` char(1) NOT NULL COMMENT '성별',
  `date_of_birth` varchar(8) NOT NULL COMMENT '생년월일',
  `zip_code` varchar(30) DEFAULT NULL COMMENT '우편 번호',
  `address` varchar(60) DEFAULT NULL COMMENT '주소',
  `detailed_address` varchar(60) DEFAULT NULL COMMENT '상세 주소',
  `email` varchar(30) NOT NULL,
  `identity_verification_status` char(1) DEFAULT NULL COMMENT '본인 인증 여부',
  `adult_verification_status` char(1) DEFAULT NULL COMMENT '성인 인증 여부',
  `receive_advertising` char(1) DEFAULT NULL COMMENT '광고수신',
  `membership_grade` varchar(16) NOT NULL DEFAULT '아기사슴' COMMENT '회원 등급',
  `total_points` int(8) NOT NULL DEFAULT '0' COMMENT '총 포인트',
  `total_reward` int(8) NOT NULL DEFAULT '0' COMMENT '총 적립금',
  `coupon_count` int(2) NOT NULL DEFAULT '0' COMMENT '쿠폰 갯수',
  `profile_image` int(11) DEFAULT NULL COMMENT '프로필 사진',
  `remember` tinyint(4) DEFAULT NULL COMMENT '자동로그인',
  `last_login_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '마지막 접속일',
  `refund_bank` varchar(20) DEFAULT NULL COMMENT '환불 은행',
  `refund_account` varchar(14) DEFAULT NULL COMMENT '환불 계좌',
  `dormant_account` varchar(13) DEFAULT NULL COMMENT '휴면 계정',
  `member_token` varchar(100) DEFAULT NULL COMMENT '회원 토큰',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `refund_account_UNIQUE` (`refund_account`),
  UNIQUE KEY `dormant_account_UNIQUE` (`dormant_account`),
  UNIQUE KEY `member_token_UNIQUE` (`member_token`),
  KEY `member_profileImage_fk` (`profile_image`),
  CONSTRAINT `member_profileImage_fk` FOREIGN KEY (`profile_image`) REFERENCES `upload_file` (`uf_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원';

CREATE TABLE `order_history` (
  `order_no` int(11) NOT NULL AUTO_INCREMENT COMMENT '주문번호',
  `member_id` varchar(13) DEFAULT NULL COMMENT '회원ID',
  `invoice_number` varchar(14) DEFAULT NULL COMMENT '송장번호',
  `recipient_name` varchar(90) NOT NULL COMMENT '수령자 이름',
  `recipient_phone_number` varchar(15) NOT NULL COMMENT '수령자 전화번호',
  `order_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '주문 시간',
  `zip_code` varchar(30) NOT NULL COMMENT '우편번호',
  `shipping_address` varchar(60) NOT NULL COMMENT '배송지 주소',
  `detailed_shipping_address` varchar(60) DEFAULT NULL COMMENT '배송지 상세 주소',
  `delivery_status` varchar(12) DEFAULT NULL COMMENT '배송상태',
  `delivery_message` varchar(300) DEFAULT NULL COMMENT '배송메세지',
  PRIMARY KEY (`order_no`),
  KEY `order_history_member_id_fk` (`member_id`),
  CONSTRAINT `order_history_member_id_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문내역';

CREATE TABLE `payments` (
  `payment_number` varchar(10) NOT NULL COMMENT '결제번호',
  `order_no` int(11) DEFAULT NULL COMMENT '회원 주문 번호',
  `non_order_no` int(11) DEFAULT NULL COMMENT '비회원 주문 번호',
  `payment_method` varchar(30) DEFAULT NULL COMMENT '결제 수단',
  `total_amount` varchar(8) NOT NULL COMMENT '총 금액',
  `shipping_fee` int(11) NOT NULL COMMENT '배송비배송비',
  `used_reward` int(11) DEFAULT NULL COMMENT '사용한 적립금',
  `used_points` int(11) DEFAULT NULL COMMENT '사용한 포인트',
  `actual_payment_amount` varchar(8) NOT NULL COMMENT '실 결제액',
  `payment_time` datetime DEFAULT NULL COMMENT '결제 시간',
  PRIMARY KEY (`payment_number`),
  KEY `payments_nonOrderNo_fk` (`non_order_no`),
  KEY `payments_orderNo_fk` (`order_no`),
  CONSTRAINT `payments_nonOrderNo_fk` FOREIGN KEY (`non_order_no`) REFERENCES `non_order_history` (`non_order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `payments_orderNo_fk` FOREIGN KEY (`order_no`) REFERENCES `order_history` (`order_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제';

CREATE TABLE `bank_transfers` (
  `payment_number` varchar(10) NOT NULL COMMENT '결제번호',
  `order_no` int(11) NOT NULL COMMENT '주문 번호',
  `bank_name` varchar(30) NOT NULL COMMENT '입금 은행',
  `payer_name` varchar(90) NOT NULL COMMENT '입금자명',
  `deposit_amount` int(8) NOT NULL COMMENT '입금액',
  `payment_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '결제 시간',
  `deposited_account` varchar(14) NOT NULL COMMENT '입금된 계좌',
  PRIMARY KEY (`payment_number`),
  KEY `bank_transfers_order_no_fk` (`order_no`),
  CONSTRAINT `bank_transfers_order_no_fk` FOREIGN KEY (`order_no`) REFERENCES `payments` (`order_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bank_transfers_payment_fk` FOREIGN KEY (`payment_number`) REFERENCES `payments` (`payment_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='무통장 입금';

CREATE TABLE `product_categories` (
  `category_key` varchar(5) NOT NULL,
  `category_name` varchar(30) NOT NULL COMMENT '카테고리명',
  PRIMARY KEY (`category_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 카테고리';

CREATE TABLE `products` (
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `product_name` varchar(60) NOT NULL COMMENT '상품명',
  `consumer_price` int(11) NOT NULL COMMENT '소비자가',
  `supply_price` int(11) NOT NULL COMMENT '공급가',
  `selling_price` int(11) NOT NULL COMMENT '판매가',
  `isbn` varchar(30) DEFAULT NULL COMMENT 'ISBN',
  `product_image` text COMMENT '상푸 ㅁ이미지',
  `product_info_image` text COMMENT '상품정보 이미지',
  `author_translator` varchar(90) DEFAULT NULL COMMENT '작가/역자',
  `original_author` varchar(60) DEFAULT NULL COMMENT '원서/저자명',
  `illustrator` varchar(60) DEFAULT NULL COMMENT '일러스트레이터',
  `publisher` varchar(45) DEFAULT NULL COMMENT '출판사',
  `publication_date` datetime DEFAULT NULL COMMENT '발행일',
  `page_count` int(11) DEFAULT NULL COMMENT '페이지 수',
  `size` varchar(15) DEFAULT NULL COMMENT '크기',
  `total_volume` int(11) DEFAULT NULL COMMENT '총 권수',
  `author_introduction` text COMMENT '저자 소개',
  `introduction_intro` text COMMENT '소개글intro',
  `introduction_detail` text COMMENT '소개글detail',
  `table_of_contents` varchar(255) DEFAULT NULL COMMENT '목차',
  `notification_subscription` tinyint(4) DEFAULT NULL COMMENT '알림 신청',
  `best_seller_status` tinyint(4) DEFAULT NULL COMMENT '베스트셀러 여부',
  `category_key` varchar(5) NOT NULL COMMENT '카테고리',
  PRIMARY KEY (`product_id`),
  KEY `product_category_fk` (`category_key`),
  CONSTRAINT `product_category_fk` FOREIGN KEY (`category_key`) REFERENCES `product_categories` (`category_key`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품';

CREATE TABLE `board_categories` (
  `category_id` int(2) NOT NULL COMMENT '분류ID',
  `category_name` varchar(30) NOT NULL COMMENT '분류명',
  `subcategory` varchar(60) DEFAULT NULL COMMENT '상세분류',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 분류';

CREATE TABLE `board` (
  `post_no` int(11) NOT NULL AUTO_INCREMENT COMMENT '글 번호',
  `author` varchar(13) NOT NULL COMMENT '작성자',
  `careated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `category_id` int(2) NOT NULL COMMENT '분류ID',
  `title` varchar(60) NOT NULL COMMENT '제목',
  `content` longtext NOT NULL COMMENT '내용',
  `file` int(11) DEFAULT NULL COMMENT '파일',
  `ref` int(11) NOT NULL COMMENT '부모글 번호',
  `step` int(11) DEFAULT NULL,
  `ref_order` int(11) DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT '0' COMMENT '좋아요!',
  PRIMARY KEY (`post_no`),
  KEY `board_author_fk` (`author`),
  KEY `board_categorId_fk` (`category_id`),
  CONSTRAINT `board_author_fk` FOREIGN KEY (`author`) REFERENCES `member` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `board_categorId_fk` FOREIGN KEY (`category_id`) REFERENCES `board_categories` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판';

CREATE TABLE `detailed_order_items` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) DEFAULT '0' COMMENT '회원주문번호',
  `non_order_no` int(11) DEFAULT '0' COMMENT '비회원 주문번호',
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `product_price` int(11) NOT NULL COMMENT '상품 가격',
  `coupon` int(3) DEFAULT '0' COMMENT '할인 쿠폰',
  `discounted_price` int(11) NOT NULL COMMENT '쿠폰 적용 가격',
  PRIMARY KEY (`no`),
  KEY `member_order` (`order_no`),
  KEY `non_member_order` (`non_order_no`),
  KEY `product_id_order` (`product_id`),
  CONSTRAINT `member_order` FOREIGN KEY (`order_no`) REFERENCES `order_history` (`order_no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `non_member_order` FOREIGN KEY (`non_order_no`) REFERENCES `non_order_history` (`non_order_no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `product_id_order` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 상세 상품';

CREATE TABLE `cancellations` (
  `cancel_no` int(11) NOT NULL COMMENT '취소번호',
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `reason` varchar(600) NOT NULL COMMENT '사유',
  `amount` int(11) NOT NULL COMMENT '금액',
  `processing_status` tinyint(4) NOT NULL COMMENT '처리여부 / 취소접수, 취소완료',
  `refund_status` tinyint(4) DEFAULT NULL COMMENT '환불여부/내가 돈을 줘야 하는가?',
  `request_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '요청시간',
  `completion_time` datetime DEFAULT NULL COMMENT '완료시간',
  PRIMARY KEY (`cancel_no`),
  KEY `cancellations_product_id_fk` (`product_id`),
  CONSTRAINT `cancellations_cancle_no_fk` FOREIGN KEY (`cancel_no`) REFERENCES `detailed_order_items` (`no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `cancellations_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `detailed_order_items` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='취소';

CREATE TABLE `coupon_categories` (
  `category_key` varchar(5) NOT NULL COMMENT '쿠폰번호',
  `coupon_number` varchar(5) NOT NULL COMMENT '분류번호',
  PRIMARY KEY (`category_key`),
  CONSTRAINT `category_key_fk` FOREIGN KEY (`category_key`) REFERENCES `product_categories` (`category_key`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쿠폰 적용 카테고리\nPK는 category_key입니다.';

CREATE TABLE `coupons` (
  `coupon_number` varchar(5) NOT NULL COMMENT '쿠폰 번호',
  `expiration_date` datetime NOT NULL COMMENT '만료일',
  `discount_method` char(1) NOT NULL COMMENT '할인 방법 (P:퍼센트, D:지정액)',
  `discount_amount` int(4) NOT NULL COMMENT '할인율(금액)',
  PRIMARY KEY (`coupon_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쿠폰';

CREATE TABLE `coupon_logs` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `coupon_number` varchar(5) NOT NULL COMMENT '쿠폰 번호',
  `coupon_name` varchar(50) NOT NULL COMMENT '쿠폰명',
  `obtained_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '얻은 날짜',
  `used_date` datetime DEFAULT NULL COMMENT '사용 날짜',
  PRIMARY KEY (`no`),
  KEY `couponLog_couponnumber_fk` (`coupon_number`),
  KEY `couponLog_memberId_fk` (`member_id`),
  CONSTRAINT `couponLog_couponnumber_fk` FOREIGN KEY (`coupon_number`) REFERENCES `coupons` (`coupon_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `couponLog_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쿠폰 로그';

CREATE TABLE `returns` (
  `return_no` int(11) NOT NULL,
  `product_id` varchar(20) NOT NULL,
  `reason` varchar(600) NOT NULL COMMENT '사유',
  `processing_status` varchar(15) NOT NULL COMMENT '처리여부(반품신청, 반송 중, 반품 완료, 교환, 환불)',
  `request_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completion_time` datetime DEFAULT NULL,
  `refund_status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`return_no`),
  KEY `returns_product_id_fk` (`product_id`),
  CONSTRAINT `return_no_fk` FOREIGN KEY (`return_no`) REFERENCES `detailed_order_items` (`no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `returns_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `detailed_order_items` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='반품';

CREATE TABLE `customer_inquiries_board` (
  `post_no` int(11) NOT NULL AUTO_INCREMENT COMMENT '글 번호',
  `author` varchar(13) NOT NULL COMMENT '작성자',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `title` varchar(60) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '내용',
  `file` int(11) DEFAULT NULL COMMENT '파일',
  `answer_status` varchar(1) NOT NULL DEFAULT 'N' COMMENT '답변 여부 (Y:답변완료, N:답변 기다리는중)',
  `ref` int(11) NOT NULL COMMENT '부모글번호',
  `step` int(11) DEFAULT NULL,
  `ref_order` int(11) DEFAULT NULL,
  `answer_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '답변 등록일',
  PRIMARY KEY (`post_no`),
  KEY `customerInquiriesBoard_author_fk` (`author`),
  KEY `customerInquiriesBoard_postNo_fk` (`file`),
  CONSTRAINT `customerInquiriesBoard_author_fk` FOREIGN KEY (`author`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `customerInquiriesBoard_postNo_fk` FOREIGN KEY (`file`) REFERENCES `upload_file` (`uf_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1:1 문의 게시판';

CREATE TABLE `exchanges` (
  `exchange_no` int(11) NOT NULL COMMENT '교환번호',
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `reason` varchar(600) NOT NULL COMMENT '교환 사유',
  `processing_status` char(1) NOT NULL COMMENT '처리여부 (교환(배송)중 / 교환 완료)',
  `request_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completion_time` datetime DEFAULT NULL,
  `exchange_product_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`exchange_no`),
  KEY `exchanges_product_id_fk` (`product_id`),
  CONSTRAINT `exchanges_no_fk` FOREIGN KEY (`exchange_no`) REFERENCES `returns` (`return_no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `exchanges_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `returns` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='교환';

CREATE TABLE `grades` (
  `grade` varchar(16) NOT NULL COMMENT '등급',
  `discount_rate` tinyint(4) NOT NULL COMMENT '할인율',
  PRIMARY KEY (`grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='등급';

CREATE TABLE `member_grades` (
  `member_id` varchar(13) NOT NULL COMMENT '회원 ID',
  `grade` varchar(16) NOT NULL COMMENT '등급',
  `actual_payment` int(8) NOT NULL DEFAULT '0' COMMENT '실 결제액',
  PRIMARY KEY (`member_id`),
  KEY `memberGrade_grade_fk` (`grade`),
  CONSTRAINT `memberGrade_grade_fk` FOREIGN KEY (`grade`) REFERENCES `grades` (`grade`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `memberGrade_memberId` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원 등급';

CREATE TABLE `non_shopping_cart` (
  `non_member_id` varchar(50) NOT NULL COMMENT '비회원ID',
  PRIMARY KEY (`non_member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비회원 장바구니';

CREATE TABLE `notifications` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `link` varchar(100) NOT NULL COMMENT '링크',
  `notification_title` varchar(120) NOT NULL COMMENT '알림제목',
  `notification_content` varchar(600) NOT NULL COMMENT '알림내용',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '날짜',
  `expiration_date` datetime DEFAULT NULL COMMENT '만료일(now() + 7 안됨. 수동으로 하길 바람)',
  `read_status` tinyint(4) DEFAULT NULL COMMENT '읽음 여부(Y:읽음, N:안 읽음)',
  PRIMARY KEY (`key`),
  KEY `notifications_member_fk` (`member_id`),
  CONSTRAINT `notifications_member_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='알림';

CREATE TABLE `point_logs` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '날짜',
  `reason` varchar(6) NOT NULL COMMENT '사유',
  `point` int(4) DEFAULT '0' COMMENT '점수',
  PRIMARY KEY (`no`),
  KEY `pointLogs_memberId_fk` (`member_id`),
  CONSTRAINT `pointLogs_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 로그';

CREATE TABLE `point_rules` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(6) NOT NULL COMMENT '사유(구매/이벤트)',
  `point` int(7) NOT NULL COMMENT '점수(구매10%)',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기본 포인트 배정';

CREATE TABLE `ratings` (
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `rating` float(2,1) DEFAULT NULL COMMENT '평점',
  `participation_count` int(8) NOT NULL COMMENT '평점 참여 인원',
  `highest_rating` int(2) DEFAULT NULL COMMENT '최고점',
  `lowest_rating` int(1) DEFAULT NULL COMMENT '최하점',
  PRIMARY KEY (`product_id`),
  CONSTRAINT `rating_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='평점';

CREATE TABLE `refunds` (
  `refund_no` int(11) NOT NULL,
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `refund_application_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '환불 신청일',
  `refund_processing_completion_date` datetime DEFAULT NULL COMMENT '환불 처리 완료일',
  `refund_number` int(11) NOT NULL COMMENT '환불 번호',
  `total_refund_amount` int(11) DEFAULT NULL COMMENT '총 환불액(적립금, 포인트 포함)',
  `actual_refund_amount` int(11) DEFAULT NULL COMMENT '실 환불액(현금)',
  `refund_reward_used` int(11) DEFAULT NULL COMMENT '사용한 적립금 환불',
  `refund_point_used` int(11) DEFAULT NULL COMMENT '사용한 포인트 환불',
  `refund_processing_detail` char(1) NOT NULL COMMENT '환불 처리/상세 (ex.처리 전, 처리 완료)',
  `refund_information` varchar(15) NOT NULL COMMENT '환불 정보(ex.팝업용 버튼)',
  PRIMARY KEY (`refund_no`),
  KEY `refunds_returns_product_id_fk` (`product_id`),
  CONSTRAINT `refunds_cancel_no` FOREIGN KEY (`refund_no`) REFERENCES `cancellations` (`cancel_no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `refunds_cancel_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `cancellations` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `refunds_returns_no` FOREIGN KEY (`refund_no`) REFERENCES `returns` (`return_no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `refunds_returns_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `returns` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='환불';

CREATE TABLE `reward_logs` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `date` datetime NOT NULL COMMENT '날짜',
  `reward` int(11) NOT NULL COMMENT '점수',
  PRIMARY KEY (`no`),
  KEY `rewardLog_memberId_fk` (`member_id`),
  CONSTRAINT `rewardLog_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='적립금 로그';

CREATE TABLE `shipping_address` (
  `addr_no` int(11) NOT NULL,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `zip_code` varchar(30) DEFAULT NULL COMMENT '우편 번호',
  `address` varchar(60) DEFAULT NULL COMMENT '주소',
  `detailed_address` varchar(60) DEFAULT NULL COMMENT '상세 주소',
  `basic_addr` char(1) DEFAULT NULL COMMENT '기본 배송지 체크 여부',
  PRIMARY KEY (`addr_no`),
  KEY `shippingAddr_memberId_fk` (`member_id`),
  CONSTRAINT `shippingAddr_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='배송지';

CREATE TABLE `shopping_cart` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `non_member_id` varchar(50) DEFAULT NULL COMMENT '비회원ID',
  `member_id` varchar(13) DEFAULT NULL COMMENT '회원ID',
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `member_check` tinyint(4) NOT NULL COMMENT '회원체크(T:회원, F:비회원)',
  `registration_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`no`),
  KEY `shoppingCart_memberId_fk` (`member_id`),
  KEY `shoppingCart_nonMemberId_fk` (`non_member_id`),
  KEY `shoppingCart_productId_fk` (`product_id`),
  CONSTRAINT `shoppingCart_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `shoppingCart_nonMemberId_fk` FOREIGN KEY (`non_member_id`) REFERENCES `non_shopping_cart` (`non_member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `shoppingCart_productId_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장바구니';

CREATE TABLE `stock` (
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `product_name` varchar(100) NOT NULL COMMENT '상품명',
  `current_quantity` int(3) NOT NULL DEFAULT '0' COMMENT '남은 수량',
  `category_key` varchar(5) NOT NULL COMMENT '카테고리',
  PRIMARY KEY (`product_id`),
  KEY `stock_category_fk` (`category_key`),
  CONSTRAINT `stock_category_fk` FOREIGN KEY (`category_key`) REFERENCES `product_categories` (`category_key`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `stock_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='재고';

CREATE TABLE `terms_and_conditions` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `terms_type` varchar(30) NOT NULL COMMENT '약관 종류',
  `terms_content` text NOT NULL COMMENT '약관 내용',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='약관';

CREATE TABLE `wishlist` (
  `wishlist_no` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(13) NOT NULL COMMENT '회원ID',
  `product_id` varchar(20) NOT NULL COMMENT '상품ID',
  `registration_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `category_key` varchar(5) NOT NULL COMMENT '카테고리',
  PRIMARY KEY (`wishlist_no`),
  KEY `wishlist_categoryKey_fk` (`category_key`),
  KEY `wishlist_memberId_fk` (`member_id`),
  KEY `wishlist_productId_fk` (`product_id`),
  CONSTRAINT `wishlist_categoryKey_fk` FOREIGN KEY (`category_key`) REFERENCES `product_categories` (`category_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wishlist_memberId_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `wishlist_productId_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='찜';

ALTER TABLE non_shopping_cart
ADD COLUMN `non_shopping_cartcol` DATETIME NOT NULL DEFAULT now() AFTER `non_member_id`;