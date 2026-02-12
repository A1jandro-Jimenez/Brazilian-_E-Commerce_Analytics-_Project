# Brazilian_E-Commerce_Analytics_Project
End-to-end e-commerce analytics project analyzing delivery performance, customer satisfaction, and revenue risk using Python, SQL, statistical modeling, and Power BI.

## Business Problem
Often times e-commerce companies face customer churn driven by delayed deliveries. This project analyzes how delivery performance impacts customer satisfaction and revenue risk. 
### Project Goal: How do delivery performance and order characteristics affect customer satisfaction?
In order ot get customer feedback, e-commerce companies usually let customers write a review and leave a score of their order experiance. The review score can then effortlessly be used as a way to measure customer satisfaction. 
A few questions were created in order to achive our goal and be more focus on the type of data needed to be analyze. The main qustion was: **Do delivery delays lead to lower customer review scores?**. To help support and answer this question, 
3 more questions were made.
1. Are late deliveries statistically associated with worse reviews?
2. What factors predict long delivery times?
3. Do higher-priced orders get better reviews? 

It is important to keep customers satisfy so that they return and buy from the site, but aslo spend larger amounts in order for revenue to increase. Sellers also need to be content so they too will keep on using
the site to sell their products and keep the businiess operating. Analyzing the data is a critical part in solving these issues. 

## Data Overview
The dataset comes from a Brazilian ecommerce called Olist and can be found here: [Olist_dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data?select=olist_order_items_dataset.csv) The set consists of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and finally reviews written by customers. The set is real commercial data that has been anonymized. The set consits of 9 diffrent tables with a variety of information in each as the diagram that I created shows: 
![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Er_Diagram.png?raw=true)

The raw data was fairly large and messy and needed preping before proper anslysis could be done. 

**Challenges**

- Data dispersed across tables (joins needed)
- Review scores had nulls/missing data
- Inconsistent keys
- Columns had wrong datatype
- Original schema lacked detail
- Similar sounding columns (required description reading)
- Lacked key features needed to perform analysis
- Long time to import data into MySQL

## Data Cleaning/Feature Engineering
After downloading the dataset, I used MySQL to first create the database, then create the tables. An issue arose when trying to import the data into MySQL using the Data Import Wizard feature it was extreamly slow since the dataset was fairly large. In order to solve this problem, I imported the raw CSV data into MySQL using LOAD DATA INFILE which resulted in a faster loading time. The full SQL script for this proccess can be found in the 
  
