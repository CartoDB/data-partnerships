# Find Variables of Interest Based on Categories of Interest

## Objective

Document the process of identifying relevant AGS (Applied Geographic Solutions) variables for a site selection use case, given specific product categories of interest. This example covers **Athletic Wear**, **Footwear**, and **Baby/Toddler Clothing**.

## Process

### 1. Identify Available Tables

Query the `carto-do.ags` dataset in BigQuery to list all tables matching the desired geography and vintage. In this case, block group level tables with the `blockgroup2022_year_usav1` suffix.

```bash
# Using the BigQuery REST API (if bq CLI has auth issues)
curl -s -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
  "https://bigquery.googleapis.com/bigquery/v2/projects/carto-do/datasets/ags/tables?maxResults=1000" \
  | python3 -c "
import json, sys
data = json.load(sys.stdin)
tables = [t['tableReference']['tableId'] for t in data.get('tables', [])]
matching = [t for t in tables if 'blockgroup2022_year_usav1' in t]
for t in sorted(matching): print(t)
"
```

#### Tables found (27 total)

| Table | Topic |
|---|---|
| `demographics_consumerspending_usa_blockgroup_2022_year_usav1` | Consumer spending (current year) |
| `demographics_consumerspending5yp_usa_blockgroup_2022_year_usav1` | Consumer spending (5-year projection) |
| `demographics_retailpotential_usa_blockgroup_2022_year_usav1` | Retail potential, sales, and gap |
| `demographics_consumerprofiles_usa_blockgroup_2022_year_usav1` | Lifestyle segmentation profiles |
| `demographics_mri_usa_blockgroup_2022_year_usav1` | Recycling behavior (MRI) |
| `demographics_baseageincome_usa_blockgroup_2022_year_usav1` | Age and income demographics |
| `demographics_baseancestry_usa_blockgroup_2022_year_usav1` | Ancestry demographics |
| `demographics_basecensus2010_usa_blockgroup_2022_year_usav1` | Census 2010 base |
| `demographics_basecensus2020_usa_blockgroup_2022_year_usav1` | Census 2020 base |
| `demographics_basecurrentyear_usa_blockgroup_2022_year_usav1` | Current year base demographics |
| `demographics_basenrp_usa_blockgroup_2022_year_usav1` | NRP demographics |
| `demographics_baseprojectedyear_usa_blockgroup_2022_year_usav1` | Projected year base demographics |
| `demographics_basetimeseries_usa_blockgroup_2022_year_usav1` | Time series demographics |
| `demographics_behaviorandattitudes_usa_blockgroup_2022_year_usav1` | Behavior and attitudes |
| `demographics_businesscounts_usa_blockgroup_2022_year_usav1` | Business counts |
| `demographics_businessnaics_usa_blockgroup_2022_year_usav1` | Business NAICS codes |
| `demographics_crimerisk_usa_blockgroup_2022_year_usav1` | Crime risk |
| `demographics_custompercentages_usa_blockgroup_2022_year_usav1` | Custom percentages |
| `demographics_dimensions_usa_blockgroup_2022_year_usav1` | Dimensions |
| `demographics_health_usa_blockgroup_2022_year_usav1` | Health |
| `demographics_healthmdc_usa_blockgroup_2022_year_usav1` | Health MDC |
| `demographics_healthoverview_usa_blockgroup_2022_year_usav1` | Health overview |
| `demographics_income_usa_blockgroup_2022_year_usav1` | Income |
| `demographics_qualityoflife_usa_blockgroup_2022_year_usav1` | Quality of life |
| `demographics_religion_usa_blockgroup_2022_year_usav1` | Religion |
| `demographics_wealth_usa_blockgroup_2022_year_usav1` | Wealth |
| `environmental_climateandweatherrisk_usa_blockgroup_2022_year_usav1` | Climate and weather risk |

### 2. Inspect Table Schemas

For each candidate table, retrieve the column list and descriptions:

```bash
curl -s -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
  "https://bigquery.googleapis.com/bigquery/v2/projects/carto-do/datasets/ags/tables/TABLE_NAME" \
  | python3 -c "
import json, sys
data = json.load(sys.stdin)
for f in data['schema']['fields']:
    print(f['name'], '-', f.get('description', ''))
"
```

### 3. Filter for Relevant Variables

Search column names and descriptions for keywords related to the categories of interest. For Athletic Wear, Footwear, and Baby/Toddler Clothing, the relevant keywords are:

- `sportswear`, `active`, `athletic`
- `footwear`, `shoe`
- `infant`, `baby`, `toddler`, `children`
- `apparel`, `clothing`
- `sporting goods`

## Results: Recommended Tables and Variables

### Table 1: `demographics_consumerspending_usa_blockgroup_2022_year_usav1`

Current-year average household spending (`XCY` prefix) and total area spending (`TCY` prefix). **985 columns.**

#### Athletic Wear Variables

| Column (Avg HH) | Column (Total) | Description |
|---|---|---|
| `XCYAPP0109` | `TCYAPP0109` | Men's Active Sportswear |
| `XCYAPP0306` | `TCYAPP0306` | Women's Active Sportswear |
| `XCYAPP0209` | `TCYAPP0209` | Boys' Sportswear |
| `XCYAPP0405` | `TCYAPP0405` | Girls' Shorts and Sportswear |

#### Footwear Variables

| Column (Avg HH) | Column (Total) | Description |
|---|---|---|
| `XCYAPP06` | `TCYAPP06` | Footwear (total) |
| `XCYAPP0601` | `TCYAPP0601` | Men's Footwear |
| `XCYAPP0602` | `TCYAPP0602` | Boys' Footwear |
| `XCYAPP0603` | `TCYAPP0603` | Girls' Footwear |
| `XCYAPP0604` | `TCYAPP0604` | Women's Footwear |
| `XCYAPP0605` | `TCYAPP0605` | Gifts of Footwear |

#### Baby/Toddler Clothing Variables

| Column (Avg HH) | Column (Total) | Description |
|---|---|---|
| `XCYAPP05` | `TCYAPP05` | Infant's Apparel (total) |
| `XCYAPP0501` | `TCYAPP0501` | Infant Coat/Jacket |
| `XCYAPP0502` | `TCYAPP0502` | Infant Dresses/Outerwear |
| `XCYAPP0503` | `TCYAPP0503` | Infant Underwear |
| `XCYAPP0504` | `TCYAPP0504` | Infant Nightwear |
| `XCYAPP0505` | `TCYAPP0505` | Infant Accessories |
| `XCYAPP0506` | `TCYAPP0506` | Infant Gifts |

#### Supporting Context Variables

| Column (Avg HH) | Column (Total) | Description |
|---|---|---|
| `XCYAPP` | `TCYAPP` | Total Apparel Spending |
| `XCYAPP04` | `TCYAPP04` | Girl's Apparel (children's clothing) |
| `XCYENT05` | `TCYENT05` | Recreational Equipment and Supplies |
| `XCYENT0503` | `TCYENT0503` | Exercise Equipment |
| `XCYENT0102` | `TCYENT0102` | Participant Sports Fees |

---

### Table 2: `demographics_retailpotential_usa_blockgroup_2022_year_usav1`

Retail demand (`MLTCY`), actual retail sales (`RSSCY`), and retail gap/leakage (`RSGCY`) by NAICS store type. **196 columns.**

A **positive `RSGCY` value** indicates spending leakage — residents are spending money outside the area, representing an opportunity for a new store.

| NAICS | MLTCY (Demand) | RSSCY (Sales) | RSGCY (Gap) | Store Type |
|---|---|---|---|---|
| 44813 | `MLTCY44813` | `RSSCY44813` | `RSGCY44813` | Children's & Infant's Clothing Stores |
| 44814 | `MLTCY44814` | `RSSCY44814` | `RSGCY44814` | Family Clothing Stores |
| 44821 | `MLTCY44821` | `RSSCY44821` | `RSGCY44821` | Shoe Stores |
| 45111 | `MLTCY45111` | `RSSCY45111` | `RSGCY45111` | Sporting Goods Stores |
| 44811 | `MLTCY44811` | `RSSCY44811` | `RSGCY44811` | Men's Clothing Stores |
| 44812 | `MLTCY44812` | `RSSCY44812` | `RSGCY44812` | Women's Clothing Stores |
| 44815 | `MLTCY44815` | `RSSCY44815` | `RSGCY44815` | Clothing Accessory Stores |
| 44819 | `MLTCY44819` | `RSSCY44819` | `RSGCY44819` | Other Apparel Stores |

---

### Table 3: `demographics_consumerspending5yp_usa_blockgroup_2022_year_usav1`

Same structure as Table 1 but with **5-year projected** spending. Uses `XPY`/`TPY` prefix instead of `XCY`/`TCY`. All the same variable codes apply. Useful for understanding spending growth trends in the target categories.

---

### Tables Not Relevant to This Use Case

| Table | Reason |
|---|---|
| `demographics_consumerprofiles` | Lifestyle segmentation (68 segments); no product-level spending data |
| `demographics_mri` | Recycling behavior only |
| Remaining 22 tables | Cover health, crime, religion, income, ancestry, etc. — not directly related to product categories, though `basecurrentyear` and `income` can provide supporting demographic context |

## Recommended Site Selection Approach

Combine variables from the consumer spending and retail potential tables by block group to build a composite score:

1. **Demand Score**: Sum total area spending for target categories
   ```sql
   TCYAPP0109 + TCYAPP0306 + TCYAPP0209 + TCYAPP0405  -- Athletic wear
   + TCYAPP06                                           -- Footwear
   + TCYAPP05                                           -- Infant apparel
   ```

2. **Unmet Demand (Gap)**: Identify areas where residents spend more than local stores capture
   ```sql
   RSGCY44821  -- Shoe store gap
   + RSGCY45111  -- Sporting goods gap
   + RSGCY44813  -- Children's clothing gap
   ```

3. **Growth Potential**: Compare current year (`TCY`) vs 5-year projection (`TPY`) totals for the same categories to identify areas with increasing demand.
