-- 노령 인구 증가에 따른 특정 소비 유형 변화
SELECT e.year AS 연도, 
       p.expense_type AS 소비유형, 
       ROUND(SUM(p.expense_amount), 2) AS 총소비액
FROM elder_population e
JOIN pet_expenses p ON e.region_id = p.region_id AND e.year = p.year
GROUP BY e.year, p.expense_type
ORDER BY e.year ASC, 총소비액 DESC;
