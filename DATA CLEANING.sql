-- DATA Cleaning

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values and blank values
-- 4. Remove Any Columns


CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, 
funds_raised_millions) row_num
FROM layoffs_staging;

WITH duplicate_cte as
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, 
funds_raised_millions) row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, 
funds_raised_millions) row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Standardizing Data

SELECT company, TRIM(company)
FROM layoffs_staging2;

-- Update Company Names by removing spaces
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Update Location by removing spaces
UPDATE layoffs_staging2
SET location = TRIM(location);

SELECT DISTINCT(industry)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
	WHERE industry LIKE 'Crypt%';

-- Update Industry to one unique name    
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Cryp%';

SELECT DISTINCT(location)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT(stage)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT(Country)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT (country), TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

-- Update Country by removing spaces and .
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

SELECT `date`,
STR_TO_DATE( `date`,'%m/%d/%Y')
FROM layoffs_staging2;

-- Update Date format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE( `date`,'%m/%d/%Y');

SELECT DISTINCT(`date`)
FROM layoffs_staging2
ORDER BY 1;

-- changing date from 'text' to date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- Changing the blank to NULL first for easier filling-in of categories
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2 
WHERE (industry IS NULL OR industry = '');

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Airbnb%';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;