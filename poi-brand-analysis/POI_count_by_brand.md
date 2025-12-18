# POI Count by Brand and Country

This document describes how to query Points of Interest (POI) counts by brand and country using different data providers in BigQuery.

## Overview

Count POIs for specific retail brands across multiple countries using CARTO Data Observatory tables. The queries search for brand matches in both the brand/chain field and POI name fields using `LIKE` pattern matching.

## Target Brands

- ABC Mart
- Adidas
- Asics
- CCC
- Crocs
- Deichmann
- Footlocker
- H&M
- JD Sports
- Levis
- Lululemon
- New Balance
- Nike
- Puma
- Snipes
- Uniqlo
- Zara

## Target Countries

- **USA** (US)
- **Great Britain** (GB/GBR)
- **27 EU Countries**: Austria, Belgium, Bulgaria, Croatia, Cyprus, Czech Republic, Denmark, Estonia, Finland, France, Germany, Greece, Hungary, Ireland, Italy, Latvia, Lithuania, Luxembourg, Malta, Netherlands, Poland, Portugal, Romania, Slovakia, Slovenia, Spain, Sweden

---

## Provider 1: HERE

### Table Pattern
```
carto-do.here.pointsofinterest_pointsofinterest_{ISO3}_latlon_v1_quarterly_v1
```

Where `{ISO3}` is the lowercase 3-letter ISO country code (e.g., `usa`, `gbr`, `deu`).

### Relevant Columns
| Column | Description |
|--------|-------------|
| `chain_name` | Brand/chain name |
| `name_original` | Original POI name |
| `name_transliteral` | Transliterated POI name |
| `name_multi` | Multi-language POI name |
| `do_date` | Data Observatory date |

### Query Approach
- Separate tables per country, combined with `UNION ALL`
- Filter by `MAX(do_date)` per table for latest data
- Search across `chain_name`, `name_original`, `name_transliteral`, and `name_multi`

### SQL File
[poi_brand_count_by_country.sql](./poi_brand_count_by_country.sql)

---

## Provider 2: SafeGraph

### Table
```
carto-do.safegraph.pointsofinterest_places_glo_latlon_v3_snapshot_v3
```

Global table containing all countries.

### Relevant Columns
| Column | Description |
|--------|-------------|
| `brands` | Brand name |
| `location_name` | POI name |
| `iso_country_code` | 2-letter ISO country code |
| `do_date` | Data Observatory date |

### Query Approach
- Single global table filtered by `iso_country_code`
- Filter by `MAX(do_date)` for latest data
- Search across `brands` and `location_name`

### SQL File
[poi_brand_count_safegraph.sql](./poi_brand_count_safegraph.sql)

---

## Query Structure

Both queries follow this general pattern:

```sql
WITH filtered_data AS (
  -- Select from source table(s)
  -- Filter by latest do_date
  -- Filter by target countries
),

branded_pois AS (
  SELECT
    country,
    do_date,
    COALESCE(
      -- Match brand in chain/brand column
      CASE WHEN UPPER(brand_column) LIKE '%BRAND%' THEN 'Brand' ... END,
      -- Match brand in name column(s)
      CASE WHEN UPPER(name_column) LIKE '%BRAND%' THEN 'Brand' ... END
    ) AS brand
  FROM filtered_data
  WHERE
    -- Filter rows matching any brand
    UPPER(brand_column) LIKE '%BRAND%' OR
    UPPER(name_column) LIKE '%BRAND%' OR ...
)

SELECT
  country,
  brand,
  COUNT(*) AS poi_count,
  do_date
FROM branded_pois
WHERE brand IS NOT NULL
GROUP BY country, brand, do_date
ORDER BY country, brand;
```

## Brand Matching Notes

- All matching uses `LIKE` with `%` wildcards for partial matching
- Brand names are converted to `UPPER()` for case-insensitive matching
- Special cases:
  - **CCC**: Search for `%CCC%` (not "CCC S.A.")
  - **Footlocker**: Search for both `%FOOT LOCKER%` and `%FOOTLOCKER%`
  - **H&M**: Search for both `%H&M%` and `%H & M%`
  - **Levis**: Search for both `%LEVI%` and `%LEVIS%`

## Output Schema

| Column | Type | Description |
|--------|------|-------------|
| `country` | STRING | ISO country code |
| `brand` | STRING | Standardized brand name |
| `poi_count` | INTEGER | Number of POIs |
| `do_date` | DATE | Data date |
