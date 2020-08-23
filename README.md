# gRowing

Repository for practicing EDA, modeling, and cloud computing services. 

Larger projects live in their own repositories:
* [Spotify Playlist Recommender](https://github.com/ZackBarry/infinitePlaylists)
* [Lyrics Scraper and Analyzer](https://github.com/ZackBarry/LyricsScraper_Genius)
* [Finite Difference Methods as a Scala package](https://github.com/ZackBarry/FiniteDifferences)
* [Introduction to Statistical Learning Labs](https://github.com/ZackBarry/Introduction_to_Statistical_Learning)
* [Music Library via applied Data Structures](https://github.com/ZackBarry/MusicPlayer_Frontend)
* [Minesweeper in C++](https://github.com/ZackBarry/Minesweeper_Cpp)
* [Intro to Algorithms Implementations in C++](https://github.com/ZackBarry/Intro_to_Algorithms)

Below is a summary of each of the smaller projects in this repository:

### [stackoverflow_closed](https://github.com/ZackBarry/gRowing/tree/master/stackoverflow_closed)

After working on multiple big data projects at work, I decided I wanted to branch out and learn some new skills on my own. Since all I own is my college laptop from 2013, I knew I had to build my own cluster or use a cloud computing platform. I chose to go with Amazon Web Services (AWS).

In this notebook, Spark ML and Spark Pipelines are used to train a Naive Bayes model for predicting the answer status of a StackOverflow question.  The input data is from a Kaggle Competition: https://www.kaggle.com/c/predict-closed-questions-on-stack-overflow.  

I was surprised to find that instructions for AWS services were sparse and fragmented. Rather than repeat those instructions here, I've written a blog post to pair existing documentation with additional instructions where that documentation is sparse or confusing. The post starts with creating an AWS account and ends with using EMR Spark notebooks to analyze data stored in S3 buckets. Where appropriate, I’ve linked out to existing documentation rather than rewriting those details in this post.

[Link to blog post with AWS guide](https://zackbarry.github.io/blog/2020/aws-startup/)

### [airbnb_nyc](https://github.com/ZackBarry/gRowing/tree/update-descriptions/airbnb_nyc)

My goal with this EDA and model fitting exercise was to practice working with tree-based methods. I thought I'd do some basic EDA, apply some grid searches to XGBoost parameters, and select a final model. The process turned out to be a little more involved than that, and I'm glad it did! My continuous response variable y was log-normal and I chose to transform it so that the models were predicting log(y+1). Because of the transformation, the cross-validation mean squared error value provided by the modeling package (H2O) was the MSE of the log results. However, I wanted to use the CV MSE of y itself. Since H2O's R package doesn't allow for custom error functions, I had to work with the CV datasets directly to get the desired metric.

We were able to use XGBoost to predict rental prices much more effectively than the baseline “naive” model. The baseline model had an MSE of 64000 (RSME of $252). Tuning the learning rate, depth, and L1 regularization parameters of the XGBoost model led to a final MSE value of 51500 (RMSE of $227) and a final R^2 value of 0.2. These results are as good as we might have hoped, especially for a feature as important to the hospitality business as price. XGBoost is, however, one of the most popular non-parametric modeling frameworks so we trust that its results are at least similar to what other packages could provide. The “ideas for improvement” section below suggests some next steps one could take, using this document as a starting point.

Two of the four most important predictors turned out to be whether the room was private or shared. Due to the one-hot encoding, implictly included is whether the room was the entire home or apartment. This makes sense because a shared room is likely to command a significantly lower price than a private room or an entire home/apartment. Longitude and latitude were also important; as we saw in the map in the exploratory analysis section there are regions of NY that are more expensive than others. This geospatial relationship is reflect in the combination of latitude and longitude.

[Link to blog post with published markdown](https://zackbarry.github.io/blog/2020/airbnb-price-prediction/)

### [league_of_legends_classification](https://github.com/ZackBarry/gRowing/tree/master/league_of_legends_classification)

mlr3 is a wonderful object-oriented machine learning package for R; I wanted to write a notebook that included a high level tutorial for mlr3 pipelines.  Section 3.1 contains a walkthrough of how to train a decision tree using mlr3 pipelines. I cover defining "tasks" for train and test, resampling methods for cross-validation, a "learner" for decision tree, and how to combine them all together.  This provides a foundation for the mlr3 Graph Learner I apply in Section 3.2 to run a hyperparameter grid search over several models.

Principal Component Analysis was applied to each teams’ metrics in turn in order to obtain an uncorrelated set of predictors. 7 components were sufficient to explain > 80% of the variance in the data. We pitted Support Vector Machine, Random Forest, and XGBoost against one another using mlr3 Pipelines and found that Support Vector Machine with cost parameter 0.00888, 3 blue team components, and 4 blue team components provided the highest precision on the training set at 73.82%. The test precision using this model was 70.15%. Using such a small cost parameter guards against overfitting; this is shown by the test error being only 5% lower than the cross-validated training error.

[Link to blog post with published markdown](https://zackbarry.github.io/blog/2020/applied-mlr3-pipelines/)

### [graduate_admissions](https://github.com/ZackBarry/gRowing/tree/update-descriptions/graduate_admissions)

My primary goal with this EDA and model fitting exercise was to practice working with dimensionality redacted techniques, specifically Primary Component Analysis. For the dataset I worked with, interpretability of results was a high priority. Thus, I had to make a judgement call as to whether or not the performance improvement of using PCA was worth the reduction in interpretability.

A secondary goal of this document was to practice building recipes for pre-modeling data preparation. In combination with caret, recipes provide an easy way to re-apply data prep stages at each fold in a cross-validation routine. This is important for a method like PCA where the components may be constructed differently for each fold.

The final multiple linear regression model performed quite well with 0.05 MSE, 79% R^2, and apprixately i.i.d. normal residuals. Also, each predictor was statistically significant at an 0.05 alpha level. The most important predictor turned out to be CGPA followed by Letter of Rec, GRE Score, Research, and TOEFL Score. Students should be advised to focus on their coursework above all else. The should, however, attempt to receive a strong letter of recommendation and do well on standardized tests. It was suprising to see that University Ranking and Statement of Purpose were eliminated as part of RFE – people would probably tend to place University Ranking as one of the most important factors.

[Link to blog post with published markdown](https://zackbarry.github.io/blog/2020/graduate-admissions-prediction/)
