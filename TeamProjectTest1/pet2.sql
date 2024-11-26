-- 전체 반려동물 소비 규모 상위 3개 지역
SELECT r.region_name, 
       ROUND(SUM(p.expense_amount), 2) AS total_expenses
FROM pet_expenses p
JOIN regional_birth_rate r ON p.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_expenses DESC
LIMIT 3;
