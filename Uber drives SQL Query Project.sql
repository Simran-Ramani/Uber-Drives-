select * from [dbo].[My Uber Drives - 2016 (1)]
SELECT 
    column1 AS 'Start_Date',
    column2 AS 'End_Date', 
	column3 AS 'Category',
	column4 AS 'Start_Location',
	column5 AS 'End_Location',
	column6 AS 'Miles',
	column7 AS 'Purpose'
FROM [dbo].[My Uber Drives - 2016 (1)];

EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column1', 'Start_date', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column2', 'End_date', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column3', 'Category', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column4', 'Start_Location', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column5', 'End_Location', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column6', 'Miles', 'COLUMN';
EXEC sp_rename '[dbo].[My Uber Drives - 2016 (1)].column7', 'Purpose', 'COLUMN';

select * from [dbo].[My Uber Drives - 2016 (1)]

select 
count(*) as total_rows,
sum(case when purpose is null then 1 else 0 end) as null_col
from [dbo].[My Uber Drives - 2016 (1)]

delete from [dbo].[My Uber Drives - 2016 (1)]
where purpose is null

select * from [dbo].[My Uber Drives - 2016 (1)]

exec sp_help '[dbo].[My Uber Drives - 2016 (1)]'

---estimated expense by purpose--
SELECT 
    purpose,
    COUNT(*) AS total_trips,
    SUM(miles) AS total_miles,
    SUM(miles * 0.67) AS estimated_expense_usd
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
GROUP BY 
    purpose
ORDER BY 
    estimated_expense_usd DESC;

	
--Trip trends- by day of week--
SELECT 
    DATENAME(WEEKDAY, start_date) AS day_of_week,
    category,
    COUNT(*) AS trip_count,
    SUM(miles) AS total_miles
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
GROUP BY 
    DATENAME(WEEKDAY, start_date), category
ORDER BY 
    -- optional: sort by weekday order (Monday to Sunday)
    CASE DATENAME(WEEKDAY, start_date)
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;

--- Location based purpose summary--
SELECT 
    end_location,
    purpose,
    COUNT(*) AS trip_count,
    SUM(miles) AS total_miles
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
GROUP BY 
    end_location, purpose
ORDER BY 
    trip_count DESC;

---Weekdays V/S Weekends Driving Behaviour---

SELECT 
    CASE 
        WHEN DATEPART(WEEKDAY, start_date) IN (1, 7) THEN 'Weekend'  -- 1 = Sunday, 7 = Saturday (depends on DATEFIRST setting)
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS trip_count,
    SUM(miles) AS total_miles,
    AVG(miles) AS avg_miles_per_trip
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
GROUP BY 
    CASE 
        WHEN DATEPART(WEEKDAY, start_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END;

---Average Speed (Miles per Hour) per Trip----
SELECT
    start_date,
    end_date,
    purpose,
    miles,
    CAST(DATEDIFF(MINUTE, start_date, end_date) AS FLOAT) / 60.0 AS duration_hours,
    CASE 
        WHEN DATEDIFF(MINUTE, start_date, end_date) > 0 
        THEN miles / (CAST(DATEDIFF(MINUTE, start_date, end_date) AS FLOAT) / 60.0)
        ELSE NULL
    END AS avg_speed_mph
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
WHERE 
    DATEDIFF(MINUTE, start_date, end_date) > 0;

---Compare Average speed By Purpose---

SELECT
    purpose,
    COUNT(*) AS trip_count,
    SUM(miles) AS total_miles,
    SUM(CAST(DATEDIFF(MINUTE, start_date, end_date) AS FLOAT)) / 60.0 AS total_hours,
    SUM(miles) / NULLIF(SUM(CAST(DATEDIFF(MINUTE, start_date, end_date) AS FLOAT)) / 60.0, 0) AS avg_speed_mph
FROM 
    [dbo].[My Uber Drives - 2016 (1)]
WHERE 
    DATEDIFF(MINUTE, start_date, end_date) > 0
GROUP BY 
    purpose;


ALTER TABLE [dbo].[My Uber Drives - 2016 (1)]
ADD avg_speed_mph FLOAT;

UPDATE [dbo].[My Uber Drives - 2016 (1)]
SET avg_speed_mph = 
    CASE 
        WHEN DATEDIFF(MINUTE, start_date, end_date) > 0 
             AND miles IS NOT NULL
        THEN miles / (CAST(DATEDIFF(MINUTE, start_date, end_date) AS FLOAT) / 60.0)
        ELSE NULL
    END;