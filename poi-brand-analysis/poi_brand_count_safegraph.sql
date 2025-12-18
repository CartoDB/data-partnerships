-- BigQuery SQL to count POIs by brand and country from SafeGraph
-- Table: carto-do.safegraph.pointsofinterest_places_glo_latlon_v3_snapshot_v3
-- Countries: USA, GBR, and 27 EU countries
-- Brands: ABC Mart, Adidas, Asics, CCC, Crocs, Deichmann, Footlocker, H&M, JD Sports, Levis, Lululemon, New Balance, Nike, Puma, Snipes, Uniqlo, Zara

WITH latest_data AS (
  SELECT *
  FROM `carto-do.safegraph.pointsofinterest_places_glo_latlon_v3_snapshot_v3`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.safegraph.pointsofinterest_places_glo_latlon_v3_snapshot_v3`)
    AND iso_country_code IN (
      'US',  -- USA
      'GB',  -- Great Britain
      'AT',  -- Austria
      'BE',  -- Belgium
      'BG',  -- Bulgaria
      'HR',  -- Croatia
      'CY',  -- Cyprus
      'CZ',  -- Czech Republic
      'DK',  -- Denmark
      'EE',  -- Estonia
      'FI',  -- Finland
      'FR',  -- France
      'DE',  -- Germany
      'GR',  -- Greece
      'HU',  -- Hungary
      'IE',  -- Ireland
      'IT',  -- Italy
      'LV',  -- Latvia
      'LT',  -- Lithuania
      'LU',  -- Luxembourg
      'MT',  -- Malta
      'NL',  -- Netherlands
      'PL',  -- Poland
      'PT',  -- Portugal
      'RO',  -- Romania
      'SK',  -- Slovakia
      'SI',  -- Slovenia
      'ES',  -- Spain
      'SE'   -- Sweden
    )
),

branded_pois AS (
  SELECT
    iso_country_code AS country,
    do_date,
    COALESCE(
      -- First try to match brands column
      CASE
        WHEN UPPER(brands) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(brands) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(brands) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(brands) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(brands) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(brands) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(brands) LIKE '%FOOT LOCKER%' OR UPPER(brands) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(brands) LIKE '%H&M%' OR UPPER(brands) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(brands) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(brands) LIKE '%LEVI%' OR UPPER(brands) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(brands) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(brands) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(brands) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(brands) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(brands) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(brands) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(brands) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END,
      -- Then try location_name
      CASE
        WHEN UPPER(location_name) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(location_name) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(location_name) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(location_name) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(location_name) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(location_name) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(location_name) LIKE '%FOOT LOCKER%' OR UPPER(location_name) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(location_name) LIKE '%H&M%' OR UPPER(location_name) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(location_name) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(location_name) LIKE '%LEVI%' OR UPPER(location_name) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(location_name) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(location_name) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(location_name) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(location_name) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(location_name) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(location_name) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(location_name) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END
    ) AS brand
  FROM latest_data
  WHERE
    -- Filter to only include POIs that match at least one brand
    UPPER(brands) LIKE '%ABC MART%' OR
    UPPER(brands) LIKE '%ADIDAS%' OR
    UPPER(brands) LIKE '%ASICS%' OR
    UPPER(brands) LIKE '%CCC%' OR
    UPPER(brands) LIKE '%CROCS%' OR
    UPPER(brands) LIKE '%DEICHMANN%' OR
    UPPER(brands) LIKE '%FOOT LOCKER%' OR UPPER(brands) LIKE '%FOOTLOCKER%' OR
    UPPER(brands) LIKE '%H&M%' OR UPPER(brands) LIKE '%H & M%' OR
    UPPER(brands) LIKE '%JD SPORTS%' OR
    UPPER(brands) LIKE '%LEVI%' OR UPPER(brands) LIKE '%LEVIS%' OR
    UPPER(brands) LIKE '%LULULEMON%' OR
    UPPER(brands) LIKE '%NEW BALANCE%' OR
    UPPER(brands) LIKE '%NIKE%' OR
    UPPER(brands) LIKE '%PUMA%' OR
    UPPER(brands) LIKE '%SNIPES%' OR
    UPPER(brands) LIKE '%UNIQLO%' OR
    UPPER(brands) LIKE '%ZARA%' OR
    UPPER(location_name) LIKE '%ABC MART%' OR
    UPPER(location_name) LIKE '%ADIDAS%' OR
    UPPER(location_name) LIKE '%ASICS%' OR
    UPPER(location_name) LIKE '%CCC%' OR
    UPPER(location_name) LIKE '%CROCS%' OR
    UPPER(location_name) LIKE '%DEICHMANN%' OR
    UPPER(location_name) LIKE '%FOOT LOCKER%' OR UPPER(location_name) LIKE '%FOOTLOCKER%' OR
    UPPER(location_name) LIKE '%H&M%' OR UPPER(location_name) LIKE '%H & M%' OR
    UPPER(location_name) LIKE '%JD SPORTS%' OR
    UPPER(location_name) LIKE '%LEVI%' OR UPPER(location_name) LIKE '%LEVIS%' OR
    UPPER(location_name) LIKE '%LULULEMON%' OR
    UPPER(location_name) LIKE '%NEW BALANCE%' OR
    UPPER(location_name) LIKE '%NIKE%' OR
    UPPER(location_name) LIKE '%PUMA%' OR
    UPPER(location_name) LIKE '%SNIPES%' OR
    UPPER(location_name) LIKE '%UNIQLO%' OR
    UPPER(location_name) LIKE '%ZARA%'
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
