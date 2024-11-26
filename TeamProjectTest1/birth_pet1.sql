-- 출산율과 반려동물 소유율의 상관관계 분석
SELECT b.region_name AS 지역명, 
       b.year AS 연도, 
       ROUND(b.birth_rate, 2) AS 출산율, 
       ROUND(AVG(a.ownership_rate), 2) AS 평균반려동물소유율
FROM regional_birth_rate b
JOIN age_pet_ownership a ON b.region_id = a.region_id AND b.year = a.year
WHERE a.age_group IN ('20-29', '30-39')
GROUP BY b.region_name, b.year, b.birth_rate
ORDER BY b.birth_rate ASC;
