
SELECT * 
FROM layoffs_staging2;

SELECT company , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT location , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC;

SELECT industry , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT max(`date`),min(`date`)
FROM layoffs_staging2;

SELECT YEAR(`date`) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT SUBSTRING(`date`,1,7) as YearMonth,sum(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 DESC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) as YearMonth,sum(total_laid_off) AS TotalLaidOff
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 DESC
) 
SELECT YearMonth, TotalLaidOff,SUM(TotalLaidOff) Over(order by YearMonth) AS RollingTotal
FROM Rolling_Total;

SELECT company,YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 1 Asc;

WITH Company_Year AS
(
SELECT company,YEAR(`date`) as year, sum(total_laid_off) as total_off
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)

), Company_Year_Ranking AS
(
SELECT company,year, total_off,dense_rank() Over(partition by year order by total_off DESC) as ranking
FROM Company_Year
WHERE year is not null
)
SELECT * 
FROM Company_Year_Ranking
WHERE ranking <=5;