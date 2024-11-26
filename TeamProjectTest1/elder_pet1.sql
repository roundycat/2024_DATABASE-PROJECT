-- 노령 인구 비율과 반려동물 양육률 변화 추세
SELECT e.year AS 연도, 
       ROUND(AVG(e.elder_ratio), 2) AS 평균노령비율, 
       ROUND(AVG(a.ownership_rate), 2) AS 평균반려동물양육률
FROM elder_population e
JOIN age_pet_ownership a 
    ON e.region_id = a.region_id AND e.year = a.year
WHERE a.age_group = '50+'
GROUP BY e.year
ORDER BY e.year ASC;
