# AGS Data Comparison Guide

## Overview

This guide provides instructions for comparing AGS data from the Google Cloud Storage (GCS) bucket with existing dataset layouts stored in Google Drive/Google Sheets.

---

## Table of Contents

1. [Data Locations](#data-locations)
2. [Prerequisites](#prerequisites)
3. [Understanding the Data](#understanding-the-data)
4. [Comparison Methods](#comparison-methods)
5. [Step-by-Step Instructions](#step-by-step-instructions)
6. [Analysis & Reporting](#analysis--reporting)
7. [Troubleshooting](#troubleshooting)

---

## Data Locations

### GCS Bucket Structure

```
gs://carto-ext-prov-ags/
├── base/
│   ├── usa/
│   │   ├── BaseCurrentYear/2025/07/block/
│   │   ├── BaseCensus2020/2025/07/block/
│   │   ├── BaseCensus2010/2025/07/block/
│   │   ├── BaseTimeSeries/2025/07/block/
│   │   ├── BaseNRP/2025/07/block/
│   │   ├── BaseAncestry/2025/07/block/
│   │   ├── BaseProjectedYear/2025/07/block/
│   │   └── BaseAgeIncome/2025/07/block/
│   └── mex/
│       └── BaseCensus2020/2025/07/blockgroup/
├── premium/
│   └── usa/
│       ├── PremiumRetail/2025/07/block/
│       ├── PremiumCrimeRisk/2025/07/block/
│       ├── PremiumEnvironment/2025/07/block/
│       ├── PremiumCEX/2025/07/block/
│       ├── PremiumPanorama/2025/07/block/
│       ├── PremiumBusiness/2025/07/block/
│       ├── PremiumQOLI/2025/07/block/
│       ├── PremiumHealth/2025/07/block/
│       ├── PremiumHHDFinances/2025/07/block/
│       ├── PremiumHealthOverview/2025/07/block/
│       ├── PremiumIncome/2025/07/block/
│       ├── PremiumReligion/2025/07/block/
│       ├── PremiumHealthMDC/2025/07/block/
│       ├── PremiumDimensions/2025/07/block/
│       ├── PremiumCEXProjected/2025/07/block/
│       ├── PremiumBusinessNAICS/2025/07/block/
│       └── PremiumBAT/2025/07/block/
└── walmart/
    └── usa/
        └── CustomPercentages/2025/07/block/
```

### File Types in Each Dataset Directory

Each dataset directory contains:
- `*-dictionary.csv` - Variable/column definitions and metadata
- `*.csv` - Actual data file with records

Example:
```
gs://carto-ext-prov-ags/base/usa/BaseCurrentYear/2025/07/block/
├── usa_bl_base_currentyear-dictionary.csv
└── usa_bl_base_currentyear.csv
```

### Google Drive Layout Locations

Dataset layouts are documented in Google Sheets with similar naming conventions:
- Each dataset has a corresponding Google Sheet in the Drive folder
- Multiple version tabs (e.g., v2025a, v2024b) - use the latest version
- Contains columns: `column_name`, `column_description`, and other metadata

---

## Prerequisites

### Required Tools

1. **Google Cloud SDK (gcloud)**
   ```bash
   which gcloud
   gcloud auth list
   ```

2. **gsutil** (included with Google Cloud SDK)
   ```bash
   gsutil --version
   ```

3. **Python 3.7+**
   ```bash
   python3 --version
   ```

4. **Required Python Libraries**
   ```bash
   pip3 install google-cloud-storage google-api-python-client
   ```

### Authentication

Authenticate with Google Cloud:
```bash
gcloud auth login --update-adc
gcloud auth application-default login
```

Verify access:
```bash
gsutil ls gs://carto-ext-prov-ags/
```

---

## Understanding the Data

### Data Dictionary (CSV Files)

The `*-dictionary.csv` file contains metadata for each variable:

| Column | Purpose | Example |
|--------|---------|---------|
| VARIABLE | Variable code/name | `POPCY`, `AGECY0004` |
| DESCRIPTION | Human-readable description | `Total Population Current Year` |
| UNIT | Measurement unit | `Count`, `Percentage` |
| TYPE | Data type | `Integer`, `Float` |
| AGGREGATION_TYPE | How data aggregates | `SUM`, `AVERAGE` |
| VINTAGE | Year/version | `2020`, `Current` |

### Data Files (CSV)

The data file contains:
- Header row with all column names
- Data rows with actual values
- Geospatial identifier (GEOID for USA blocks)

---

## Comparison Methods

### Method 1: Variable/Column Comparison (Recommended for Quick Analysis)

**Objective:** Compare column names between dictionary and layout

**Process:**
1. Extract `VARIABLE` column from dictionary.csv
2. Extract `column_name` column from Google Sheet layout
3. Identify new columns (in dictionary, not in layout)
4. Identify removed columns (in layout, not in dictionary)

**Output:**
- Lists of new and removed columns
- Count of changes per dataset

### Method 2: Detailed Schema Comparison

**Objective:** Compare column attributes (type, description, aggregation)

**Process:**
1. Parse dictionary.csv with all metadata
2. Compare with layout sheet including column descriptions
3. Flag differences in data types, descriptions, units
4. Document deprecated/new fields

**Output:**
- Detailed change log with metadata
- Impact analysis per column

### Method 3: Data Validation Comparison

**Objective:** Verify data consistency between versions

**Process:**
1. Download both data files
2. Compare row counts and value distributions
3. Check for NULL/missing values
4. Validate key identifiers (GEOID)

**Output:**
- Data quality report
- Record count changes
- Value distribution analysis

---

## Step-by-Step Instructions

### Step 1: Set Up Environment

```bash
# Navigate to your working directory
cd ~/Documents

# Create a working directory
mkdir ags-comparison
cd ags-comparison

# Authenticate with GCP
gcloud auth login --update-adc
```

### Step 2: Download Dictionary Files

#### Option A: Using gsutil (for single dataset)

```bash
# Download BaseCurrentYear dictionary
gsutil cp gs://carto-ext-prov-ags/base/usa/BaseCurrentYear/2025/07/block/usa_bl_base_currentyear-dictionary.csv .

# Download the data file
gsutil cp gs://carto-ext-prov-ags/base/usa/BaseCurrentYear/2025/07/block/usa_bl_base_currentyear.csv .
```

#### Option B: Batch Download (all datasets)

```bash
# Create directory structure
mkdir -p dictionaries data

# Download all dictionaries
gsutil -m cp gs://carto-ext-prov-ags/base/usa/*/2025/07/block/*-dictionary.csv dictionaries/
gsutil -m cp gs://carto-ext-prov-ags/premium/usa/*/2025/07/block/*-dictionary.csv dictionaries/
gsutil -m cp gs://carto-ext-prov-ags/walmart/usa/*/2025/07/block/*-dictionary.csv dictionaries/
```

### Step 3: Access Google Sheets Layout

**Method A: Export as CSV**
1. Open the Google Sheet for your dataset
2. Click File → Download → Comma-separated values (.csv)
3. Save to `layouts/` directory

**Method B: Direct URL (if sheet is public)**
```bash
# Sheet ID extracted from URL
SHEET_ID="1zodRT5X7OP0BfQ4i4kdItV5LD4U76l24zDmvZGqu9-w"

# Export as CSV
curl -L "https://docs.google.com/spreadsheets/d/${SHEET_ID}/export?format=csv" > layout.csv
```

### Step 4: Compare Using Python Script

Create `compare_datasets.py`:

```python
import csv
import sys

def extract_variables(dict_file):
    """Extract VARIABLE column from dictionary CSV"""
    variables = []
    with open(dict_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if 'VARIABLE' in row and row['VARIABLE']:
                variables.append(row['VARIABLE'])
    return variables

def extract_columns(layout_file):
    """Extract column_name from layout CSV"""
    columns = []
    with open(layout_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            col = row.get('column_name', '').strip()
            if col and col.lower() not in ['geoid', 'do_date']:
                columns.append(col)
    return columns

def compare(dict_file, layout_file, dataset_name):
    """Compare dictionary and layout"""
    variables = extract_variables(dict_file)
    columns = extract_columns(layout_file)

    dict_set = set(variables)
    layout_set = set(columns)

    new_cols = dict_set - layout_set
    removed_cols = layout_set - dict_set

    print(f"\n{'='*70}")
    print(f"Dataset: {dataset_name}")
    print(f"{'='*70}")
    print(f"Dictionary variables: {len(variables)}")
    print(f"Layout columns: {len(columns)}")
    print(f"\nNew columns ({len(new_cols)}):")
    for col in sorted(new_cols):
        print(f"  + {col}")
    print(f"\nRemoved columns ({len(removed_cols)}):")
    for col in sorted(removed_cols):
        print(f"  - {col}")

# Usage
if __name__ == '__main__':
    dict_file = sys.argv[1]
    layout_file = sys.argv[2]
    dataset_name = sys.argv[3] if len(sys.argv) > 3 else "Dataset"

    compare(dict_file, layout_file, dataset_name)
```

Run comparison:
```bash
python3 compare_datasets.py \
  dictionaries/usa_bl_base_currentyear-dictionary.csv \
  layouts/BaseCurrentYear.csv \
  "BaseCurrentYear"
```

### Step 5: Examine Specific Columns

#### View Dictionary Entry for a Column

```bash
# Extract column information
grep "POPCY" usa_bl_base_currentyear-dictionary.csv
```

#### Check Data File Structure

```bash
# View first row (headers)
head -1 usa_bl_base_currentyear.csv | tr ',' '\n' | nl

# View first few data rows
head -5 usa_bl_base_currentyear.csv | cut -d',' -f1-10
```

---

## Analysis & Reporting

### Generate Comparison Report

```bash
python3 << 'EOF'
import json
import csv

results = {}

datasets = [
    ("BaseCurrentYear", "dict/currentyear-dict.csv", "layouts/currentyear.csv"),
    # Add more datasets...
]

for name, dict_file, layout_file in datasets:
    # Compare logic here
    results[name] = {
        "new_columns": [],
        "removed_columns": []
    }

# Save report
with open('comparison_report.json', 'w') as f:
    json.dump(results, f, indent=2)

print("Report saved to comparison_report.json")
EOF
```

### Create CSV Summary

```bash
python3 << 'EOF'
import csv
import json

with open('comparison_report.json', 'r') as f:
    data = json.load(f)

with open('comparison_summary.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['Dataset', 'New Columns', 'Removed Columns'])
    writer.writeheader()

    for dataset, changes in data.items():
        writer.writerow({
            'Dataset': dataset,
            'New Columns': '; '.join(changes['new_columns']),
            'Removed Columns': '; '.join(changes['removed_columns'])
        })

print("Summary saved to comparison_summary.csv")
EOF
```

---

## Troubleshooting

### Issue: Authentication Failures

**Error:** `Request had insufficient authentication scopes`

**Solution:**
```bash
# Re-authenticate with proper scopes
gcloud auth application-default login

# Or use service account if available
gcloud auth activate-service-account --key-file=path/to/key.json
```

### Issue: Cannot Access Google Sheets

**Error:** `HTTP 403 Forbidden` or `AccessDenied`

**Solution:**
1. Verify sheet is shared publicly or with your email
2. Use direct CSV export instead of API
3. Ask sheet owner for access

### Issue: File Not Found in GCS

**Error:** `CommandException: One or more URLs matched no objects`

**Solution:**
```bash
# Verify path exists
gsutil ls gs://carto-ext-prov-ags/base/usa/

# Check exact dataset name
gsutil ls gs://carto-ext-prov-ags/base/usa/BaseCurrentYear/2025/07/block/
```

### Issue: Large File Download Timeout

**Solution:**
```bash
# Use gsutil with retries and parallel downloads
gsutil -m -D cp gs://carto-ext-prov-ags/premium/usa/PremiumCEX/2025/07/block/*.csv .

# Or download with timeout
timeout 300 gsutil cp gs://carto-ext-prov-ags/.../large-file.csv .
```

---

## Common Findings & Patterns

### Consistent Patterns Across Datasets

| Pattern | Observation | Count |
|---------|------------|-------|
| ID column removed | Appears in layout but not in dictionary | 26/26 |
| Household statistics | Removed from Census datasets | 2 |
| New metrics | PremiumBAT added SDLIFE011 | 1 |

### Dataset-Specific Notes

**BaseCensus2020 & BaseCensus2010**
- Removed household income/value statistics
- May be calculated or deprecated fields
- Investigate if these should be re-added

**PremiumBAT**
- Only dataset with column additions
- New SDLIFE011 variable for lifestyle demographics
- Verify this is intentional update

---

## Reference Data

### Sample Dataset: BaseCurrentYear

**Location:** `gs://carto-ext-prov-ags/base/usa/BaseCurrentYear/2025/07/block/`

**Statistics:**
- Columns: 596
- Variables in Dictionary: 595
- Removed: ID (layout only)

**Major Categories:**
- Demographics (age, race, ethnicity)
- Household composition
- Education, employment, income
- Housing characteristics
- Business/industry data
- Retail spending patterns

### All 26 Datasets

See `comparison_results.csv` for full comparison across all datasets.

---

## Additional Resources

- [Google Cloud Storage Documentation](https://cloud.google.com/storage/docs)
- [gsutil Command Reference](https://cloud.google.com/storage/docs/gsutil)
- [Google Sheets API Documentation](https://developers.google.com/sheets/api)
- [Python CSV Module](https://docs.python.org/3/library/csv.html)

---

## Contact & Support

For issues or questions:
1. Check this guide's Troubleshooting section
2. Verify GCP credentials: `gcloud auth list`
3. Check file permissions: `gsutil acl ch -u USER gs://bucket`
4. Review comparison logs in `~/Documents/ags-comparison/`

---

**Last Updated:** 2025-12-30
**Version:** 1.0
**Status:** Active
