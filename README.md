# Brazilian_E-Commerce_Analytics_Project
End-to-end e-commerce analytics project analyzing delivery performance, customer satisfaction, and revenue risk using Python, SQL, statistical modeling, and Power BI.

## Business Problem
Often times e-commerce companies face customer churn driven by delayed deliveries. This project analyzes how delivery performance impacts customer satisfaction and revenue risk. 
### Project Goal: How do delivery performance and order characteristics affect customer satisfaction?
In order ot get customer feedback, e-commerce companies usually let customers write a review and leave a score of their order experiance. The review score can then effortlessly be used as a way to measure customer satisfaction. 
A few questions were created in order to achive our goal and be more focus on the type of data needed to be analyze. The main qustion was: **Do delivery delays lead to lower customer review scores?**. To help support and answer this question, 
3 more questions were made.
1. Are slower deliveries statistically associated with worse reviews?
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

The Key Metrics table highlights quick and useful measurments that executives could use to set goals for the year. 
The total revenue generated within the given time period was around 16 million dollars with a repeat rate of 2.95%. The repeat rate is the percentage of customers who placed more than one order. Stakeholders and other executives can set goals for example raise the repeat rate to 4%, get the numbe of orders to 150,000, and set a goal to get 4,000 new customers or around 95,000 unique customers. They can then look at the new total revenue and see if setting these goals helped earned more. If the same metrics are calcualted over time, patterns can emerge that can lead to higher earnings. 

Simlalry we can look at average delivery days and late delivery rate to see if changes in those effects the average review score. 
Being able to find patters over time using these metrics is what makes them so useful and why it is important to keep track of them. 

<div align="center">

| Figure 1| Figure 2|
|--------|------- |
|![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Score%20by%20Delivery%20Days%20Plt.svg)|![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Percent%20of%20Review%20Score.svg)|
</div>

Referring back to our main question do delivery delays lead to lower customer review scores?, a simple and effective way to find an answer is to plot the average review score of all the orders that took the same amount of days to deliver and plot them. For example get all the orders that took zero days to deliver and find the average review score, get all orders that took 1 day to deliver and find the average review score, and so on and so on. The result is **Figure 1**. 

Key findings: 
1. Orders that took zero days to deliver on average have 5 stars
2. A slight decline in average review score from 5 to around 4 occurs between in the first 20 day time period as expected.
3. **A shap decline in average review score from 4 to around 2 occurs between 20 to 40 days to deilver suggesting that 20 days is the threshold where customers are willing to wait until leaving a negative review**
4. The average review score fluctuates between 2 and 1.5 in the time frame of 40 to 60 days indecating a mild effect on review score(customers were already tired of waiting so they were giving a bad socre anyway). 
5. The data becomes noisy after 60 plus days perhaps due to the few number of orders that took that many days to deliver.


**Figure 2** shows the distribution of review scores across all orders. As mentioned earlier we want to see how diffrent factors affect review score, so it is important to obtain the distribution of review scores and compare it to others in the future. 
Key findings: 
1. About 80% of review scores are "positive" meaning a score of 4 or more. This can help buld trust for sellers and buyers to use our site more as most of the time people buy on good reviews.
2. The third largest review score was 1 making up 10% of a review scores. It would be better to have the distiribution be in descending order with a score of 5 being in the most and 1 being the least. However that is not the case in our data.
3. Scores 3 and 2 make up less than 10% and less than 5% respectively. We could try to set goals in order to lower "bad review scores" (2s and 1s) but more on that later. 



Figure 3            |  Figure 4
:-------------------------:|:-------------------------:
|  ![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/Review%20Score%20by%20Delivery%20Time.svg) | ![](https://github.com/A1jandro-Jimenez/Brazilian-_E-Commerce_Analytics-_Project/blob/main/Pics%20and%20Charts/my_plot.svg) |

Similar to figure 1, **Figure 3** demonstrates the review score by deliver days, however the days are grouped into four different time periods and the boxplot shows distribution and variability within each group rather than just averages. 

Key findings: 
1. **Median review scores decline as delivery duration increases, indicating deteriorating customer satisfaction with slower fulfillment**. Once again we have strong evidence to support that claim that longer deliver days lead to lower customer satisfaction. 
2. Both groups (0-15, and 16-30 days) have a left-skewed distribution meaning the concentration of data points is more towards the higher values (3, 4 and 5) than lower values (1 and 2). As seen before orders who took less than 30 days to deliver seem to get higher scores.
3. The other two groups (31-60, and 60+) have a right-skewed distribution which states that the concentration is more towards the lower values and than high values. Lower score ratings are given more often for these group compared to higer scores.
4. The spread a.k.a the box seems to get taller for longer deliver times suggesting inconsistent customer reactions to delays.
5. Groups (31-60, and 60+) have the bottom of the the box below a score of 3 which means that at least 25% or more of the customers are unsatisfy. A big red flag.




The final figure, **Figure 4**, displays another boxplot this time of the distribution of order values. With this figure it is clear what classifies as a high value order and what falls under a normal or standard amount. A large majority of our orders range from around $10 to $500 dollars. The boxplot displays a lot of orders outside the $500 mark indecating that we do have some orders that we can consider high value. the wiskers also tell us that a lot more orders are of over $100 as the tail is shorter on top than on the bottom so data is skewed towards the higher values. Looking at order values along with review scores can help us answer whether or not high value orders receive better scores. It is important to establish a baseline first before performing further analysis. 

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

There are many factors that can also impact review score, however I decided to focus on two easy but impactful ones which are product type and seller. Earlier in the analysis it was found that after 20 days the average review score declines steeply from 4 to 2 in a twenty day period. Orders that took 30 days to deliver had an average score of 3 which is an acceptable score so it would be ideal to observe the orders with scores lower than 3 which were orders that took more than 30 days. Two groups were created, orders that took 30-60 days and order that took 60 days or more. For each group I looked at the top 5 product categories with the most orders in that group. The results are shown in the tables above. 

Findings: 
- The category that had the most orders in each group was bed_bath_table. One can infer that a lot of the items that fall in this category are large bulk item that require time and care in order to ship espeically across large disances. It is perhaps for these reasons that is why the category has the most orders in both groups.
- Three categories that appear in both groups are bed_bath_table, health_beauty, sports_leisure. We can flag orders from these categories and try to reduce the amount of orders that take longer than 30 days and see how that affects the overall review score.
- Although the average deliver days for all the catergories found were more than 30 days, other factors could contribute to the low ratings. Some other factors to look at is order prices and product quality
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

The tabes above show the top sellers with the most delayed orders and their two highest value orders with review scores of 2 or less. The critiera was created in order to find patterns of why a seller might recive a bad score. Here are some conclusions based on the data found. 
- The two highlighted sellers appear in both groups, 30-60 day group and 60+ days group, indecating that the sellers may have a history of accumlating order that take a long time to deliver. It would be ideal to flag these sellers and perhaps help them find solutions to speed up delivery time.
- The sellers have products in the same categoires that were found earlier like, watches_gift, bed_bath_table, health_beauty, and auto. It further confirms that products in these categories are more likely to take a longer time or be a bad product leading to a low review score. 
- Many of the in both tables have an order value that is above the median and average and are consider "high order value". A combination of high order value, bad product category, and long dilvery time can lead to low review score as these orders demonstarte but may not be the full story.

So far, many of the visuals have suggested that longer delivery times do lead to more negative reviews. It is important to also find statistical evidence for this claim as the more evidence found the more certain we can defend our claim. 

## Statistical Analysis 
One of the supporting questions for this project was, Are slower deliveries statistically associated with worse reviews? In order to answer this question, a Welch’s t-test was used. We want to find if there is a differnce in the mean score of groups, fast vs slow delivery times, and see if this differance is present or just by chance. A Welch's t-test was used because we are looking at the score averages of two groups that are indpendent of each other and both have different sizes and varanice. A Welch's t-test takes into account all of those parameters. The two groups created were orders that took 20 days or less to deliver vs 30 days or more. I used 20 days as a cutoff because exploratory analysis showed customer ratings remain stable up to that point and decline sharply afterward. This threshold reflects both data behavior and realistic delivery expectations, allowing us to quantify the impact of late deliveries. 

### Welch's t-test 
<div align="center">
  
**Hypothesis** 

H<sub>0</sub> : μ<sub>f</sub> = μ<sub>s</sub>

H<sub>a</sub> : μ<sub>f</sub> ≠ μ<sub>s</sub>
</div>

The first step of a t-test is to establish our hypothesis. Here we stated that H<sub>0</sub>: Delivery time has no effect on average rating so both means should be the same. The alternative H<sub>a</sub>: Longer delivery times reduce ratings so both average ratings should be different. We also must establish our significance level for when we can reject the null hypothesis. For this testing I used a typical value of 0.05. Once both the hypothesis and significance level were established, I ran the test using Python with the following code:

```python
fast2 = df3[df3.delivery_days <= 20]["avg_review_score"]
slow2 = df3[df3.delivery_days > 20]["avg_review_score"]
ttest_ind( fast2, slow2, equal_var=False)
```
*TtestResult(statistic=76.02566383124658, pvalue=0.0, df=16651.26446050674)* 


The two main takeaways from the results are:
1. P-value is less than 0.05 so we can reject the null hypothesis that delivery time has no effect on average rating. The difference in customer ratings between fast and slow deliveries is extremely statistically significant, with p-values effectively zero due to large sample size. The p-value appears as zero because it’s below machine precision. This indicates extremely strong evidence against the null hypothesis, which is expected given the large dataset and meaningful difference in delivery performance.
2. The T statistic is a postive value which is expected as when looking at the differnce of average scores (avg.fast - avg.slow) if avg.fast > avg.slow you would expect a postive result which we got.

It was found that there was significant evidence to support our claim, however we want to find out how big is the differance? Confidence intervals can help us answer this question. 
```python
mean_diff = fast.mean() - slow.mean()
se = np.sqrt(fast.var()/len(fast) + slow.var()/len(slow))
ci_low = mean_diff - 1.96 * se
ci_high = mean_diff + 1.96 * se
ci_low, ci_high
```
*(1.1192659244909728, 1.1784582053598458)*

A 95% confidence interval was used. We are 95% confident that fast deliveries receive between 1.12 and 1.18 more stars than slow deliveries. If we repeated this analysis many times, 95% of the intervals would contain the true mean difference.Even accounting for sampling uncertainty, fast deliveries consistently outperform slow deliveries by about one full star, with a narrow confidence show­ing high reliability. 


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

Cohen's d was used to see the effect size of the difference between the two means. It is traditionaly intrpretated that a result of 0.8 or more indicates a large effect that is observable to the naked eye. In our case there is a big obsevable effect as expected. Since there is a small scale of scores (1-5) a one point diffrence is large. For example if a score is around 3 a one point reduction can change it from a "good review" to a "bad review". 

In conclusion, statistical evidence was found to support the claim that on average faster delivery times get a higher review score than slower delivery times. It was found that with 95% confidence faster deliveries receive between 1.12 and 1.18 more stars than slow deliveries. Since scores are measured at a small scale, a 1 point differnce can have a large effect. 

