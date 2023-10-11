use test;

-- 가데이터 인서트 
INSERT INTO `test`.`product_categories` (`category_key`, `category_name`) VALUES ('1', '한국소설');
INSERT INTO `test`.`products` (`product_id`, `product_name`, `consumer_price`, `supply_price`, `selling_price`, `product_image`, `category_key`) VALUES ('S000209715568', '로터스 택시에는 특별한 손님이 탑니다', '17000', '0', '15300', 'https://contents.kyobobook.co.kr/sih/fit-in/300x0/pdt/9791193262047.jpg', '1');
INSERT INTO `test`.`member` (`member_id`, `password`, `name`, `phone_number`, `gender`, `date_of_birth`, `zip_code`, `address`, `detailed_address`, `email`, `total_points`, `total_reward`, `coupon_count`) VALUES ('abc1234', '1234', 'abc', '01012345678', 'F', '20231011', '000000', '서울시 구로구 구로동', '구트아카데미 3층 6 강의실', 'abc1234@naver.com', '100', '0', '0');
INSERT INTO `test`.`order_history` (`order_no`, `member_id`, `invoice_number`, `recipient_name`, `recipient_phone_number`, `zip_code`, `shipping_address`, `detailed_shipping_address`, `delivery_status`, `delivery_message`) VALUES ('1', 'abc1234', '12345', 'dooly', '01012345678', '000000', '구트아카데미', '3층 6강의실', '준비중', '문앞');
INSERT INTO `test`.`payments` (`payment_number`, `order_no`, `total_amount`, `shipping_fee`, `actual_payment_amount`) VALUES ('1', '1', '20000', '0', '20000');
UPDATE `test`.`payments` SET `used_reward` = '500', `used_points` = '1000', `actual_payment_amount` = '18500' WHERE (`payment_number` = '1');
INSERT INTO `test`.`products` (`product_id`, `product_name`, `consumer_price`, `supply_price`, `selling_price`, `product_image`, `category_key`) VALUES ('S000208993233', '푸바오, 매일매일 행복해', '20000', '0', '18000', 'https://contents.kyobobook.co.kr/sih/fit-in/300x0/pdt/9791171251704.jpg', '1');
UPDATE `test`.`order_history` SET `invoice_number` = '12345' WHERE (`order_no` = '2');
INSERT INTO `test`.`payments` (`payment_number`, `order_no`, `payment_method`, `total_amount`, `shipping_fee`, `used_reward`, `used_points`, `actual_payment_amount`) VALUES ('2', '2', '카드', '15300', '0', '0', '1000', '14300');
UPDATE `test`.`payments` SET `payment_method` = '카드' WHERE (`payment_number` = '1');
UPDATE `test`.`payments` SET `order_no` = '1' WHERE (`payment_number` = '2');

-- 주문내역 페이지 쿼리
SELECT o.order_no, o.order_time, o.delivery_status, o.invoice_number,
		pay.actual_payment_amount, prod.product_image, prod.product_name
		FROM order_history o
		JOIN payments pay
		JOIN products prod
		WHERE member_id = 'abc1234';
        
ALTER TABLE `test`.`detailed_order_items` 
CHANGE COLUMN `coupon` `coupon` VARCHAR(5) NULL DEFAULT '0' COMMENT '할인 쿠폰' ;

ALTER TABLE `test`.`detailed_order_items` 
ADD INDEX `detailOrder_coupon_fk_idx` (`coupon` ASC) VISIBLE;
;
ALTER TABLE `test`.`detailed_order_items` 
ADD CONSTRAINT `detailOrder_coupon_fk`
  FOREIGN KEY (`coupon`)
  REFERENCES `test`.`coupons` (`coupon_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
ALTER TABLE `test`.`detailed_order_items` 
CHANGE COLUMN `discounted_price` `discounted_price` INT(11) NULL COMMENT '쿠폰 적용 가격' ;

ALTER TABLE `gott123`.`non_order_history` 
ADD COLUMN `no` INT NOT NULL AUTO_INCREMENT FIRST,
CHANGE COLUMN `non_order_no` `non_order_no` INT(11) NULL COMMENT '주문 번호' ,
ADD UNIQUE INDEX `non_order_no_UNIQUE` (`non_order_no` ASC) ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`no`);
;

ALTER TABLE `gott123`.`detailed_order_items` 
ADD INDEX `detailOrder_coupon_fk_idx` (`coupon` ASC) ;
;
ALTER TABLE `gott123`.`detailed_order_items` 
ADD CONSTRAINT `detailOrder_coupon_fk`
  FOREIGN KEY (`coupon`)
  REFERENCES `gott123`.`coupons` (`coupon_number`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `gott123`.`detailed_order_items` 
CHANGE COLUMN `discounted_price` `discounted_price` INT(11) NULL COMMENT '쿠폰 적용 가격' ;
