# Exploratory-Analysis-Layoff
This documentation accompanies the SQL script Exploratory Analysis.sql, which performs exploratory data analysis (EDA) on the layoffs_staging2 dataset

## 📁 Dataset
Table: layoffs_staging2
This table contains global layoff data including:
* company
* location
* industry
* country
* date
* total_laid_off

## View Full Dataset
```sql
SELECT *
FROM layoffs_staging2;
```
Displays all rows in the dataset.

## Total Layoffs by Company
```sql
SELECT company , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
```
Shows which companies had the highest total layoffs.

## Total Layoffs by Location
```sql
SELECT location , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC;
```
Ranks locations by total layoffs.

## Total Layoffs by Industry
```sql
SELECT industry , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
```
Identifies which industries were hit hardest.

## Total Layoffs by Country
```sql
SELECT country , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
```
Summarizes layoffs by country.

## Date Range of Layoffs
```sql
SELECT max(`date`),min(`date`)
FROM layoffs_staging2;
```
Returns the earliest and latest dates in the dataset.

## Layoffs by Year
```sql
SELECT YEAR(`date`) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
```
Displays annual layoff totals.

## Layoffs by Year-Month
```sql
SELECT SUBSTRING(`date`,1,7) as YearMonth,sum(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 DESC;
```
Provides a month‑level trend.

## Rolling Total Layoffs (Cumulative)
```sql
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) as YearMonth,sum(total_laid_off) AS TotalLaidOff
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 DESC
```
Calculates cumulative layoffs over time.

## Layoffs by Company Per Year
```sql
SELECT company,YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 1 Asc;
``
Breakdown of layoffs for each company annually.






