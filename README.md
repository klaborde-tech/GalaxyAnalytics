# Galaxy Demographics & Morphology Analytics

## Overview

This project explores galaxy morphology and classification participation using data from the **Galaxy Zoo 2 project**. The goal is to demonstrate an end-to-end data analytics workflow, from raw dataset preparation to SQL analysis and interactive data visualization.

Using Python, PostgreSQL/MySQL, and Power BI, the project examines galaxy classification patterns, volunteer participation levels, and morphological features. The analysis also explores hypothetical classification thresholds and their potential to improve the efficiency of crowdsourced classification workflows.

The project combines data analytics with an astronomy-focused dataset to demonstrate practical skills in data cleaning, exploratory analysis, database querying, visualization, and communicating findings.

## Dataset

**Source:** [Galaxy Zoo Data](https://data.galaxyzoo.org/)

The project uses a Galaxy Zoo 2 catalog containing approximately **239,695 galaxy records** and 231 original columns.

The analysis focuses on a selected set of fields, including:

| Column | Description |
|---|---|
| `galaxy_id` | Unique identifier for each galaxy |
| `consensus_class` | Galaxy morphology classification |
| `classification_count` | Number of classifications received |
| `vote_count` | Total recorded votes |
| `smooth_fraction` | Debiased smooth morphology fraction |
| `features_or_disk_fraction` | Debiased features or disk fraction |
| `spiral_fraction` | Debiased spiral morphology fraction |
| `one_arm_fraction` | Debiased one-arm fraction |
| `two_arm_fraction` | Debiased two-arm fraction |

The dataset was reduced to relevant fields for analysis and visualization. Missing values in morphology fields were preserved where they reflected the Galaxy Zoo survey's branching structure rather than assuming that missing values represented zero.

## Tools & Technologies

- **Python:** Data loading, cleaning, feature engineering, and exploratory data analysis.
- **Pandas & NumPy:** Data manipulation and numerical analysis.
- **Matplotlib / Seaborn:** Exploratory data visualization.
- **PostgreSQL / MySQL:** Relational database storage and SQL analysis.
- **pgAdmin 4:** PostgreSQL database management and query execution.
- **Power BI:** Interactive dashboard development and data visualization.
- **Gamma:** Presentation creation and project communication.

## Project Workflow

### 1. Data Loading

- Imported the original Galaxy Zoo 2 dataset into Python.
- Reviewed the dataset structure, column names, and data types.
- Identified relevant fields for the project's analytical objectives.

### 2. Exploratory Data Analysis (EDA)

- Examined dataset dimensions and descriptive statistics.
- Reviewed missing values and unique records.
- Analyzed classification counts and vote distributions.
- Explored the distribution of galaxy morphology categories.
- Investigated relationships between morphology fractions.

### 3. Data Cleaning & Preparation

- Selected relevant columns for the analysis.
- Renamed fields for readability.
- Checked for duplicate galaxy IDs and missing values.
- Validated numerical morphology fractions.
- Created participation groups using classification and vote counts.
- Preserved survey-related missing values instead of automatically replacing them.

### 4. SQL Analysis

- Loaded the prepared dataset into a relational database.
- Used SQL queries to analyze galaxy classifications and participation patterns.
- Applied aggregations, conditional logic, filtering, grouping, and statistical functions.
- Explored hypothetical classification thresholds and participation scenarios.

Key analytical questions included:

- How are galaxies distributed across participation levels?
- How do morphology fractions vary across different participation groups?
- What proportion of galaxies fall into selected morphology categories?
- How would a hypothetical classification cap affect total classification volume?
- How does changing a morphology threshold affect the number of galaxies classified as resolved or unresolved?

### 5. Power BI Dashboard

- Connected Power BI to the prepared database.
- Created KPI cards to summarize key dataset metrics.
- Built charts to explore galaxy morphology distributions.
- Compared morphology fractions across participation groups.
- Developed interactive filters to explore the dataset.

### 6. Reporting & Presentation

- Created a project report documenting the methodology, analysis, findings, and recommendations.
- Developed a presentation using Gamma to communicate the project's objectives and key takeaways.
- Organized the results into a format suitable for technical and non-technical audiences.

## Dashboard

The Power BI dashboard is designed to provide an interactive overview of galaxy morphology and classification participation.

Key dashboard metrics include:

- Total number of galaxies
- Average votes per galaxy
- Average smooth morphology fraction
- Average spiral morphology fraction
- Galaxy morphology category distribution
- Classification participation patterns

**Dashboard screenshots:**

_Add screenshots of your completed Power BI dashboard here._

Example:

```text
dashboard/
├── galaxy_overview.png
├── participation_analysis.png
└── operational_scenarios.png
```

## Results & Key Findings

The analysis covered 239,695 galaxy records and produced several findings:

- **Dataset size:** 239,695 galaxy records with unique galaxy identifiers.
- **Average classifications:** Approximately 42.57 classifications per galaxy.
- **Average votes:** Approximately 179.02 votes per galaxy.
- **Average smooth fraction:** 39.8%.
- **Average features/disk fraction:** 59.2%.
- **Average spiral fraction:** 49.8%.
- **Morphology relationship:** Smooth and spiral fractions showed a negative correlation of approximately -0.555.

The SQL analysis also explored participation distributions, morphology patterns, and hypothetical classification thresholds.

### Recommendations

- **Optimize classification volume:** Evaluate hypothetical classification limits to identify opportunities to reduce unnecessary classification volume while maintaining scientific reliability.
- **Monitor participation patterns:** Use classification and vote distributions to identify galaxies receiving higher levels of participation.
- **Prioritize additional review:** Identify galaxies with less decisive morphology fractions for potential further scientific review.
- **Improve analytical workflows:** Combine participation metrics and morphology measurements to support more informed classification and review processes.

*Note: Classification thresholds explored in this project are analytical scenarios, not validated stopping rules. The available aggregate dataset does not contain individual volunteer histories or classification timestamps, so it cannot directly measure volunteer churn, fatigue, or actual time and cost savings.*

## How to Run

### Prerequisites

Install or have access to:

- Python 3.x
- Jupyter Notebook or Spyder
- PostgreSQL or MySQL
- pgAdmin 4 (for PostgreSQL)
- Power BI Desktop
- Required Python libraries

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
```

### 2. Install Python Dependencies

```bash
pip install pandas numpy matplotlib seaborn sqlalchemy psycopg2-binary
```

If using MySQL, install the appropriate MySQL connector instead of the PostgreSQL driver.

### 3. Download the Dataset

Download the Galaxy Zoo 2 dataset from:

[Galaxy Zoo Data](https://data.galaxyzoo.org/)

Place the dataset in the project's data directory.

### 4. Run the Python Analysis

Open the Python scripts or notebooks and run the data loading, exploratory analysis, cleaning, and preparation steps.

### 5. Set Up the Database

- Create a PostgreSQL or MySQL database.
- Create the required table structure.
- Import the cleaned dataset.
- Update database connection settings in the Python scripts as needed.

### 6. Run SQL Queries

Open the SQL scripts in pgAdmin 4 or your preferred SQL client and execute the analysis queries.

### 7. Open the Power BI Dashboard

Open the `.pbix` file in Power BI Desktop and configure the database connection if necessary.

## Project Structure

```text
Galaxy-Morphology-Analytics/
│
├── data/
│   └── README.md
│
├── python/
│   ├── data_loading.py
│   ├── exploratory_analysis.py
│   └── data_cleaning.py
│
├── sql/
│   ├── database_setup.sql
│   └── analysis_queries.sql
│
├── dashboard/
│   └── galaxy_morphology_dashboard.pbix
│
├── report/
│   └── project_report.pdf
│
├── presentation/
│   └── project_presentation.pdf
│
└── README.md
```

*The folder and file names above are suggested examples. Adjust them to match the actual repository structure.*

## Skills Demonstrated

- Data Loading & Preparation
- Exploratory Data Analysis (EDA)
- Data Cleaning & Validation
- Python Data Analysis
- SQL Querying & Aggregation
- Relational Database Management
- Data Visualization
- Power BI Dashboard Development
- Analytical Reporting
- Data-Driven Recommendations

## Author

**Keaton Laborde**

- [GitHub](https://github.com/klaborde-tech)
- [LinkedIn](https://www.linkedin.com/in/keaton-laborde-610185272/)
- [Portfolio](https://klaborde-tech.github.io/mywebsite/)
