-- <Movie schema>
-- u_user [user_id, age, gender, occupation, zip_code]
-- u_data [user_id, movie_id, rating, rating_timestamp]
-- u_item [movie_id, title, release_date, video_release_date, imdb_url, unknown, action, ~]


-- 1. 사용자별 평균 평점 내림차순 계산하
SELECT user_id, AVG(rating)
FROM u_data
GROUP BY user_id
ORDER BY AVG(rating) DESC
LIMIT 10;

-- 2. 평점 분포 계산하기
SELECT rating, COUNT(rating)
FROM u_data
GROUP BY rating;

-- 3. 가장 많이 평가한 사용자 찾기
SELECT user_id, COUNT(rating)
FROM u_data
GROUP BY user_id
ORDER BY COUNT(rating) DESC
LIMIT 10;

-- 4. 영화별 평균 평점 계산하기
SELECT title, AVG(rating)
FROM u_item
JOIN u_data ON u_item.movie_id = u_data.movie_id
GROUP BY title
HAVING COUNT(rating) >= 10
ORDER BY AVG(rating) DESC
LIMIT 10;

-- 5. 영화별 특정 연령대(18- 24세)의 평균 평점 
SELECT title, AVG(rating)
FROM u_item
JOIN u_data ON u_item.movie_id = u_data.movie_id
JOIN u_user ON u_data.user_id = u_user.user_id
WHERE age BETWEEN 18 AND 24
GROUP BY title
ORDER BY AVG(rating) DESC
LIMIT 10;

-- 6. 가장 많이 평가된 영화 찾기
SELECT title, COUNT(rating)
FROM u_item
JOIN u_data ON u_item.movie_id = u_data.movie_id
GROUP BY title
ORDER BY COUNT(rating) DESC
LIMIT 10;

-- 7. 성별에 따른 영화 평점 차이 분석(GROUP BY 절에 gender 빼면 안됨)
SELECT title, gender, AVG(rating)
FROM u_item
JOIN u_data ON u_item.movie_id = u_data.movie_id
JOIN u_user ON u_data.user_id = u_user.user_id
GROUP BY title, gender
LIMIT 10;

-- 8. 특정 직업군(예: 학생)의 영화 선호도 분석(평가가 10개 초과인 조건)
SELECT title, AVG(rating)
FROM u_item
JOIN u_data ON u_item.movie_id = u_data.movie_id
JOIN u_user ON u_data.user_id = u_user.user_id
WHERE occupation = 'student'
GROUP BY title
HAVING COUNT(rating) > 10
ORDER BY AVG(rating) DESC
LIMIT 10;