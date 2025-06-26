use airport_dwh;
CREATE PROCEDURE `times`()
BEGIN
    SET @t_current = "00:00:00"; 
    SET @t_end = ADDTIME(@t_current, 240000); 
    
    WHILE(@t_current< @t_end) DO 
        INSERT INTO airport_dwh.dim_time (hour24,hour12,hour,minute)
        VALUES (@t_current, TIME_FORMAT(@t_current, '%h:%i'),hour(@t_current),minute(@t_current));
        
        SET @t_current = ADDTIME(@t_current, 000100); 
    END WHILE; 
END;