# Sign up for AWS


# Load Kaggle data into S3 Bucket
1. Create S3 bucket in desired region.
2. Follow instructions from [here](https://confusedcoders.com/data-engineering/how-to-copy-kaggle-data-to-amazon-s3)
	a. Make sure you save your kaggle API token as `kaggle.json` and not something silly like `kaggle-api-token.json` (the API request will specifically look for `~/.kaggle/kaggle.json`)
	b. If you get a response of `403 - Forbidden` when trying to run `kaggle competitions download -c predict-closed-questions-on-stack-overflow`, make sure you've accepted the terms of the competition.  I was able to trigger the terms page by clicking the "Download All" button next to the API request on the Data tab of the competition page. ([link to github issue with solution](https://github.com/Kaggle/kaggle-api/issues/160#issuecomment-470207569))
3. 
4. 
[https://confusedcoders.com/data-engineering/how-to-copy-kaggle-data-to-amazon-s3](https://confusedcoders.com/data-engineering/how-to-copy-kaggle-data-to-amazon-s3)

If you wanted to load a CSV or other file directly from a url, this SO answer provides a method that requires only a free-tier EC2 instance: [link](https://datascience.stackexchange.com/a/5641).