-- 출산율 변화와 반려동물 관련 소비 증가 비교
SELECT b.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       b.year AS 연도, 
       ROUND(b.birth_rate, 2) AS 출산율, 
       ROUND(SUM(p.expense_amount), 2) AS 총반려동물소비액,
       ROUND(SUM(CASE WHEN p.expense_type = 'medical' THEN p.expense_amount ELSE 0 END), 2) AS 의료비용
FROM regional_birth_rate b
JOIN pet_expenses p ON b.region_id = p.region_id AND b.year = p.year
JOIN regional_birth_rate r ON b.region_id = r.region_id
GROUP BY b.region_id, r.region_name, b.year, b.birth_rate
ORDER BY b.birth_rate ASC, 총반려동물소비액 DESC;
