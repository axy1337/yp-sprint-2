insert into dwh.d_craftsman(craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, load_dttm)
select cpo.craftsman_name, cpo.craftsman_address, cpo.craftsman_birthday, cpo.craftsman_email, now()
from external_source.craft_products_orders cpo;

insert into dwh.d_customer( customer_name, customer_address, customer_birthday, customer_email, load_dttm)
SELECT  customer_name, customer_address, customer_birthday, customer_email, now()
FROM external_source.customers;

insert into dwh.f_order ( product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, load_dttm)
select  cpo.product_id, cpo.craftsman_id, cpo.customer_id, cpo.order_created_date, cpo.order_completion_date, cpo.order_status, now()
from external_source.craft_products_orders cpo;

insert into dwh.d_product (product_name, product_description, product_type, product_price, load_dttm)
select  cpo.product_name, cpo.product_description, cpo.product_type, cpo.product_price, now()
from external_source.craft_products_orders cpo;
 	