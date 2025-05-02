## Local Development

Create a virtual environment and install the required packages. You can use either `venv` or `conda` for this. This is an example using conda:

```cmd
conda create -n dbt-cloud-run python=3.13
conda activate dbt-cloud-run
conda install pip
pip install -r requirements.txt
```

Create a `.env` file in the root directory with the following content:

```env
LOCAL_ENV=true
```
