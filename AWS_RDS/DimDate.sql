SET @first_date = '1970-01-01';
SET @last_date = '2100-12-31';
SET SESSION cte_max_recursion_depth = 1000000; 

INSERT INTO DimDate
WITH RECURSIVE date_dim(now_date) AS  
	(
	SELECT
		@first_date AS now_date
	UNION ALL
	SELECT
		DATE_ADD(now_date,INTERVAL 1 DAY)
	FROM
		date_dim
	WHERE
		now_date < @last_date
	)
    
    SELECT
    now_date AS CurrentDate,
	FORMAT(now_date,'dd/MM/yyyy') AS EuropeanDate,
	FORMAT(now_date,'MM/dd/yyyy') AS AmericanDate,
    EXTRACT(DAY FROM now_date) AS NumberDay,
	WEEKDAY(now_date) AS NumberDayOfWeek,
    DAYNAME(now_date) AS TitleOfDay,
    DAYOFYEAR(now_date) AS NumberDayOfYear,
    EXTRACT(WEEK FROM now_date) AS NumberWeekInYear,
    WEEK(now_date,5) - WEEK(DATE_SUB(now_date, INTERVAL DAYOFMONTH(now_date) - 1 DAY), 5) + 1 as NumberWeekInMonth,
    EXTRACT(MONTH FROM now_date) AS NumberMonth,
    EXTRACT(MONTH FROM now_date) AS NameMonth,
    EXTRACT(QUARTER FROM now_date) AS NumberQuarter,   
    EXTRACT(YEAR FROM now_date) AS CurrentYear
    
FROM
	date_dim;

SELECT * FROM DimDate


