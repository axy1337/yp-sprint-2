/* добавление данных из нового источника external_source во временную таблицу */
drop table tmp_sources;

CREATE temp TABLE tmp_sources (
    order_id INT,
    order_created_date DATE,
    order_completion_date DATE,
    order_status VARCHAR,
    craftsman_id INT,
    craftsman_name VARCHAR,
    craftsman_address VARCHAR,
    craftsman_birthday DATE,
    craftsman_email VARCHAR,
    product_id INT,
    product_name VARCHAR,
    product_description TEXT,
    product_type VARCHAR,
    product_price NUMERIC,
    customer_id INT,
    customer_name VARCHAR,
    customer_address VARCHAR,
    customer_birthday DATE,
    customer_email VARCHAR);

select *
from tmp_sources;

INSERT INTO tmp_sources
SELECT  order_id,
        order_created_date,
        order_completion_date,
        order_status,
        craftsman_id,
        craftsman_name,
        craftsman_address,
        craftsman_birthday,
        craftsman_email,
        product_id,
        product_name,
        product_description,
        product_type,
        product_price,
        customer_id,
        customer_name,
        customer_address,
        customer_birthday,
        customer_email
  FROM external_source.craft_products_orders
UNION ALL
SELECT  NULL AS order_id, -- заказы отсутствуют в этой таблице
        NULL AS order_created_date,
        NULL AS order_completion_date,
        NULL AS order_status,
        NULL AS craftsman_id, -- мастера отсутствуют в этой таблице
        NULL AS craftsman_name,
        NULL AS craftsman_address,
        NULL AS craftsman_birthday,
        NULL AS craftsman_email,
        NULL AS product_id, -- продукты отсутствуют в этой таблице
        NULL AS product_name,
        NULL AS product_description,
        NULL AS product_type,
        NULL AS product_price,
        customer_id,
        customer_name,
        customer_address,
        customer_birthday,
        customer_email
  FROM external_source.customers;
 
 
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













-- из  external_source в dwh
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









 	