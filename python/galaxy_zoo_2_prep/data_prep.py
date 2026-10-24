from pathlib import Path
import pandas as pd

# 1. File Locations
raw_file = Path("C:/Portfolio Projects/galaxy_demographics_morphology_analytics/data/raw/gz2_hart16/gz2_hart16.csv")
project_foler = Path("C:/Portfolio Projects/galaxy_demographics_morphology_analytics")
processed_folder = Path("C:/Portfolio Projects/galaxy_demographics_morphology_analytics/data/processed")

processed_folder.mkdir(parents=True, exist_ok=True)

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

df = pd.read_csv(raw_file, usecols=columns)

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

# 4. Check data-quality rules before saving
fraction_columns = [
    "smooth_fraction",
    "features_or_disk_fraction",
    "spiral_fraction",
    "one_arm_fraction",
    "two_arm_fraction",
]

assert df["galaxy_id"].notna().all(), "Missing galaxy IDs found."
assert df["galaxy_id"].is_unique, "Duplicate galaxy IDs found."
assert df["consensus_class"].notna().all(), "Missing class labels found."

assert (df["classification_count"] > 0).all(), \
    "Non-positive classification counts found."
assert (df["vote_count"] > 0).all(), \
    "Non-positive vote counts found."

for column in fraction_columns:
    invalid = (
        df[column].notna()
        & ((df[column] < 0) | (df[column] > 1))
    )
    assert not invalid.any(), f"Invalid values found in {column}."

# 5. Save the prepared dataset
output_file = processed_folder / "galaxy_morphology_clean.csv"
df.to_csv(output_file, index=False)

# 6. Report what happened
print("--- PREPARED DATASET ---")
print("Rows:", len(df))
print("Columns:", len(df.columns))
print("Duplicate galaxy IDs:", df["galaxy_id"].duplicated().sum())
print("\nMissing values:")
print(df.isna().sum())
print("\nSaved to:", output_file)


