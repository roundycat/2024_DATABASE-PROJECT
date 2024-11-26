-- 출산율 하위 3개 지역에서 반려동물 소비 데이터 비교
WITH LowBirthRegions AS (
    SELECT region_id, year, birth_rate
    FROM regional_birth_rate
    WHERE year = 2023
    ORDER BY birth_rate ASC
    LIMIT 3
)
SELECT l.region_id, 
       r.region_name, 
       l.year, 
       ROUND(l.birth_rate, 2) AS birth_rate, 
       p.expense_type, 
       ROUND(SUM(p.expense_amount), 2) AS total_expenses
FROM LowBirthRegions l
JOIN pet_expenses p ON l.region_id = p.region_id AND l.year = p.year
JOIN regional_birth_rate r ON l.region_id = r.region_id
GROUP BY l.region_id, r.region_name, l.year, l.birth_rate, p.expense_type
ORDER BY region_id ASC;
-- 출산율 하위 3개 지역에서 반려동물 소비 데이터 비교
WITH LowBirthRegions AS (
    SELECT region_id, year, birth_rate
    FROM regional_birth_rate
    WHERE year = 2023
    ORDER BY birth_rate ASC
    LIMIT 3
)
SELECT l.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       l.year AS 연도, 
       ROUND(l.birth_rate, 2) AS 출산율, 
       p.expense_type AS 소비유형, 
       ROUND(SUM(p.expense_amount), 2) AS 총소비액
FROM LowBirthRegions l
JOIN pet_expenses p ON l.region_id = p.region_id AND l.year = p.year
JOIN regional_birth_rate r ON l.region_id = r.region_id
GROUP BY l.region_id, r.region_name, l.year, l.birth_rate, p.expense_type
ORDER BY 지역ID ASC;
