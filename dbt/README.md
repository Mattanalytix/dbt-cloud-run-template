Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


## Running Locally

Authenticate with your Google Cloud account and set the project ID:

```cmd
gcloud auth application-default login
gcloud config set project <your-project-id>
```

Set env variables for BigQuery:

```cmd
export DBT_DATASET=<your-dataset>
export DBT_PROJECT=<your-project-id>
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
