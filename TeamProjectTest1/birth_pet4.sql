-- 출산율 하락과 반려동물 소비 증가율 비교
WITH YearlyExpenses AS (
    SELECT year AS 연도, 
           ROUND(SUM(expense_amount), 2) AS 총소비액
    FROM pet_expenses
    GROUP BY year
),
YearlyBirthRate AS (
    SELECT year AS 연도, 
           ROUND(AVG(birth_rate), 2) AS 평균출산율
    FROM regional_birth_rate
    GROUP BY year
)
SELECT 출산율.연도, 
       출산율.평균출산율, 
       소비.총소비액, 
       ROUND((소비.총소비액 - LAG(소비.총소비액) OVER (ORDER BY 소비.연도)) 
             / LAG(소비.총소비액) OVER (ORDER BY 소비.연도) * 100, 2) AS 소비증가율,
       ROUND((출산율.평균출산율 - LAG(출산율.평균출산율) OVER (ORDER BY 출산율.연도)) 
             / LAG(출산율.평균출산율) OVER (ORDER BY 출산율.연도) * 100, 2) AS 출산율증가율
FROM YearlyExpenses 소비
JOIN YearlyBirthRate 출산율 ON 소비.연도 = 출산율.연도
ORDER BY 출산율.연도 ASC;
