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
### SQL for Data Structure Cleaning
After downloading the dataset, I used MySQL to first create the database, then create the tables. An issue arose when trying to import the data into MySQL using the Data Import Wizard feature it was extreamly slow since the dataset was fairly large. In order to solve this problem, I imported the raw CSV data into MySQL using LOAD DATA INFILE which resulted in a faster loading time. The full SQL script for this proccess can be found here: [Creating Database](Creating_Olist_Database.sql). 

Once the tables were imported with the necessary data, I took some time to explore each table and read the description of column to get a more profound understanding of what each table, column, and row truely meant. As mentioned the original schema lacked detailed so it was at this time when I created the er diagram showen the previous section in order to find the relationships between each table. The new diagram allowed me to created the primary and foreign keys much easier as it made it evident where the connections were. 

The Olist dataset contained many orders so performing certain queires could take some time. The best way to speed up run time was to make indexes for the joins. Adding indexes on join keys and frequently filtered columns helped improve query performance before exporting data to other places. Instead of scaning everything when performing a join, it will reference only the already esablish join with the given name making for a much faster run time. The script can be foud here: [Keys & Indexes](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Adding_primary_keys_and_indexes.sql). 

The most important rule to follow when work with data is **you never want to destroy or overwrite raw data**. I used SQL views to create clean, reusable analytical datasets while preserving raw data integrity: [Creating Views](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Creating_Olist_Views.sql). 

A quick recap of each view:

- delivered_orders - Retrieved orders that were delivered and dates were not null
- order_items_agg - Used to find total order vaule and total freight cost for each order
- order_reviews_agg - Got review scores for each order and the last date a review was given
- delivery_metrics - Found days it took to deliver for each order. Found days order was late by. 
- order_analysis - Main view where data from other views was joined into. Established the feature of is_late to orders where delivered date was more than estimated delivery date. Used for data exploration and testing in python. 
  
### Python for Null Removal and Feature Engineering
Before exploring the data, I checked for nulls in Python using isnull function. Afterwards, the rows that had any nulls were removed completely using the dropna function. The dataset was large enough that removing a couple hundred rows still left us with a total of around 95,000 orders to use in our analysis. A few key features were missing in the order analysis view that we added using Python.

Added features:

- total order value - combined both price and frieght cost. 
- days_late - To see how many days late a "late order'' was late. 
- delivery_group - Grouped each order by amount of days it took to deliver order

The file [Python Cleaning and Analysis](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Analysis.html) demonstrates the creation of these features. 

A hybrid of SQL and Python was used to clean and prepare data for analysis. I was able to keep the raw data, join tables together, remove nulls and dulpicates, create features among other things, in order to be able to explore the data easily and as accuarte as possible. 

## Exploratory Data Analysis
All of the data exploring was done in Python and can be found in the file [Python Cleaning and Analysis](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Analysis.html). Copy the file url into this website [Html Rendering Website](https://html-preview.github.io/) to preview the file in its intended form. 
| | Description |
