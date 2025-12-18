-- BigQuery SQL to count POIs by brand and country
-- Tables: carto-do.here.pointsofinterest_pointsofinterest_{ISO3}_latlon_v1_quarterly_v1
-- Countries: USA, GBR, and 27 EU countries
-- Brands: ABC Mart, Adidas, Asics, CCC, Crocs, Deichmann, Footlocker, H&M, JD Sports, Levis, Lululemon, New Balance, Nike, Puma, Snipes, Uniqlo, Zara

WITH all_pois AS (
  -- USA
  SELECT
    'USA' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_usa_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_usa_latlon_v1_quarterly_v1`)

  UNION ALL

  -- GBR
  SELECT
    'GBR' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_gbr_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_gbr_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Austria
  SELECT
    'AUT' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_aut_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_aut_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Belgium
  SELECT
    'BEL' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_bel_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_bel_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Bulgaria
  SELECT
    'BGR' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_bgr_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_bgr_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Croatia
  SELECT
    'HRV' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_hrv_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_hrv_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Cyprus
  SELECT
    'CYP' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_cyp_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_cyp_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Czech Republic
  SELECT
    'CZE' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_cze_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_cze_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Denmark
  SELECT
    'DNK' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_dnk_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_dnk_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Estonia
  SELECT
    'EST' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_est_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_est_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Finland
  SELECT
    'FIN' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_fin_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_fin_latlon_v1_quarterly_v1`)

  UNION ALL

  -- France
  SELECT
    'FRA' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_fra_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_fra_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Germany
  SELECT
    'DEU' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_deu_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_deu_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Greece
  SELECT
    'GRC' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_grc_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_grc_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Hungary
  SELECT
    'HUN' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_hun_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_hun_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Ireland
  SELECT
    'IRL' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_irl_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_irl_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Italy
  SELECT
    'ITA' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_ita_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_ita_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Latvia
  SELECT
    'LVA' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_lva_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_lva_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Lithuania
  SELECT
    'LTU' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_ltu_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_ltu_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Luxembourg
  SELECT
    'LUX' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_lux_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_lux_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Malta
  SELECT
    'MLT' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_mlt_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_mlt_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Netherlands
  SELECT
    'NLD' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_nld_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_nld_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Poland
  SELECT
    'POL' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_pol_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_pol_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Portugal
  SELECT
    'PRT' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_prt_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_prt_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Romania
  SELECT
    'ROU' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_rou_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_rou_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Slovakia
  SELECT
    'SVK' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_svk_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_svk_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Slovenia
  SELECT
    'SVN' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_svn_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_svn_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Spain
  SELECT
    'ESP' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_esp_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_esp_latlon_v1_quarterly_v1`)

  UNION ALL

  -- Sweden
  SELECT
    'SWE' AS country,
    chain_name,
    name_original,
    name_transliteral,
    name_multi,
    do_date
  FROM `carto-do.here.pointsofinterest_pointsofinterest_swe_latlon_v1_quarterly_v1`
  WHERE do_date = (SELECT MAX(do_date) FROM `carto-do.here.pointsofinterest_pointsofinterest_swe_latlon_v1_quarterly_v1`)
),

branded_pois AS (
  SELECT
    country,
    do_date,
    COALESCE(
      -- First try to match chain_name
      CASE
        WHEN UPPER(chain_name) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(chain_name) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(chain_name) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(chain_name) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(chain_name) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(chain_name) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(chain_name) LIKE '%FOOT LOCKER%' OR UPPER(chain_name) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(chain_name) LIKE '%H&M%' OR UPPER(chain_name) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(chain_name) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(chain_name) LIKE '%LEVI%' OR UPPER(chain_name) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(chain_name) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(chain_name) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(chain_name) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(chain_name) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(chain_name) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(chain_name) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(chain_name) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END,
      -- Then try name_original
      CASE
        WHEN UPPER(name_original) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(name_original) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(name_original) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(name_original) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(name_original) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(name_original) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(name_original) LIKE '%FOOT LOCKER%' OR UPPER(name_original) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(name_original) LIKE '%H&M%' OR UPPER(name_original) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(name_original) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(name_original) LIKE '%LEVI%' OR UPPER(name_original) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(name_original) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(name_original) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(name_original) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(name_original) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(name_original) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(name_original) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(name_original) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END,
      -- Then try name_transliteral
      CASE
        WHEN UPPER(name_transliteral) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(name_transliteral) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(name_transliteral) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(name_transliteral) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(name_transliteral) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(name_transliteral) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(name_transliteral) LIKE '%FOOT LOCKER%' OR UPPER(name_transliteral) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(name_transliteral) LIKE '%H&M%' OR UPPER(name_transliteral) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(name_transliteral) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(name_transliteral) LIKE '%LEVI%' OR UPPER(name_transliteral) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(name_transliteral) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(name_transliteral) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(name_transliteral) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(name_transliteral) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(name_transliteral) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(name_transliteral) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(name_transliteral) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END,
      -- Finally try name_multi
      CASE
        WHEN UPPER(name_multi) LIKE '%ABC MART%' THEN 'ABC Mart'
        WHEN UPPER(name_multi) LIKE '%ADIDAS%' THEN 'Adidas'
        WHEN UPPER(name_multi) LIKE '%ASICS%' THEN 'Asics'
        WHEN UPPER(name_multi) LIKE '%CCC%' THEN 'CCC'
        WHEN UPPER(name_multi) LIKE '%CROCS%' THEN 'Crocs'
        WHEN UPPER(name_multi) LIKE '%DEICHMANN%' THEN 'Deichmann'
        WHEN UPPER(name_multi) LIKE '%FOOT LOCKER%' OR UPPER(name_multi) LIKE '%FOOTLOCKER%' THEN 'Footlocker'
        WHEN UPPER(name_multi) LIKE '%H&M%' OR UPPER(name_multi) LIKE '%H & M%' THEN 'H&M'
        WHEN UPPER(name_multi) LIKE '%JD SPORTS%' THEN 'JD Sports'
        WHEN UPPER(name_multi) LIKE '%LEVI%' OR UPPER(name_multi) LIKE '%LEVIS%' THEN 'Levis'
        WHEN UPPER(name_multi) LIKE '%LULULEMON%' THEN 'Lululemon'
        WHEN UPPER(name_multi) LIKE '%NEW BALANCE%' THEN 'New Balance'
        WHEN UPPER(name_multi) LIKE '%NIKE%' THEN 'Nike'
        WHEN UPPER(name_multi) LIKE '%PUMA%' THEN 'Puma'
        WHEN UPPER(name_multi) LIKE '%SNIPES%' THEN 'Snipes'
        WHEN UPPER(name_multi) LIKE '%UNIQLO%' THEN 'Uniqlo'
        WHEN UPPER(name_multi) LIKE '%ZARA%' THEN 'Zara'
        ELSE NULL
      END
    ) AS brand
  FROM all_pois
  WHERE
    -- Filter to only include POIs that match at least one brand
    UPPER(chain_name) LIKE '%ABC MART%' OR
    UPPER(chain_name) LIKE '%ADIDAS%' OR
    UPPER(chain_name) LIKE '%ASICS%' OR
    UPPER(chain_name) LIKE '%CCC%' OR
    UPPER(chain_name) LIKE '%CROCS%' OR
    UPPER(chain_name) LIKE '%DEICHMANN%' OR
    UPPER(chain_name) LIKE '%FOOT LOCKER%' OR UPPER(chain_name) LIKE '%FOOTLOCKER%' OR
    UPPER(chain_name) LIKE '%H&M%' OR UPPER(chain_name) LIKE '%H & M%' OR
    UPPER(chain_name) LIKE '%JD SPORTS%' OR
    UPPER(chain_name) LIKE '%LEVI%' OR UPPER(chain_name) LIKE '%LEVIS%' OR
    UPPER(chain_name) LIKE '%LULULEMON%' OR
    UPPER(chain_name) LIKE '%NEW BALANCE%' OR
    UPPER(chain_name) LIKE '%NIKE%' OR
    UPPER(chain_name) LIKE '%PUMA%' OR
    UPPER(chain_name) LIKE '%SNIPES%' OR
    UPPER(chain_name) LIKE '%UNIQLO%' OR
    UPPER(chain_name) LIKE '%ZARA%' OR
    UPPER(name_original) LIKE '%ABC MART%' OR
    UPPER(name_original) LIKE '%ADIDAS%' OR
    UPPER(name_original) LIKE '%ASICS%' OR
    UPPER(name_original) LIKE '%CCC%' OR
    UPPER(name_original) LIKE '%CROCS%' OR
    UPPER(name_original) LIKE '%DEICHMANN%' OR
    UPPER(name_original) LIKE '%FOOT LOCKER%' OR UPPER(name_original) LIKE '%FOOTLOCKER%' OR
    UPPER(name_original) LIKE '%H&M%' OR UPPER(name_original) LIKE '%H & M%' OR
    UPPER(name_original) LIKE '%JD SPORTS%' OR
    UPPER(name_original) LIKE '%LEVI%' OR UPPER(name_original) LIKE '%LEVIS%' OR
    UPPER(name_original) LIKE '%LULULEMON%' OR
    UPPER(name_original) LIKE '%NEW BALANCE%' OR
    UPPER(name_original) LIKE '%NIKE%' OR
    UPPER(name_original) LIKE '%PUMA%' OR
    UPPER(name_original) LIKE '%SNIPES%' OR
    UPPER(name_original) LIKE '%UNIQLO%' OR
    UPPER(name_original) LIKE '%ZARA%' OR
    UPPER(name_transliteral) LIKE '%ABC MART%' OR
    UPPER(name_transliteral) LIKE '%ADIDAS%' OR
    UPPER(name_transliteral) LIKE '%ASICS%' OR
    UPPER(name_transliteral) LIKE '%CCC%' OR
    UPPER(name_transliteral) LIKE '%CROCS%' OR
    UPPER(name_transliteral) LIKE '%DEICHMANN%' OR
    UPPER(name_transliteral) LIKE '%FOOT LOCKER%' OR UPPER(name_transliteral) LIKE '%FOOTLOCKER%' OR
    UPPER(name_transliteral) LIKE '%H&M%' OR UPPER(name_transliteral) LIKE '%H & M%' OR
    UPPER(name_transliteral) LIKE '%JD SPORTS%' OR
    UPPER(name_transliteral) LIKE '%LEVI%' OR UPPER(name_transliteral) LIKE '%LEVIS%' OR
    UPPER(name_transliteral) LIKE '%LULULEMON%' OR
    UPPER(name_transliteral) LIKE '%NEW BALANCE%' OR
    UPPER(name_transliteral) LIKE '%NIKE%' OR
    UPPER(name_transliteral) LIKE '%PUMA%' OR
    UPPER(name_transliteral) LIKE '%SNIPES%' OR
    UPPER(name_transliteral) LIKE '%UNIQLO%' OR
    UPPER(name_transliteral) LIKE '%ZARA%' OR
    UPPER(name_multi) LIKE '%ABC MART%' OR
    UPPER(name_multi) LIKE '%ADIDAS%' OR
    UPPER(name_multi) LIKE '%ASICS%' OR
    UPPER(name_multi) LIKE '%CCC%' OR
    UPPER(name_multi) LIKE '%CROCS%' OR
    UPPER(name_multi) LIKE '%DEICHMANN%' OR
    UPPER(name_multi) LIKE '%FOOT LOCKER%' OR UPPER(name_multi) LIKE '%FOOTLOCKER%' OR
    UPPER(name_multi) LIKE '%H&M%' OR UPPER(name_multi) LIKE '%H & M%' OR
    UPPER(name_multi) LIKE '%JD SPORTS%' OR
    UPPER(name_multi) LIKE '%LEVI%' OR UPPER(name_multi) LIKE '%LEVIS%' OR
    UPPER(name_multi) LIKE '%LULULEMON%' OR
    UPPER(name_multi) LIKE '%NEW BALANCE%' OR
    UPPER(name_multi) LIKE '%NIKE%' OR
    UPPER(name_multi) LIKE '%PUMA%' OR
    UPPER(name_multi) LIKE '%SNIPES%' OR
    UPPER(name_multi) LIKE '%UNIQLO%' OR
    UPPER(name_multi) LIKE '%ZARA%'
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
