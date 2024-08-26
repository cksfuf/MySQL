SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME)>1
ORDER BY NAME;

-- SELECT NAME, COUNT(NAME)
-- FROM ANIMAL_INS
-- GROUP BY NAME
-- HAVING COUNT(NAME) >= 2
-- ORDER BY NAME DESC;
-- DESC는 내림차순
-- AS 는 칼럼 명 지정