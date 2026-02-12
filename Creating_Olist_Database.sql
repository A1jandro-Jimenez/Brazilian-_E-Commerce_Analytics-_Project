Use brazilian_ecommerce;

Create Table olist_orders
(
	order_id varchar(255), 
    customer_id	varchar(255),
    order_status varchar(255),
    order_purchase_timestamp varchar(255), 
    order_approved_at varchar(255), 
    order_delivered_carrier_date varchar(255), 
    order_delivered_customer_date varchar(255), 
    order_estimated_delivery_date varchar(255)
);



LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv' INTO TABLE olist_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

Select Count(*)
From olist_orders;


Create Table olist_customers
(
	customer_id	varchar(255),
    customer_unique_id varchar(255),
    customer_zip_code_prefix varchar(255),
    customer_city varchar(255),
    customer_state varchar(255)
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv' INTO TABLE olist_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


select Count(*)
From olist_customers;


Create Table olist_order_items
(
	order_id varchar(255),
    order_item_id varchar(255),
    product_id	varchar(255),
    seller_id varchar(255),
    shipping_limit_date varchar(255),
    price varchar(255),
    freight_value varchar(255)

);


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv' INTO TABLE olist_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT count(*)
FROM olist_order_items;


Create Table olist_order_payments
(
	order_id varchar(255),
    payment_sequential varchar(255),
    payment_type varchar(255),
    payment_installments varchar(255),
    payment_value varchar(255)

);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv' INTO TABLE olist_order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT *
FROM olist_order_payments;



Create Table olist_order_reviews
(
	review_id varchar (255),
    order_id varchar (255),
    review_score varchar (255),
    review_comment_title varchar (255),
    review_comment_message varchar (1000),
    review_creation_date varchar (255),
    review_answer_timestamp varchar (255)
);


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv' INTO TABLE olist_order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select count(*) 
from olist_order_reviews;



 Create Table olist_products
(
	product_id varchar (255) Primary Key,
   product_category_name varchar (255),
     product_name_length integer ,
    product_description_length integer,
     product_photos_qty integer ,
     product_weight_g real ,
     product_length_cm real,
     product_height_cm real, 
     product_width_cm real
);


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv' INTO TABLE olist_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


Create Table olist_sellers
(
	seller_id varchar (255) Primary Key,
    seller_zip_code_prefix varchar (255),
	seller_city varchar (255) ,
	seller_state varchar(255)
     
);

			
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv' INTO TABLE olist_sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;




Create Table olist_product_category_name_translation
(
	product_category_name varchar (255) Primary Key,
    product_category_name_english varchar (255)
);


LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv' INTO TABLE olist_product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * 
from olist_product_category_name_translation;