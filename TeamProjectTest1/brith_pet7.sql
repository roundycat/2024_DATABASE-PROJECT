-- 출산율과 반려동물 관련 의료비의 연관성
SELECT b.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       b.year AS 연도, 
       ROUND(b.birth_rate, 2) AS 출산율, 
       ROUND(SUM(p.expense_amount), 2) AS 총의료비용
FROM regional_birth_rate b
JOIN pet_expenses p ON b.region_id = p.region_id AND b.year = p.year
JOIN regional_birth_rate r ON b.region_id = r.region_id
WHERE p.expense_type = 'medical'
GROUP BY b.region_id, r.region_name, b.year, b.birth_rate
ORDER BY b.birth_rate ASC, 총의료비용 DESC;
