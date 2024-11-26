-- 연령별 반려동물 소비 패턴의 변화
SELECT a.age_group AS 연령대, 
       p.expense_type AS 소비유형, 
       ROUND(AVG(p.expense_amount), 2) AS 평균소비액
FROM age_pet_ownership a
JOIN pet_expenses p ON a.region_id = p.region_id AND a.year = p.year
WHERE a.year BETWEEN 2018 AND 2023
GROUP BY a.age_group, p.expense_type
ORDER BY a.age_group, 평균소비액 DESC;
