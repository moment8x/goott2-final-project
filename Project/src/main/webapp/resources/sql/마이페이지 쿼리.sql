use test;

-- fk 안 걸리면 부모테이블 인덱싱부터
CREATE INDEX payments_actualPay_fk ON payments(actual_payment_amount);
CREATE INDEX products_sellingPrice_fk ON products(selling_price);

-- 한 주문건당 주문내역 페이지 쿼리
SELECT o.order_no, o.order_time, o.delivery_status, o.invoice_number, o.member_id,
		pay.actual_payment_amount, prod.product_image, prod.product_name
		FROM products prod
		inner JOIN  detailed_order_items d
        on prod.product_id = d.product_id
		inner JOIN payments pay
        on d.order_no = pay.order_no
        inner join order_history o
        on pay.order_no = o.order_no
		WHERE member_id = 'abc1234' and o.order_no = 1 limit 1;
 
 SELECT
    o.order_no,
    o.order_time AS order_time,
    o.delivery_status AS delivery_status,
    o.invoice_number AS invoice_number,
    o.member_id AS member_id,
    MAX(pay.actual_payment_amount) AS actual_payment_amount,
    MAX(prod.product_image) AS product_image,
    MAX(prod.product_name) AS product_name
FROM
    products prod
INNER JOIN detailed_order_items d ON prod.product_id = d.product_id
INNER JOIN payments pay ON d.order_no = pay.order_no
INNER JOIN order_history o ON pay.order_no = o.order_no
WHERE
    member_id = 'abc1234'
GROUP BY
    o.order_no;
 
 
 -- 주문번호 가져오기
select order_no from order_history where member_id = 'abc1234';
 
-- 한 주문건당 주문한 상품 총 갯수
select count(*) from detailed_order_items where order_no = 1;