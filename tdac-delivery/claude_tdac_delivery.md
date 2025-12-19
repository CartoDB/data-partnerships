# The Data Appeal Company (TDAC) - POI Data Delivery Validation

## Overview

This document defines the expected structure for Data Appeal POI data deliveries to ensure consistency across all future deliveries.

## Delivery Location

**GCS Bucket Pattern:**
```
gs://carto-ext-prov-dataappeal/PO_XXX/YYYY/MM/<COUNTRY_FOLDER>/POI_Data.csv.gz
```

**Country Folder Naming Convention:**
```
DP-POI-<COUNTRYNAME>-<HASH>/
```

Examples:
- `DP-POI-SPAIN-3kam2mkO/`
- `DP-POI-GERMANY-vGx6d8AK/`
- `DP-POI-INDIA-xGoMEZAa/`

## Expected File Format

- **Filename:** `POI_Data.csv.gz`
- **Format:** Gzipped CSV
- **Encoding:** UTF-8

## Expected Schema (29 columns)

All deliveries must contain exactly these 29 columns in this order:

| # | Column Name | Type | Description |
|---|-------------|------|-------------|
| 1 | `poi_id` | STRING | Unique identifier of a POI |
| 2 | `name` | STRING | Name of the POI |
| 3 | `street_address` | STRING | Full street address |
| 4 | `latitude` | FLOAT | Latitude (WGS84, max 7 decimal places) |
| 5 | `longitude` | FLOAT | Longitude (WGS84, max 7 decimal places) |
| 6 | `industry` | STRING | Industry classification (Hospitality, Food & Beverage, Retail...) |
| 7 | `category` | STRING | Category within industry (Hotel, Bar, Restaurant...) |
| 8 | `date_refreshed` | DATE | Date when POI was last updated |
| 9 | `name_translated` | STRING | JSON array of translated names |
| 10 | `country` | STRING | Country name |
| 11 | `state` | STRING | Region or State |
| 12 | `county` | STRING | Province or County |
| 13 | `city` | STRING | City name |
| 14 | `stars` | INTEGER | Star rating (1-5, Hospitality only) |
| 15 | `rooms` | INTEGER | Number of rooms (Hospitality/Short Term Rentals) |
| 16 | `price_class` | INTEGER | Price class 0-4 (Food & Beverage only) |
| 17 | `sentiment` | FLOAT | Customer satisfaction score (1-100) |
| 18 | `popularity` | FLOAT | Popularity score (uncapped) |
| 19 | `hours_popular` | STRING | JSON of popular hours by day of week |
| 20 | `main_clusters` | STRING | JSON array of sentiment by cluster |
| 21 | `most_discussed_topics` | STRING | JSON array of top 5 discussed topics with sentiment |
| 22 | `spoken_languages` | STRING | JSON of top 5 languages with sentiment and percentage |
| 23 | `traveler_origin` | STRING | JSON of top 5 traveler origins (Hospitality only) |
| 24 | `traveler_type` | STRING | JSON of top 5 traveler types (Hospitality only) |
| 25 | `phone` | STRING | Phone number |
| 26 | `website` | STRING | Website URL |
| 27 | `brand_name` | STRING | Brand name |
| 28 | `date_first_presence` | DATE | First digital presence date |
| 29 | `date_closed` | DATE | Date POI was marked as closed |

## Validation Commands

### List all folders in a delivery
```bash
gsutil ls "gs://carto-ext-prov-dataappeal/PO_XXX/YYYY/MM/"
```

### Check schema of a specific file
```bash
gsutil cat "gs://carto-ext-prov-dataappeal/PO_XXX/YYYY/MM/<COUNTRY_FOLDER>/POI_Data.csv.gz" | gunzip | head -1
```

### Expected header output
```
poi_id,name,street_address,latitude,longitude,industry,category,date_refreshed,name_translated,country,state,county,city,stars,rooms,price_class,sentiment,popularity,hours_popular,main_clusters,most_discussed_topics,spoken_languages,traveler_origin,traveler_type,phone,website,brand_name,date_first_presence,date_closed
```

## CARTO Ingestion Notes

When ingested into CARTO, 3 additional columns are added (per V4 Layout specification):

| Column | Description |
|--------|-------------|
| `geoid` | Unique POI identifier (CARTO-generated) |
| `do_date` | Last day of the analysis period |
| `acct_id` | CARTO account unique identifier |

These columns are NOT present in the raw delivery files.

## Reference

- **V4 Layout Specification:** `The Data Appeal Company - Places & Sentiment - POI Data. Layout. V4 - v4.csv`
- **Last Validated Delivery:** PO_648 (December 2025)
