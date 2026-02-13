

CREATE VIEW delivered_orders AS
SELECT *
FROM olist_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;



CREATE VIEW order_items_agg AS
SELECT
    order_id,
    COUNT(*) AS num_items,
    round(SUM(price), 2) AS order_value,
    round (SUM(freight_value),2) AS freight_value
FROM olist_order_items
GROUP BY order_id;



CREATE VIEW order_reviews_agg AS
SELECT
    order_id,
    AVG(review_score) AS avg_review_score,
    MAX(review_creation_date) AS latest_review_date
FROM olist_order_reviews
GROUP BY order_id;


select * from delivered_orders;



CREATE VIEW delivery_metrics AS
SELECT
    order_id,
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS delivery_days,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delivery_delay_days
FROM delivered_orders;




Create View order_analysis as 
select 
    del_O.order_id,
    c.customer_unique_id,
    del_O.order_purchase_timestamp,
    del_O.order_delivered_customer_date,
    del_O.order_estimated_delivery_date, 
    
    i.num_items,
    i.order_value,
    i.freight_value,
    
    r.avg_review_score,
    
    d.delivery_days,
    d.delivery_delay_days,
    
    Case 
		When d.delivery_delay_days > 0 then 1
        else 0
	END As is_late
    
    
    from delivered_orders del_O
    Join olist_customers c on del_O.customer_id = c.customer_id
    left join order_items_agg i on del_O.order_id = i.order_id
    left join order_reviews_agg r on del_O.order_id = r.order_id
    left join delivery_metrics d on del_O.order_id = d.order_id;
    





