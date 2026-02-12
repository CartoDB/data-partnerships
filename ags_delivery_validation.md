# AGS Delivery Validation

## Overview

This document describes the process for validating that AGS CSV data files delivered to a GCS bucket conform to the expected column layout defined in a Google Sheets specification. The check verifies column names, count, and order while allowing specific columns to be excluded from comparison (e.g., `geoid`, `do_date`).

---

## Prerequisites

- **Google Cloud SDK** authenticated with access to the target GCS bucket
- **Python 3.7+**
- Application Default Credentials configured:

```bash
gcloud auth application-default login
```

Verify access:

```bash
ADC_TOKEN=$(gcloud auth application-default print-access-token)
curl -s -H "Authorization: Bearer $ADC_TOKEN" \
  "https://storage.googleapis.com/storage/v1/b/carto-ext-prov-ags" | python3 -m json.tool
```

---

## Inputs

| Input | Description | Example |
|-------|-------------|---------|
| **GCS folder path** | Bucket path containing delivery subfolders | `gs://carto-ext-prov-ags/walmart/usa/CustomPercentages/2025/07/` |
| **File name suffix** | Pattern to match target CSV files | `walmart_percentages.csv` |
| **Google Sheet URL** | Spreadsheet defining the expected layout | `https://docs.google.com/spreadsheets/d/SHEET_ID/edit?gid=GID#gid=GID` |
| **Excluded columns** | Layout columns to exclude from comparison | `geoid`, `do_date` |

---

## Validation Steps

### Step 1: Download the expected layout from Google Sheets

Export the layout sheet as CSV. The sheet must have a `column_name` column listing every expected variable.

```bash
SHEET_ID="<your-sheet-id>"
GID="<your-gid>"
ADC_TOKEN=$(gcloud auth application-default print-access-token)

curl -s -L \
  "https://docs.google.com/spreadsheets/d/${SHEET_ID}/export?format=csv&gid=${GID}" \
  -H "Authorization: Bearer $ADC_TOKEN" \
  > /tmp/expected_layout.csv
```

Verify download:

```bash
head -5 /tmp/expected_layout.csv
```

### Step 2: Extract expected columns

Parse the `column_name` column and exclude any columns that are not expected in the data files (e.g., `geoid`, `do_date`):

```bash
python3 << 'PYEOF'
import csv

EXCLUDED = {'geoid', 'do_date'}

with open('/tmp/expected_layout.csv', 'r') as f:
    reader = csv.DictReader(f)
    expected_cols = []
    for row in reader:
        col = row['column_name'].strip()
        if col.lower() not in EXCLUDED:
            expected_cols.append(col)

with open('/tmp/expected_columns.txt', 'w') as f:
    for c in expected_cols:
        f.write(c + '\n')

print(f"Expected columns: {len(expected_cols)}")
print(f"First 5: {expected_cols[:5]}")
print(f"Last 3:  {expected_cols[-3:]}")
PYEOF
```

### Step 3: List subfolders and find target CSV files

```bash
ADC_TOKEN=$(gcloud auth application-default print-access-token)
GCS_PREFIX="walmart/usa/CustomPercentages/2025/07/"

# List all objects under the prefix
next_page=""
all_items=""

while true; do
    if [ -z "$next_page" ]; then
        response=$(curl -s -H "Authorization: Bearer $ADC_TOKEN" \
          "https://storage.googleapis.com/storage/v1/b/carto-ext-prov-ags/o?prefix=${GCS_PREFIX}&maxResults=1000")
    else
        response=$(curl -s -H "Authorization: Bearer $ADC_TOKEN" \
          "https://storage.googleapis.com/storage/v1/b/carto-ext-prov-ags/o?prefix=${GCS_PREFIX}&maxResults=1000&pageToken=$next_page")
    fi

    items=$(echo "$response" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for i in data.get('items', []):
    print(i['name'])
" 2>/dev/null)

    all_items="$all_items
$items"

    next_page=$(echo "$response" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('nextPageToken', ''))
" 2>/dev/null)

    if [ -z "$next_page" ]; then break; fi
done

# Filter for target files
echo "$all_items" | grep "walmart_percentages.csv" | sort
```

### Step 4: Download headers and validate

For each matching file, download the first row (header) and compare against the expected columns:

```bash
ADC_TOKEN=$(gcloud auth application-default print-access-token)
FILE_SUFFIX="walmart_percentages.csv"
GCS_PREFIX="walmart/usa/CustomPercentages/2025/07/"

# Collect all matching file paths into an array
mapfile -t FILES < <(echo "$all_items" | grep "$FILE_SUFFIX" | sort)

# Download headers
for file in "${FILES[@]}"; do
    encoded=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$file', safe=''))")
    header=$(curl -s \
      -H "Authorization: Bearer $ADC_TOKEN" \
      -H "Range: bytes=0-5000" \
      "https://storage.googleapis.com/storage/v1/b/carto-ext-prov-ags/o/${encoded}?alt=media" \
      | head -1)
    short_name=$(basename "$file")
    echo "FILE: $short_name"
    echo "HEADER: $header"
    echo "---"
done > /tmp/file_headers.txt
```

### Step 5: Run the comparison

```python
python3 << 'PYEOF'
import csv

# Load expected columns
with open('/tmp/expected_columns.txt', 'r') as f:
    expected_cols = [line.strip() for line in f if line.strip()]

# Parse downloaded headers
with open('/tmp/file_headers.txt', 'r') as f:
    content = f.read()

blocks = content.strip().split('---')
all_pass = True

print(f"Expected layout: {len(expected_cols)} columns")
print(f"{'='*70}")
print(f"VALIDATION RESULTS")
print(f"{'='*70}\n")

for block in blocks:
    block = block.strip()
    if not block:
        continue
    lines = block.split('\n')
    file_name = header_line = None
    for line in lines:
        if line.startswith('FILE: '):
            file_name = line[6:].strip()
        elif line.startswith('HEADER: '):
            header_line = line[8:].strip().rstrip('\r')
    if not file_name or not header_line:
        continue

    actual_cols = [c.strip() for c in header_line.split(',')]
    missing = [c for c in expected_cols if c not in actual_cols]
    extra   = [c for c in actual_cols if c not in expected_cols]
    order_ok = actual_cols == expected_cols

    status = "PASS" if (not missing and not extra and order_ok) else "FAIL"
    if status == "FAIL":
        all_pass = False

    print(f"  {file_name}: {status}  ({len(actual_cols)} cols)")
    if missing:
        print(f"    MISSING: {missing}")
    if extra:
        print(f"    EXTRA:   {extra}")
    if not order_ok and not missing and not extra:
        print(f"    Column ORDER mismatch")
    print()

print(f"{'='*70}")
print("OVERALL:", "ALL PASS" if all_pass else "FAILURES DETECTED")
print(f"{'='*70}")
PYEOF
```

---

## Interpreting Results

| Result | Meaning |
|--------|---------|
| **PASS** | File has all expected columns in the correct order, with no extras |
| **FAIL - MISSING** | File is missing one or more columns from the layout |
| **FAIL - EXTRA** | File contains columns not listed in the layout |
| **FAIL - ORDER** | Columns are present but in a different order than the layout |

---

## Example Validation Output

```
Expected layout: 107 columns
======================================================================
VALIDATION RESULTS
======================================================================

  usa_bl_walmart_percentages.csv: PASS  (107 cols)
  usa_bg_walmart_percentages.csv: PASS  (107 cols)
  usa_bn_walmart_percentages.csv: PASS  (107 cols)
  usa_cb_walmart_percentages.csv: PASS  (107 cols)
  usa_tn_walmart_percentages.csv: PASS  (107 cols)
  usa_tr_walmart_percentages.csv: PASS  (107 cols)
  usa_us_walmart_percentages.csv: PASS  (107 cols)
  usa_cn_walmart_percentages.csv: PASS  (107 cols)
  usa_co_walmart_percentages.csv: PASS  (107 cols)
  usa_h7_walmart_percentages.csv: PASS  (107 cols)
  usa_st_walmart_percentages.csv: PASS  (107 cols)
  usa_zi_walmart_percentages.csv: PASS  (107 cols)

======================================================================
OVERALL: ALL PASS
======================================================================
```

---

## Adapting for Other Datasets

This same process applies to any AGS delivery. Adjust the following parameters:

| Parameter | What to change |
|-----------|----------------|
| `GCS_PREFIX` | Path to the delivery folder in the bucket |
| `FILE_SUFFIX` | File name pattern to match (e.g., `base_currentyear.csv`) |
| `SHEET_ID` / `GID` | Google Sheets document and tab containing the layout |
| `EXCLUDED` | Set of column names to exclude from comparison (e.g., `{'geoid', 'do_date'}`) |

### Bucket structure reference

```
gs://carto-ext-prov-ags/
├── base/usa/{Dataset}/YYYY/MM/{geo_level}/
├── premium/usa/{Dataset}/YYYY/MM/{geo_level}/
└── walmart/usa/{Dataset}/YYYY/MM/{geo_level}/
```

Each `{geo_level}` folder (block, cbg, cbsa, censustract, country, county, h7, state, zipcode) contains one or more CSV files to validate.

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `401 Invalid Credentials` | Run `gcloud auth application-default login` to refresh credentials |
| Spreadsheet export returns HTML | Ensure the sheet is accessible to your Google account; use the auth token in the curl request |
| `0 items` listed in bucket | Verify the prefix path is correct (no trailing typos); check bucket permissions |
| Header line truncated | Increase the `Range` byte limit in the curl request (e.g., `bytes=0-10000`) |
