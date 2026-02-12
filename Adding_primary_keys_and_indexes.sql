/* 1.Making Primay keys for customers table*/
Select * 
From olist_customers;

ALTER TABLE olist_customers
ADD PRIMARY KEY (customer_id);


/* 2.Making Primay keys for orders table*/
Select *
From olist_orders;

ALTER TABLE olist_orders
ADD PRIMARY KEY (order_id);

ALTER TABLE olist_orders
ADD FOREIGN KEY (customer_id) REFERENCES olist_customers(customer_id);



/* 3.Making Primay keys for order_items table*/
Select * 
From olist_order_items;

ALTER TABLE olist_order_items
MODIFY COLUMN order_item_id INTEGER;

ALTER TABLE olist_order_items
MODIFY COLUMN price REAL;

ALTER TABLE olist_order_items
MODIFY COLUMN freight_value REAL;

ALTER TABLE olist_order_items
ADD CONSTRAINT PK_order_items PRIMARY KEY (order_id,order_item_id);

ALTER TABLE olist_order_items
ADD FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);



/* 4.Making Primay keys for payments table*/

Select * from 
olist_order_payments;

ALTER TABLE olist_order_payments
MODIFY COLUMN payment_sequential integer;

ALTER TABLE olist_order_payments
MODIFY COLUMN payment_installments integer;

ALTER TABLE olist_order_payments
MODIFY COLUMN payment_value real ;

ALTER TABLE olist_order_payments
ADD CONSTRAINT PK_olist_order_payments PRIMARY KEY (order_id,payment_sequential);

ALTER TABLE olist_order_payments
ADD FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);



/* 5.Making Primay keys for Reviews table*/

ALTER TABLE olist_order_reviews
ADD COLUMN review_pk INT AUTO_INCREMENT PRIMARY KEY;

select *
from olist_order_reviews;

ALTER TABLE olist_order_reviews
MODIFY COLUMN review_score integer ;


ALTER TABLE olist_order_reviews
ADD FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);




/* 6.Making Indexes on joins*/
CREATE INDEX idx_orders_order_id ON olist_orders(order_id);
CREATE INDEX idx_orders_customer_id ON olist_orders(customer_id);
CREATE INDEX idx_order_items_order_id ON olist_order_items(order_id);
CREATE INDEX idx_reviews_order_id ON olist_order_reviews(order_id);