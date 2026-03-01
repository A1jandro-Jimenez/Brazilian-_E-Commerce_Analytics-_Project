# Brazilian_E-Commerce_Analytics_Project
End-to-end e-commerce analytics project analyzing delivery performance, customer satisfaction, and revenue risk using Python, SQL, statistical modeling, and Power BI.

## Business Problem
Often times e-commerce companies face customer churn driven by delayed deliveries. This project analyzes how delivery performance impacts customer satisfaction and revenue risk. 
### Project Goal: How do delivery performance and order characteristics affect customer satisfaction?
In order to get customer feedback, e-commerce companies usually let customers write a review and leave a score of their order experience. The review score can then effortlessly be used to measure customer satisfaction. 
A few questions were created to achieve our goal and be more focused on the type of data needed to be analyzed. The main question was: **Do delivery delays lead to lower customer review scores?** To help support and answer this question, 
3 more questions were made.
1. Are slower deliveries statistically associated with worse reviews?
2. What factors predict long delivery times?
3. Do higher-priced orders get better reviews? 

It is important to keep customers satisfied so that they return and buy from the site but also spend larger amounts in order for revenue to increase. Sellers also need to be content so they too will keep on using
the site to sell their products and keep the business operating. Analyzing the data is a critical part in solving these issues. 

## Data Overview
The dataset comes from a Brazilian ecommerce called Olist and can be found here: [Olist_dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data?select=olist_order_items_dataset.csv) The set consists of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allow viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and finally reviews written by customers. The set is real commercial data that has been anonymized. The set consists of 9 different tables with a variety of information in each as the diagram that I created shows: 
![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Er_Diagram.png?raw=true)

The raw data was large and messy and needed preparing before proper analysis could be done. 

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
After downloading the dataset, I used MySQL to first create the database, then create the tables. An issue arose when trying to import the data into MySQL using the Data Import Wizard feature it was extremely slow since the dataset was fairly large. In order to solve this problem, I imported the raw CSV data into MySQL using LOAD DATA INFILE which resulted in faster loading time. The full SQL script for this process can be found here: [Creating Database](Creating_Olist_Database.sql). 

Once the tables were imported with the necessary data, I took some time to explore each table and read the description of column to get a more profound understanding of what each table, column, and row truly meant. Since the original schema was not detailed, I created the ER diagram to identify the relationships between tables. The new diagram allowed me to create the primary and foreign keys much easier as it made it evident where the connections were. 

The Olist dataset contained many orders so performing certain queries could take some time. The best way to speed up running time was to make indexes for the joins. Adding indexes on join keys and frequently filtered columns helped improve query performance before exporting data to other places. Instead of scanning everything when performing a join, it will reference only the already established join with the given name making for a much faster run time. The script can be found here: [Keys & Indexes](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Adding_primary_keys_and_indexes.sql). 

The most important rule to follow when working with data is **you never want to destroy or overwrite raw data**. I used SQL views to create clean, reusable analytical datasets while preserving raw data integrity: [Creating Views](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Creating_Olist_Views.sql). 

A quick recap of each view:

- delivered_orders - Retrieved orders that were delivered and dates were not null
- order_items_agg - Used to find total order value and total freight cost for each order
- order_reviews_agg - Got review scores for each order and the last date a review was given
- delivery_metrics - Found days it took to deliver for each order. Found days order was late by. 
- order_analysis - Main view where data from other views was joined into. Established the feature of is_late to orders where delivered date was more than estimated delivery date. Used for data exploration and testing in python. 
  
### Python for Null Removal and Feature Engineering
Before exploring the data, I checked for nulls in Python using isnull function. Afterwards, the rows that had any nulls were removed completely using the dropna function. The dataset was large enough that removing a couple hundred rows still left us with a total of around 95,000 orders to use in our analysis. A few key features were missing in the order analysis view that we added using Python.

Added features:

- total order value - combined both price and freight cost. 
- days_late - To see how many days late a "late order'' was late. 
- delivery_group - Grouped each order by number of days it took to deliver order

The file [Python Cleaning and Analysis](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Analysis.html) demonstrates the creation of these features. 

A hybrid of SQL and Python was used to clean and prepare data for analysis. I was able to keep the raw data, join tables together, remove nulls and duplicates, create features among other things, in order to be able to explore the data easily and as accurate as possible. 

## Exploratory Data Analysis
All of the data exploring was done in Python and can be found in the file [Python Cleaning and Analysis](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Olist_Analysis.html). Copy the file URL into this website [Html Rendering Website](https://html-preview.github.io/) to preview the file in its intended form. 

<div align="center">

### 📊 Key Metrics

| Metric | Value |
|--------|--------|
| Total Orders | 107,812 |                                                
|  Unique Customers| 91,471|
| Total Revenue | $16,377,577.45|
|Avg Order Value  |$151.91 |
|Avg Items per Order|1.39|
| Avg Delivery Days | 12.36|
| Late Delivery Rate | 6.46% |
|Avg Review Score  | 4.08 |
| Median Delivery Day | 10.0 |
| Median Order Value |$ 90.44 |
|Repeat Rate|2.95%|
</div>

The Key Metrics table highlights quick and useful measures that executives could use to set goals for the year. 
The total revenue generated within the given time was around 16 million dollars with a repeat rate of 2.95%. The repeat rate is the percentage of customers who placed more than one order. Stakeholders and other executives can set goals, for example, raise the repeat rate to 4%, increase the number of orders to 150,000, and set a goal to get 4,000 new customers or around 95,000 unique customers. They can then look at the new total revenue and see if setting these goals helped to earn more. If the same metrics are calculated over time, patterns can emerge that can lead to higher earnings. 

Similarly, we can look at average delivery days and late delivery rate to see if changes in those effects the average review score. 
Being able to find patterns over time using these metrics is what makes them so useful and why it is important to keep track of them. 

<div align="center">

| Figure 1| Figure 2|
|--------|------- |
|![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Score%20by%20Delivery%20Days%20Plt.svg)|![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Percent%20of%20Review%20Score.svg)|
</div>

In relation to our primary inquiry: do delays in delivery result in reduced customer review scores? A simple and effective way to find an answer is to plot the average review score of all the orders that took the same numer of days to deliver and plot them. For example, get all the orders that took zero days to deliver and find the average review score, get all orders that took 1 day to deliver and find the average review score, and so on and so on. The result is **Figure 1**. 

Key findings: 
1. Orders that took zero days to deliver on average have 5 stars
2. A slight decline in average review scores from 5 to around 4 occurs between in the first 20-day time period as expected.
3. **A sharp decline in average review score from 4 to around 2 occurs between 20 to 40 days to deliver suggesting that 20 days is the threshold where customers are willing to wait until leaving a negative review**
4. The average review score fluctuates between 2 and 1.5 in the time frame of 40 to 60 days indicating a mild effect on review score (customers were already tired of waiting so they were giving a bad score anyway). 
5. The data becomes noisy after 60 plus, days perhaps due to the few numbers of orders that took that many days to deliver.


**Figure 2** shows the distribution of review scores across all orders. As mentioned earlier,  we want to see how different factors affect review scores, so it is important to obtain the distribution of review scores and compare it to others in the future. 
Key findings: 
1. About 80% of review scores are "positive" meaning a score of 4 or more. This can help build trust for sellers and buyers to use our site more as most of the time people buy on good reviews.
2. The third largest review score was 1 making up 10% of review scores. It would be better to have the distribution be in descending order with a score of 5 being the most and 1 being the least. However, that is not the case in our data.
3. Scores 3 and 2 make up less than 10% and less than 5% respectively. We could try to set goals to lower "bad review scores" (2s and 1s) but more on that later. 



Figure 3            |  Figure 4
:-------------------------:|:-------------------------:
|  ![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Review%20Score%20by%20Delivery%20Time.svg) | ![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/my_plot.svg) |

Like Figure 1, **Figure 3** demonstrates the review score by deliver days, however the days are grouped into four different time periods and the boxplot shows distribution and variability within each group rather than just averages. 

Key findings: 
1. **Median review scores decline as delivery duration increases, indicating deteriorating customer satisfaction with slower fulfillment**. Once again, we have strong evidence to support that claim that longer deliver days lead to lower customer satisfaction. 
2. Both groups (0-15, and 16-30 days) have a left-skewed distribution meaning the concentration of data points is more towards the higher values (3, 4 and 5) than lower values (1 and 2). As seen before, orders who took less than 30 days to deliver seem to get higher scores.
3. The other two groups (31-60, and 60+) have a right-skewed distribution which states that the concentration is more towards the lower values and then high values. Lower score ratings are given more often for this group compared to higher scores.
4. The spread a.k.a the box seems to get taller for longer delivery times, suggesting inconsistent customer reactions to delays.
5. Groups (31-60, and 60+) have the bottom of the box below a score of 3 which means that at least 25% or more of the customers are unsatisfied. A big red flag.




The final figure, **Figure 4**, displays another boxplot this time of the distribution of order values. With this figure it is clear what classifies as a high value order and what falls under a normal or standard amount. A large majority of our orders range from around $10 to $500 dollars. The boxplot displays a lot of orders outside the $500 mark, indicating that we do have some orders that we can consider high value. The whiskers also tell us that a lot more orders are over $100 as the tail is shorter on top than on the bottom so data is skewed towards the higher values. Looking at order values along with review scores can help us answer whether high value orders receive better scores. It is important to establish a baseline first before performing further analysis. 

<div align="center">
  
### Product Analysis for 30-60 Days Group

|Product Category|Delayed Orders|	Avg Delivery Days|Avg Review Score|	Potential Revenue Lost|		
| ----------- | ----------- | ----------- | ----------- | ----------- |
|<mark>bed_bath_table<mark>|419|38.603306|2.094008|$61,101.81|
<mark>health_beauty<mark>|398|38.828235|2.244706|$71,019.17|
<mark>sports_leisure<mark>|321|37.888563|2.255132|$56,521.85|
computers_accessories|302|38.062323|2.271955|$64,268.77|
watches_gifts|287|37.860068|2.334471|$72,374.81|
</div>


<div align="center">

### Product Analysis for 60+ Days Group

|Product Category|Delayed Orders|	Avg Delivery Days|Avg Review Score|	Potential Revenue Lost|		
| ----------- | ----------- | ----------- | ----------- | ----------- |
<mark>bed_bath_table<mark>|29|78.633333|2.416667|	$3,521.63|
furniture_decor|28|88.242424|2.212121|$5,997.27|
auto|22|85.363636|2.409091|$6,302.47|
<mark>health_beauty<mark>	|22|79.409091|2.363636|$4,595.45|
<mark>sports_leisure<mark>|18|88.100000|2.000000|$3,158.41|
</div>

There are many factors that can also impact review score; however, I decided to focus on two easy but impactful ones which are product type and seller. Earlier in the analysis it was found that after 20 days the average review score declines steeply from 4 to 2 in a twenty-day period. Orders that took 30 days to deliver had an average score of 3, which is an acceptable score, so it would be ideal to observe the orders with scores lower than 3 which were orders that took more than 30 days. Two groups were created, orders that took 30-60 days and orders that took 60 days or more. For each group I looked at the top 5 product categories with the most orders in that group. The results are shown in the tables above. 

Findings: 
- The category that had the most orders in each group was bed_bath_table. One can infer that a lot of the items that fall into this category are large bulk items that require time and care to ship, especially across large distances. It is perhaps for these reasons why the category has the most orders in both groups.
- Three categories that appear in both groups are bed_bath_table, health_beauty, sports_leisure. We can flag orders from these categories and try to reduce the number of orders that take longer than 30 days and see how that affects the overall review score.
- Although the average delivery days for all the catergories found were more than 30 days, other factors could contribute to the low ratings. Some other factors to look at are order prices and product quality
  as well. A combination of all three can help further explain the ratings for each. 


<div align="center">
  
### Top 5 Sellers with the most delayed orders (30-60 Days)
|Index|Seller_Id|Product Category|Seller City|Order Value|Delivery Days|Review Score|
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- | -----------|
|1|<mark>7c67e1448b00f6e969d365cea6b010ab<mark>|office_furniture|	itaquaquecetuba|	$3,748.50	|43|1|
1|<mark>7c67e1448b00f6e969d365cea6b010ab<mark>|office_furniture|itaquaquecetuba|$1,529.10	|39|1|
2|4869f7a5dfa277a7dca6462dcf3b52b2| watches_gifts| guariba| $689.00|30| 1|
2|4869f7a5dfa277a7dca6462dcf3b52b2| watches_gifts| guariba|$688.00|32	|1|
3| <mark>4a3ca9315b744ce9f8e9374361493884<mark>| bed_bath_table| ibitinga| $2,768.00|34|1|
3| <mark>4a3ca9315b744ce9f8e9374361493884<mark>| bed_bath_table| ibitinga|$1,493.10|37|	1|
4| 1f50f920176fa81dab994f9023523100| garden_tools| sao jose do rio preto|	$539.10|	32|	2|
4| 1f50f920176fa81dab994f9023523100| garden_tools| sao jose do rio preto|	$485.10	|51|	1|
5| cc419e0650a3c5ba77189a1882b7556a| health_beauty| santo andre	|$89.99	|32	|2|
5| cc419e0650a3c5ba77189a1882b7556a| health_beauty| santo andre	|$89.99|	48|	1|
</div>



<div align="center">
  
### Top 5 Sellers with the most delayed orders (60+ Days)
|Index|Seller_Id|Product Category|Seller City|Order Value|Delivery Days|Review Score|
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- | -----------|
|1|<mark>7c67e1448b00f6e969d365cea6b010ab<mark>|office_furniture|itaquaquecetuba|$719.91|85|1|
|1|<mark>7c67e1448b00f6e969d365cea6b010ab<mark>|office_furniture|itaquaquecetuba|$229.99|72|1|
|2|da8622b14eb17ae2831f4ac5b9dab84a|bed_bath_table|piracicaba|	$169.90|62|1|
|2|da8622b14eb17ae2831f4ac5b9dab84a|bed_bath_table|piracicaba|	$109.90|63|1|
|3|	<mark>4a3ca9315b744ce9f8e9374361493884<mark>|bed_bath_table|ibitinga|$279.90|64|1|
|4|	712e6ed8aa4aa1fa65dab41fed5737e4|	auto|	videira	|$559.00|133|2|
|4|	712e6ed8aa4aa1fa65dab41fed5737e4|	auto|videira|$559.00|61|1|
|5|	e9779976487b77c6d4ac45f75ec7afe9|	food|praia grande	|$177.00|68|1|
|5|	e9779976487b77c6d4ac45f75ec7afe10|drinks|praia grande|$130.00|	68	|1|
</div>

The tables above shows the top sellers with the most delayed orders and their two highest value orders with review scores of 2 or less. The criteria were created to find patterns of why a seller might recive a bad score. Here are some conclusions based on the data found. 
- The two highlighted sellers appear in both groups, 30-60-day group and 60+ days group, indicating that the sellers may have a history of accumulating order that take a long time to deliver. It would be ideal to flag these sellers and perhaps help them find solutions to speed up delivery time.
- The sellers have products in the same categories that were found earlier like, watches_gift, bed_bath_table, health_beauty, and auto. It further confirms that products in these categories are more likely to take a longer time or be a bad products, leading to a low review score. 
- Many of them in both tables have an order value that is above the median and average and are considered "high order value". A combination of high order value, bad product category, and long delivery time can lead to low review score as these orders demonstrate but may not be the full story.

So far, many of the visuals have suggested that longer delivery times do lead to more negative reviews. It is important to also find statistical evidence for this claim as the more evidence found the more certain we can defend our claim. 

## Statistical Analysis 
One of the supporting questions for this project was, are slower deliveries statistically associated with worse reviews? To answer this question, a Welch’s t-test was used. We want to find if there is a difference in the mean score of groups, fast vs slow delivery times, and see if this difference is present or just by chance. A Welch's t-test was used because we are looking at the average scores of two groups that are independent of each other and both have different sizes and variances. A Welch's t-test considers all those parameters. The two groups created were orders that took 20 days or less to deliver vs 30 days or more. I used 20 days as a cutoff because exploratory analysis showed customer ratings remain stable up to that point and decline sharply afterward. This threshold reflects both data behavior and realistic delivery expectations, allowing us to quantify the impact of late deliveries. 

### Welch's t-test 
<div align="center">
  
**Hypothesis** 

H<sub>0</sub> : μ<sub>f</sub> = μ<sub>s</sub>

H<sub>a</sub> : μ<sub>f</sub> ≠ μ<sub>s</sub>
</div>

The first step of a t-test is to establish our hypothesis. Here we stated that H<sub>0</sub>: Delivery time has no effect on average rating so both means should be the same. The alternative H<sub>a</sub>: Longer delivery times reduce ratings so both average ratings should be different. We also must establish our significance level for when we can reject the null hypothesis. For this test, I used a typical value of 0.05. Once both the hypothesis and significance level were established, I ran the test using Python with the following code:

```python
fast2 = df3[df3.delivery_days <= 20]["avg_review_score"]
slow2 = df3[df3.delivery_days > 20]["avg_review_score"]
ttest_ind( fast2, slow2, equal_var=False)
```
*TtestResult(statistic=76.02566383124658, pvalue=0.0, df=16651.26446050674)* 


The two main takeaways from the results are:
1. P-value is less than 0.05 so we can reject the null hypothesis that delivery time has no effect on average rating. The difference in customer ratings between fast and slow deliveries is extremely significant, with p-values effectively zero due to large sample size. The p-value appears as zero because it’s below machine precision. This indicates extremely strong evidence against the null hypothesis, which is expected given the large dataset and meaningful difference in delivery performance.
2. The T statistic is a positive value which is expected as when looking at the difference of average scores (avg.fast - avg.slow) if avg.fast > avg.slow you would expect a positive result which we got.

It was found that there was significant evidence to support our claim, however we want to find out how big  the difference is. Confidence intervals can help us answer this question. 
```python
mean_diff = fast.mean() - slow.mean()
se = np.sqrt(fast.var()/len(fast) + slow.var()/len(slow))
ci_low = mean_diff - 1.96 * se
ci_high = mean_diff + 1.96 * se
ci_low, ci_high
```
*(1.1192659244909728, 1.1784582053598458)*

A 95% confidence interval was used. We are 95% confident that fast deliveries receive between 1.12 and 1.18 more stars than slow deliveries. If we repeated this analysis many times, 95% of the intervals would contain the true mean difference. Even accounting for sampling uncertainty, fast deliveries consistently outperform slow deliveries by about one full star, with  narrow confidence show­ing high reliability. 


```python
def cohens_d(x, y):
    nx, ny = len(x), len(y)
    pooled_std = np.sqrt(
        ((nx - 1)*x.var() + (ny - 1)*y.var()) / (nx + ny - 2)
    )
    return (x.mean() - y.mean()) / pooled_std

cohens_d(fast, slow)
```
*0.9401271970507961* 

Cohen's d was used to see the effect size of the difference between the two means. It is traditionally intrpretated that a result of 0.8 or more indicates a large effect that is observable to the naked eye. In our case there is a big observable effect as expected. Since there is a small scale of scores (1-5) a one-point difference is large. For example, if a score is around 3 a one-point reduction can change it from a "good review" to a "bad review". 

In conclusion, statistical evidence was found to support the claim that on average faster delivery times get a higher review score than slower delivery times. It was found that with 95% confidence faster deliveries receive between 1.12 and 1.18 more stars than slow deliveries. Since scores are measured at a small scale, a 1-point difference can have a large effect. 

## Predictive Modeling
<div align="center">
  
![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/logit_test_olist.png) 

</div>



Logistic regression analysis was performed to examine the influence of delivery days, freight value, order value, number of items, and if an order is late on the variable negative review to predict the value "negative review"(score less than or equal to 2). Logistic regression analysis shows that the model as a whole is significant with a LLR p-value of 0.000 which was found earlier can be due to machine precision. 

<div align="center">
  
| Feature | Odds ratio|
|--------|--------|
|const|0.048381|
|delivery_days|1.032452|
|freight_value|1.000405|
|order_value  |1.000158|
|num_items|1.444045|
|is_late| 7.542064|

</div>

- The coefficient of the variable **delivery_days** is coef = 0.0319, which is positive. This means that an increase in delivery days is associated with an increase in the probability that the dependent variable is "negative review". The p-value of 0.000 indicates that this influence is statistically significant. The odds ratio of 1.032 indicates that each additional delivery day increases the odds of a negative review by 3.2%, holding all other factors constant. +10 days → ~32% higher odds. +30 → ~96% higher odds. Figure 1 and 3 help support this.

  
- The coefficient of the variable **freight_value** is coef = 0.0004, which is just slightly positive. This means that an increase in freight value is associated with a small increase in the probability that the dependent variable is "negative review". However, the p-value of 0.159 indicates that this influence is not statistically significant. The odds ratio of 1.000405 indicates that each additional $1 in shipping cost increases the odds of a negative review by 0.0405%, holding all other factors constant. +$50 → ~2% higher odds. +$100 → ~4% higher odds. Shipping cost matters, but far less than delivery time.


- The coefficient of the variable **order_value** is coef = 0.0002, which is just slightly positive. This means that an increase in order value is associated with a small increase in the probability that the dependent variable is "negative review". The p-value of 0.000 indicates that this influence is statistically significant. The odds ratio of 1.000158 indicates that each additional $1 in order value increases the odds of a negative review by 0.0158% holding all other factors constant. +$100 → ~1.6% higher odds. +$300 → ~4.8% higher odds. Indicates higher expectations for expensive orders.


-  The coefficient of the variable **num_items** is coef = 0.3674, which is positive. This means that an increase in number of items is associated with an increase in the probability that the dependent variable is "negative review". The p-value of 0.000 indicates that this influence is statistically significant. The odds ratio of 1.444045 indicates that each additional item in an order increases the odds of a negative review by 44.4% holding all other factors constant. More items → more chances for damage, missing items, delays.


- The coefficient of the variable **is_late** is coef = 2.0205, which is positive. This means that an order being late is associated with an increase in the probability that the dependent variable is "negative review". The p-value of 0.000 indicates that this influence is statistically significant. The odds ratio of 7.542064 indicates that late deliveries have 7.5× higher odds of receiving a negative review compared to on-time deliveries. Unlike the other variables that depend on an additional unit increase, the is late variable is binary with only two options available, making it the strongest driver in the model.


Late deliveries increase the odds of a negative review by over 7×, making delivery timeliness the single most important driver of customer dissatisfaction. Order complexity and delivery duration further compound this risk, while pricing factors play a secondary role. This Logistic Regression Model can be used to predict the chances of an order being given a negative review aka a score less than or equal to two using all the information mentioned above. 


## Dashboard
<div align="center">
  
![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Olist_Report.png?raw=true)

</div>


A report was created using Power BI to showcase and recap the most valuable findings. In the top area of the report, cards can be found replicating some features found in our KPI table. These measurements will help us track progress towards our goal. We can track the same metrics before and after business recommendation to see if they had a dramatic impact/see if they worked. On the left side the two figures from earlier displaying delivery time and review score can be found. 

They show a clear pattern of review score decreasing as delivery time increases. They also help to see the threshold for when scores begin to change. The right side of the report is focused more on order value. The two charts display where the largest number of orders can be found and their review scores as well. It is important to see where most of the revenue comes from and measure ways to increase it thus the need for the two charts. 

The matrix table displays all the cards' information but broken down into the different states that sellers are from. The map is an extension of the table as it shows the areas where review scores are low (red areas) but also where scores are high (green areas) and everything in between. The bottom visuals are necessary to find factors that need to be improved. Sellers are responsible for the quality of the products, the time it takes for an order to be ready, and their location. These factors play a huge role in delivery time so finding the locations where sellers struggle the most can lead us to find a solution to solve the most common issues. 


## Business Recommendations

The goal for this project was to answer the question **how do delivery performance and order characteristics affect customer satisfaction?** In order to achieve our goal, other sub questions were created. After analyzing and test performing, I was able to find answers to all of them. 

- **Do delivery delays lead to lower customer review scores?** : Yes! From our figures the data shows a clear decline in trend of high review scores, 5 and 4 stars, as delivery time increases.

- **Are slower deliveries statistically associated with worse reviews?** : Yes! From our testing it was found that average review score of the faster delivery time group, orders that take 20 days or less, was statistically different than that of the slower delivery time group, orders that take 20 days or more. The difference was negative indicating that faster average score > than slower average score.

- **What factors predict long delivery times?** & **Do higher-priced orders get better reviews?** Two of the main factors that can predict longer delivery times are type of product purchased and number of items. From the tables, we found that large items that fall under the categories of bed_bath_table, office_furniture, and furniture_decor will typically take the longest to deliver due to them being large heavy and require proper care to be deliver safely. Our model predicted that the number of items in an order has a huge effect when determining if an order will get a negative review. However, that was not the case with order value and cost. An increase in both predicted a slight chance of getting a negative review as customers have higher expectations and are more prone to leave a bad review if they are not met.

### 1. Don't be late! 
Our model predicted that an order classified as late increases the chances of an order recieving a negative review the most. It was found that late orders are 7x more likely to receive a negative review than on time orders. A simple solution is to flag the type of order. For example, for large items that fall into the categories discovered should have expected delivery times that are longer than smaller easier orders. This way customers are told beforehand that their order will take long so no surprises appear and are not upset when they don't receive their order by when it was promised. Another option would be to look at the logistics and find the route that is the fastest to get from seller to customer by cutting down delivery time. 

### 2. 20-30 days 
The model showed that for each additional delivery day, the chances of an order receiving a negative review increase by 3.2%. To decrease those chances, it is best to have most orders if possible, delivered by ideal 20 days but 30 will be acceptable for more complex orders. Delivering orders by 20 days rather than 30 decreases the chance of receiving a negative review by at least 32%. 

### 3. Compensation and incentives
Things happen and not every order will be able to be delivered on time. To have customers return to the site and perhaps leave a better review than they originally planned, is to provide a discount on their next purchase, or maybe some kind of store credit that they can use in the future. It will show that they are appericaited and that we care about their satisfaction. As for sellers, we can offer incentives like getting a small bonus for hitting delivery goals or promoting them more if a certain review score is kept. These small things can help sellers want to get orders out on time and keep using our website and services. 

## Limitations & Next Step
The data used consisted of only orders that had a status of delivered, however the full data set had different status like unavailable, shipped, canceled, among many others. We also excluded orders that did not have a review score or had any information missing. 

Data used for seller analysis focused on delivery time and score but lacked info about product quality. Also, the type of payment people used when ordering was not used but could be an interesting investigation on how that could affect customer satisfaction. 

Some key assumptions of the Welch's t-test were:
- Independence of Observations: Data points in each group are independent, meaning subjects in one group are not related to subjects in the other.
- Normality: The data for each group should be approximately normally distributed.
- Continuous Data: The dependent variable is measured on a continuous scale.
- No Significant Outliers: The groups should not contain extreme outliers that could distort the mean. 

Some key assumptions for binary logistic regression include:
- Binary Dependent Variable: The outcome must be dichotomous (e.g., yes/no, 0/1).
- Independence of Observations: Data points must not be dependent on or matched (e.g., not repeated measures).
- Linearity of Independent Variables and Log Odds: Continuous predictors must have a linear relationship with the logit of the outcome, not necessarily the outcome itself.
- No or Little Multicollinearity: Independent variables should not be highly correlated with each other.
- Large Sample Size: A large sample is needed for maximum likelihood estimation to be reliable. A general rule is at least 10–20 cases of the least frequent outcome per predictor.
- No Extreme Outliers: Extreme outliers can significantly distort model coefficients and predictions. 

What's next?
With more time and more data, it would be ideal to investigate how distance from seller to buyer affects delivery time and satisfaction. Also, a few of the orders had a review comment that was in Portuguese. Reading each comment to see why a person left a certain review score would be a huge clue to what needs to improve to have better customer satisfaction. Lastly, we could break up the orders by year to see what year had the best score and find patterns and trends to see why the other years did not meet up to it. There is a lot of data that can be used to find many outcomes which is a reason I chose to use this data set. It provided real world data that could be used for many cases. 
. 
