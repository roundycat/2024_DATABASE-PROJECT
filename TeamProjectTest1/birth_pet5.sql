-- 출산율이 낮은 지역의 주요 반려동물 소비 유형
SELECT b.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       b.year AS 연도, 
       ROUND(b.birth_rate, 2) AS 출산율, 
       p.expense_type AS 소비유형, 
       ROUND(SUM(p.expense_amount), 2) AS 총소비액
FROM regional_birth_rate b
JOIN pet_expenses p ON b.region_id = p.region_id AND b.year = p.year
JOIN regional_birth_rate r ON b.region_id = r.region_id
WHERE b.birth_rate < (SELECT AVG(birth_rate) FROM regional_birth_rate)
GROUP BY b.region_id, r.region_name, b.year, b.birth_rate, p.expense_type
ORDER BY b.year ASC, 총소비액 DESC;
