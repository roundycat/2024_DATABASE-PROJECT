-- 1.노령 인구 증가에 따른 반려동물 양육 증가 분석
-- 1-1.지역별 노령 인구 비율과 반려동물 소유 비율 상관관계 분석
SELECT e.region_id, r.region_name, e.year, e.elder_ratio, p.ownership_rate
FROM elder_population e
JOIN age_pet_ownership p ON e.region_id = p.region_id AND e.year = p.year
JOIN regional_birth_rate r ON e.region_id = r.region_id;

-- 2. 출산율과 반려동물 소비 데이터
-- 2-1. 지역별 출산율과 반려동물 소유 비율 상관관계 분석
SELECT b.region_id, r.region_name, b.year, b.birth_rate, SUM(e.expense_amount) AS total_expense
FROM regional_birth_rate b
JOIN pet_expenses e ON b.region_id = e.region_id AND b.year = e.year
JOIN regional_birth_rate r ON b.region_id = r.region_id
GROUP BY b.region_id, r.region_name, b.year, b.birth_rate
ORDER BY b.year, r.region_name;

-- 2-2. 연령별 반려동물 소비 데이터 분석
SELECT p.age_group, p.year, r.region_name, SUM(e.expense_amount) AS total_expense
FROM age_pet_ownership p
JOIN pet_expenses e ON p.region_id = e.region_id AND p.year = e.year
JOIN regional_birth_rate r ON p.region_id = r.region_id
GROUP BY p.age_group, p.year, r.region_name
ORDER BY p.year, r.region_name, p.age_group;

-- 2.3 반려동물을 자녀 대체제로 여기는 경향성 확인
SELECT p.age_group, p.year, AVG(e.expense_amount) AS avg_expense, AVG(b.birth_rate) AS avg_birth_rate
FROM age_pet_ownership p
JOIN pet_expenses e ON p.region_id = e.region_id AND p.year = e.year
JOIN regional_birth_rate b ON p.region_id = b.region_id AND p.year = b.year
WHERE p.age_group IN ('20-29', '30-39')
GROUP BY p.age_group, p.year
ORDER BY p.year, p.age_group;

-- 2-4. 젊은 세대의 반려동물 관련 지출 추세 분석  
SELECT e.year, e.expense_type, SUM(e.expense_amount) AS total_expense
FROM pet_expenses e
JOIN age_pet_ownership p ON e.region_id = p.region_id AND e.year = p.year
WHERE p.age_group IN ('20-29', '30-39')
GROUP BY e.year, e.expense_type
ORDER BY e.year, e.expense_type;

-- 3. 상관 계수 계산
-- "출생률(birth_rate)"**과 "젊은 세대(20-29세 및 30-39세)의 반려동물 소유 비율(ownership_rate)"
WITH stats AS (
    SELECT 
        AVG(b.birth_rate) AS avg_birth_rate,
        AVG(p.ownership_rate) AS avg_ownership_rate
    FROM regional_birth_rate b
    JOIN age_pet_ownership p ON b.region_id = p.region_id AND b.year = p.year
    WHERE p.age_group IN ('20-29', '30-39') -- 젊은 세대만 선택
),
variance AS (
    SELECT 
        SUM((b.birth_rate - (SELECT avg_birth_rate FROM stats)) * 
            (p.ownership_rate - (SELECT avg_ownership_rate FROM stats))) AS covariance,
        SUM(POWER(b.birth_rate - (SELECT avg_birth_rate FROM stats), 2)) AS var_birth_rate,
        SUM(POWER(p.ownership_rate - (SELECT avg_ownership_rate FROM stats), 2)) AS var_ownership_rate
    FROM regional_birth_rate b
    JOIN age_pet_ownership p ON b.region_id = p.region_id AND b.year = p.year
    WHERE p.age_group IN ('20-29', '30-39')
),
correlation AS (
    SELECT 
        covariance / (SQRT(var_birth_rate) * SQRT(var_ownership_rate)) AS correlation_coefficient
    FROM variance
)
SELECT * FROM correlation;

