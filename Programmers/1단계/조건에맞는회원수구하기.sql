-- 다음은 어느 의류 쇼핑몰에 가입한 회원 정보를 담은 USER_INFO 테이블입니다.
-- USER_INFO 테이블은 아래와 같은 구조로 되어있으며 USER_ID, GENDER, AGE, JOINED는 각각 회원 ID, 성별, 나이, 가입일을 나타냅니다.

-- USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
SELECT COUNT(USER_ID)
FROM USER_INFO
WHERE JOINED LIKE '2021%' AND AGE BETWEEN 20 AND 29;

-- COUNT 함수를 사용하여 개수를 확인.
-- LIKE '2021%'을 사용하여 2021로 시작하는 값을 JOINED에서 찾기.
-- 그리고 AGE 값이 20과29 사이 인 값을 찾기.