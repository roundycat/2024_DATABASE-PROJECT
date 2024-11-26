-- 노령 인구 비율 상위 3개 지역의 연도별 반려동물 소유율 변화
WITH TopRegions AS (
    SELECT region_id, year, ROUND(elder_ratio, 2) AS elder_ratio
    FROM elder_population
    WHERE year = 2023
    ORDER BY elder_ratio DESC
    LIMIT 3
)
SELECT t.region_id AS 지역ID, 
       r.region_name AS 지역명, 
       t.year AS 연도, 
       t.elder_ratio AS 노령비율, 
       a.age_group AS 연령대, 
       ROUND(AVG(a.ownership_rate), 2) AS 평균소유율
FROM TopRegions t
JOIN age_pet_ownership a ON t.region_id = a.region_id AND t.year = a.year
JOIN regional_birth_rate r ON t.region_id = r.region_id
GROUP BY t.region_id, r.region_name, t.year, t.elder_ratio, a.age_group
ORDER BY t.elder_ratio DESC, a.age_group;
