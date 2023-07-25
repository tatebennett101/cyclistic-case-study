# (from Google's Data Analytics Coursera course)

# **Introduction**

Welcome to the Cyclistic bike-share analysis case study! In this case study, you will perform many real-world tasks of a junior
data analyst. You will work for a fictional company, Cyclistic, and meet different characters and team members. In order to
answer the key business questions, you will follow the steps of the data analysis process: ask, prepare, process, analyze,
share, and act. Along the way, the Case Study Roadmap tables — including guiding questions and key tasks — will help you
stay on the right path.
By the end of this lesson, you will have a portfolio-ready case study. Download the packet and reference the details of this
case study anytime. Then, when you begin your job hunt, your case study will be a tangible way to demonstrate your
knowledge and skills to potential employers.

**Scenario**

You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.

**Characters and teams**

● Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself
apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with
disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about
8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to
commute to work each day.
● Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns
and initiatives to promote the bike-share program. These may include email, social media, and other channels.
● Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and
reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy
learning about Cyclistic’s mission and business goals — as well as how you, as a junior data analyst, can help Cyclistic
achieve them.
● Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the
recommended marketing program.

**About the company**

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.
Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to
do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why
casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are
interested in analyzing the Cyclistic historical bike trip data to identify trends

# **Part 1: Ask**

Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?
Moreno has assigned you the first question to answer: **How do annual members and casual riders use Cyclistic bikes
differently?**

**Deliverables:**

A clear statement of the business task:
- The business task here is to use the given rider data to analyze and visualize how casual riders and annual members of Cyclistic use the bikes differently, and to implement an understanding of these analyses to increase annual membership.

Key stakeholders:
- Lily Moreno (director of marketing)
- Cyclistic executive team


# **Part 2: Prepare**
We will be using Cyclistic's trip data for the previous 12 months from [here](https://divvy-tripdata.s3.amazonaws.com/index.html), provided by Motivate International Inc. [here](https://www.divvybikes.com/data-license-agreement). Within this data set, there are CSVs containing Cyclistic rider data for every month, but we'll be focusing on the past twelve months (July 2022 to June 2023). Some of the data included is ride start-end dates and times, bike type, and rider type (the focus of this case study), to name a few. 

Does the data ROCCC?
- Reliable: the sample sizes are large (n >= 30), and represent all Cyclistic rides within the city of Chicago for the duration that we're studying
- Original: The data is all real and comes from Divvy, a bike-sharing company in Chicago.
- Comprehensive: the data includes extensive information about each ride conducted through the app, like when it started and finished, what stations were used, etc.
- Current: The data goes up to June of 2022
- Cited: It's available under the Data License Agreement.


# **Part 3: Process**
This part of the case study involves ensuring that we can move forward with our analysis without any hiccups. In other words, we need to make sure that the data is formatted uniformly, and that there are no other noticeable errors. 

The tool I will use to process the data is R. The reason I'll be using R is because the data we're working with is large, and R will be able to effectively leverage data sets of such size. The full R script I used to clean the data can be found [here](https://github.com/tatebennett101/cyclistic-case-study/blob/main/cyclistic.R).

# **Part 4: Analyze**

R is also going to be used to analyze the data. The full R script that I used to conduct some data analysis can be found [here](https://github.com/tatebennett101/cyclistic-case-study/blob/main/cyclistic.R). The Excel files I used containing pivot tables to form graphs per month and week can be found [here](https://github.com/tatebennett101/cyclistic-case-study/blob/main/monthly_ride_lengths.xlsx) and [here](https://github.com/tatebennett101/cyclistic-case-study/blob/main/weekly_ride_lengths.xlsx) respectively.

# **Part 5: Share**

Now, let's go over our findings, firstly with the ones that can be found within the R script.

| User Type | Mean | Median | Max | Min |
| --- | --- | --- | --- | --- |
| Casual | 20.48 | 11.97 | 32035.45 | 0.017 |
| Member | 12.06 | 8.55 | 1499.93 | 0.017 |
