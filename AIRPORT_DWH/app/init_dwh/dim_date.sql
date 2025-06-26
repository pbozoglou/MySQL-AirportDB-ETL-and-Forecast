use airport_dwh;

CREATE PROCEDURE `dates`()
BEGIN
    SET @t_current = '2010-01-01 00:00:01'; 
    SET @t_end = '2025-12-31 00:00:00'; 
    WHILE(@t_current< @t_end) DO 
        INSERT INTO airport_dwh.dim_date (full_date,day_of_week,day_name,day_of_month,day_of_year,week_of_year,month_name,month_of_year,quarter,year)
        VALUES (DATE(@t_current),dayofweek(@t_current),dayname(@t_current),DAYOFMONTH(@t_current) ,DAYOFYEAR(@t_current),weekOFYEAR(@t_current),monthname(@t_current),
        month(@t_current),quarter(@t_current),year(@t_current));
        
        SET @t_current = DATE_ADD(@t_current, INTERVAL 1 day); 
    END WHILE; 
END;