SELECT survived, COUNT(*) 
FROM titanics_raw
GROUP BY survived;

SELECT class, survived, COUNT(*) 
FROM titanics_raw
GROUP BY  class, survived
ORDER BY class;
 
SELECT gender, survived, COUNT(*) 
FROM titanics_raw
GROUP BY gender, survived;

SELECT survived, AVG(age) AS avg_age
FROM titanics_raw
GROUP BY survived;

SELECT
    class,
    gender,
    COUNT(*) AS total_children,
    SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) AS survivors,
    ROUND(SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS survival_rate_percent
FROM titanics_raw
WHERE age < 16
GROUP BY class, gender
ORDER BY class, gender;

SELECT
    CASE 
        WHEN country IS NULL OR country = '' THEN 'Unknown'
        ELSE country
    END AS country_group,
    COUNT(*) AS total_passengers,
    SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) AS survivors,
    ROUND(SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS survival_rate_percent
FROM titanics_raw
GROUP BY country_group
ORDER BY survival_rate_percent DESC;

SELECT
    class AS class_tier,
    gender,
    COUNT(*) AS total_passengers,
    SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) AS survivors,
    ROUND(SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS survival_rate_percent
FROM titanics_raw
WHERE class IS NOT NULL
GROUP BY class, gender
ORDER BY class, gender;

SELECT 
    'parent/children',
    COUNT(*) AS total,
    SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) AS survived,
    ROUND(100.0 * SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate_percent
FROM titanics_raw
GROUP BY 'parent/children'
ORDER BY 'parent/children';


SELECT 
    `sibling/spouse`,
    COUNT(*) total,
    SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) survived,
    ROUND(100.0 * SUM(CASE WHEN survived = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate_percent
FROM titanics_raw
GROUP BY `sibling/spouse`
ORDER BY `sibling/spouse`;