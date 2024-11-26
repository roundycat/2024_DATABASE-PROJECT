-- 노령 인구 비율과 반려동물 소비 데이터 분석
SELECT e.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       e.year AS 연도, 
       ROUND(e.elder_ratio, 2) AS 노령비율, 
       ROUND(SUM(p.expense_amount), 2) AS 총반려동물소비액
FROM elder_population e
JOIN pet_expenses p ON e.region_id = p.region_id AND e.year = p.year
JOIN regional_birth_rate r ON e.region_id = r.region_id
GROUP BY e.region_id, r.region_name, e.year, e.elder_ratio
ORDER BY e.year ASC, 총반려동물소비액 DESC;

