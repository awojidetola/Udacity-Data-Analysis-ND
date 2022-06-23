# We Rate Dogs Project

In this project, the @dog_rates (We Rate Dogs) twitter archive is explored and analyzed. For analysis, three major data sources are used:

- The Enhanced Twitter Archive provided in CSV format
- The Image Prediction dataset used to predict dog breeds
- Data collected from Twitter using Tweepy API

The data was accessed for Quality and Tidiness issues and was cleaned for the same. The three datasets were combined into one master dataset.

Some of the research questions analyzed are:

- What is the most popular source of tweets?
- Which dog stage is the most popular
- What are the top 10 most popular dog breeds predicted by the Neural Network
- For a given dog picture/post, what is the correlation between number of likes and number of retweets.

## File Desciption

+ wrangle_act.ipynb: Jupyter Notebook containing the codes for data wrangling, storing, analysis and visualization
+ wrangle_report.pdf: A report containing the detials of the data wrangling phase
+ twitter_enhanced.csv: The data provided containing basic information about the dog tweets
+ tweet_json.txt: The text file containing the data on the tweets collected using Twitter's api: Tweepy
+ image_prediction.tsv: The data downloaded programmatically containing the predictions of dog breeds using Neural Networks
+ twitter-archive-enhanced.csv: The dataset obtained after combining data from the three data sources:
    + twitter_enhanced.csv
    + tweet_json.txt
    + image_prediction.tsv
    
+ act_report.pdf: Document containing the analysis and visualizations done on the data collected.
