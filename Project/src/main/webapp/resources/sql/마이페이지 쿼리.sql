-- fk 안 걸리면 부모테이블 인덱싱부터
CREATE INDEX payments_actualPay_fk ON payments(actual_payment_amount);
CREATE INDEX products_sellingPrice_fk ON products(selling_price);
-- 주문내역 페이지 쿼리
SELECT o.order_no, o.order_time, o.delivery_status, o.invoice_number, o.member_id,
		pay.actual_payment_amount, prod.product_image, prod.product_name
		FROM products prod
		JOIN  detailed_order_items d
        on prod.product_id = d.product_id
		JOIN payments pay
        on d.order_no = pay.order_no
        join order_history o
        on pay.order_no = o.order_no
		WHERE member_id = 'abc1234';

select count(*) from detailed_order_items;