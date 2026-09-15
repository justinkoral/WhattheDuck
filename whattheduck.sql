SELECT * FROM read_csv_auto('/Users/vanta/Projects/duckdb/whattheduck/pnas.2023170118.sd01.csv');

CREATE TABLE ducks_ina_row AS SELECT * FROM read_csv_auto('/Users/vanta/Projects/duckdb/whattheduck/pnas.2023170118.sd01.csv');

SUMMARIZE ducks_ina_row;

SELECT COUNT(*) AS anatidae_count FROM ducks_ina_row WHERE "Family" ILIKE '%Anatidae%';

SELECT * FROM ducks_ina_row WHERE "Family" ILIKE '%Anatidae%';

SELECT 
    MIN("Abundance estimate") AS min_abundance,
    ROUND(AVG("Abundance estimate"), 0) AS avg_abundance,
    MAX("Abundance estimate") AS max_abundance,
    SUM("Abundance estimate") AS total_anatidae_population
FROM ducks_ina_row
WHERE "Family" ILIKE '%Anatidae%';

SELECT 
    "Training species", 
    "Range adjusted",
    COUNT(*) AS species_count,
    SUM("Abundance estimate") AS total_abundance
FROM ducks_ina_row
WHERE "Family" ILIKE '%Anatidae%'
GROUP BY ALL;

SELECT 
    "Common name",
    "Scientific name",
    "Abundance estimate",
    CASE 
        WHEN "Abundance estimate" > 10000000 THEN 'Extremely Abundant (>10M)'
        WHEN "Abundance estimate" BETWEEN 100000 AND 10000000 THEN 'Moderate (100k - 10M)'
        ELSE 'Rare / Threatened (<100k)'
    END AS abundance_tier
FROM ducks_ina_row
WHERE "Family" ILIKE '%Anatidae%'
ORDER BY "Abundance estimate" DESC;