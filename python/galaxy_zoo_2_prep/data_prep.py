from pathlib import Path
import pandas as pd

df = pd.read_csv("C:/Portfolio Projects/galaxy_demographics_morphology_analytics/data/raw/gz2_hart16/gz2_hart16.csv")
pd.set_option("display.max_columns", None)
# df.head()
# df.info()
# df.describe()
# print(df.describe(include="all"))
# print(df.isnull().sum())
# print(df.dtypes)
# print(df["dr7objid"].nunique())

# print(df.isnull().sum())

# Feature engineering
# 2. Inspected Fields
columns = [
    "dr7objid",
    "gz2_class",
    "total_classifications",
    "total_votes",
    "t01_smooth_or_features_a01_smooth_debiased",
    "t01_smooth_or_features_a02_features_or_disk_debiased",
    "t04_spiral_a08_spiral_debiased",
    "t11_arms_number_a31_1_debiased",
    "t11_arms_number_a32_2_debiased",
]

df = pd.read_csv(Path("C:/Portfolio Projects/galaxy_demographics_morphology_analytics/data/raw/gz2_hart16/gz2_hart16.csv"), usecols=columns)


# 3. Give the fields readable names
df = df.rename(columns={
    "dr7objid": "galaxy_id",
    "gz2_class": "consensus_class",
    "total_classifications": "classification_count",
    "total_votes": "vote_count",
    "t01_smooth_or_features_a01_smooth_debiased": "smooth_fraction",
    "t01_smooth_or_features_a02_features_or_disk_debiased":
        "features_or_disk_fraction",
    "t04_spiral_a08_spiral_debiased": "spiral_fraction",
    "t11_arms_number_a31_1_debiased": "one_arm_fraction",
    "t11_arms_number_a32_2_debiased": "two_arm_fraction",
})

df = df.copy()

labels = ["Low", "Moderate", "High", "Very High"]

df["vote_group"] = pd.qcut(
    df["vote_count"],
    q=4,
    labels=labels
)

df["classification_group"] = pd.qcut(
    df["classification_count"],
    q=4,
    labels=labels
)

print(df[["vote_group", "classification_group"]])
print(df)

df.info()
df.describe()

# Connect via PostreSQL in the kernel
# pip install psycopg2-binary sqlalchemy
from sqlalchemy import create_engine

# After installation Replace placeholders with your actual details
username = "postgres" # default user
password = "2357" # password set during installation
host = "localhost" # if running locally
port = "5432" # default PostgreSQL port
database = "galaxy_morphology" # the database created in pgAdmin

engine = create_engine(f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}")

# Step 2: Load Dataframe into PostgreSQL
table_name = "galaxy" # choose any table name
df.to_sql(table_name, engine, if_exists="replace", index=False)

print(f"Data successfully loaded into table '{table_name}' in database '{database}'.")

# IF PIP DOES NOT INSTALL USE !pip INSTEAD
# Connect via MySQL
# !pip install pymysql sqalchemy
# from sqlalchemy import create_engine

# username = "root" # default user
# password = "your_password" # password set during installation
# host = "localhost" # if running locally
# port = "3306" # default PostgreSQL port
# database = "mydatabase" # the database created in pgAdmin

# engine = create_engine(f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}")

# # Write dataframe to MySQL
# table_name = "mytable" # choose any table name
# df.to_sql(table_name, engine, if_exists="replace", index=False)

# # Read back sample
# pd.read_sql("SELECT * FROM mytable LIMIT 5;", engine)



