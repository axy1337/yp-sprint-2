-- из source1 в dwh 
insert into dwh.f_order ( product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, load_dttm)
select product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, now()
from source1.craft_market_wide;

insert into dwh.d_craftsman (craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, load_dttm)
select craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, now()
from source1.craft_market_wide;

insert into dwh.d_customer(customer_name, customer_address, customer_birthday, customer_email, load_dttm)
select customer_name, customer_address, customer_birthday, customer_email, now()
from source1.craft_market_wide;

insert into dwh.d_product(product_name, product_description, product_type, product_price, load_dttm)
select product_name, product_description, product_type, product_price, now()
from source1.craft_market_wide;



-- из source2 в dwh
insert into dwh.d_craftsman ( craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, load_dttm)
select craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, now()
from source2.craft_market_masters_products;

insert into dwh.d_product(product_name, product_description, product_type, product_price, load_dttm)
select product_name, product_description, product_type, product_price, now()
from source2.craft_market_masters_products;

insert into dwh.f_order ( product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, load_dttm)
select product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, now()
from source2.craft_market_orders_customers;

insert into dwh.d_customer(customer_name, customer_address, customer_birthday, customer_email, load_dttm)
select customer_name, customer_address, customer_birthday, customer_email, now()
from source2.craft_market_orders_customers;



-- из source3 в dwh
insert into dwh.d_craftsman(craftsman_name, craftsman_address, craftsman_birthday, craftsman_email)
select craftsman_name, craftsman_address, craftsman_birthday, craftsman_email
from source3.craft_market_craftsmans;

insert into dwh.d_customer(customer_name, customer_address, customer_birthday, customer_email, load_dttm)
select customer_name, customer_address, customer_birthday, customer_email, now()
from source3.craft_market_customers;

insert into dwh.f_order ( product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, load_dttm)
select product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status, now()
from source3.craft_market_orders;

insert into dwh.d_product(product_name, product_description, product_type, product_price, load_dttm)
select product_name, product_description, product_type, product_price, now()
from source3.craft_market_orders;