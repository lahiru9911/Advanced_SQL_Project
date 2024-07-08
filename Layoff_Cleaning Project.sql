SHOW TABLES;
SELECT * FROM layoffs;

-- Copy The Data into Temporary Table

CREATE TABLE layoff_st
LIKE layoffs;

SELECT * FROM layoff_st;

INSERT layoff_st
SELECT * FROM layoffs;

-- Remove Duplicates

-- Method 1 ->

WITH dup_cte AS (
    SELECT *, 
           ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country ORDER BY (SELECT NULL)) AS rownum
    FROM layoff_st
)
SELECT * 
FROM dup_cte
WHERE rownum > 1;

-- Method 2 -> 

SELECT DISTINCT company, location, industry, total_laid_off, percentage_laid_off, date, stage, country 
FROM layoff_st;

-- Standadized Data

SELECT company, TRIM(company)
FROM layoff_st
ORDER BY 1;

UPDATE layoff_st
SET company = TRIM(company);

SELECT DISTINCT company
FROM layoff_st
ORDER BY 1;

SELECT * FROM layoff_st;

SELECT DISTINCT industry
FROM layoff_st
ORDER BY 1;

SELECT DISTINCT industry
FROM layoff_st
WHERE industry LIKE 'Crypto%'
ORDER BY 1;

UPDATE layoff_st
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Blank Row

SELECT * FROM layoff_st;

SELECT * FROM layoff_st
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE FROM layoff_st
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoff_st
WHERE industry IS NULL;

DELETE FROM layoff_st
WHERE industry IS NULL;


-- Null value replace using JOIN 

SELECT * 
FROM layoff_st
WHERE company = 'Airbnb';

SELECT * 
FROM layoff_st t1
JOIN layoff_st t2
		ON t1.company = t2.company
        AND t1.location = t2.location
	WHERE t1.industry IS NULL
    AND t2.industry IS NOT NULL;



