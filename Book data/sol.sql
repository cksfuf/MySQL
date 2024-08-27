-- books [isbn, book_title, book_author, year_of_publication, publisher, ~]
-- users [User_ID, Location, Age]
-- ratings [User_ID, ISBN, Book_Rating]

-- 1.1 중복 데이터 확인
-- Books 테이블에서 중복된 ISBN 확인
SELECT isbn, COUNT(isbn)
FROM books
GROUP BY isbn
HAVING COUNT(isbn) > 1
LIMIT 5;

-- Ratings 테이블에서 중복된 사용자-책 평가 확인
SELECT User_Id, isbn, COUNT(isbn)
FROM ratings
GROUP BY User_Id, isbn
HAVING COUNT(isbn) > 1
LIMIT 5;

-- 1.2
-- Users 테이블에서 Age의 결측값 확인
SELECT Age, COUNT(Age)
FROM users
WHERE Age = 'NULL'
GROUP BY Age;

-- Books 테이블에서 Year_Of_Publication의 결측값 확인
SELECT COUNT(*)
FROM Books
WHERE year_of_publication IS NULL;


-- 2.1 사용자 연령 통계 확인
-- 사용자 연령의 기초 통계(최소, 최대, 평균)를 확인합니다.
SELECT MIN(CAST(Age AS int)), MAX(CAST(Age AS int)), AVG(CAST(Age AS int))
FROM users
WHERE CAST(AGE AS STRING) != 'NULL';

-- 2.2 출판 연도 통계 확인
-- 책의 출판 연도에 대한 기초 통계(최소, 최대, 평균)를 확인합니다.
SELECT MIN(year_of_publication), MAX(year_of_publication), AVG(year_of_publication)
FROM books
WHERE year_of_publication IS NOT NULL;

-- 2.3 평점의 분포 확인
SELECT CAST(Book_Rating AS INT), COUNT(Book_Rating)
FROM ratings
GROUP BY CAST(Book_Rating AS INT);



--3.1 출판사별 책 수 및 평균 평점
-- 출판사별로 얼마나 많은 책이 있는지, 그리고 그 책들의 평균 평점이 어떤지 확인합니다.
SELECT publisher, COUNT(publisher), AVG(Book_Rating)
FROM books
JOIN ratings ON books.isbn = ratings.isbn
GROUP BY publisher
ORDER BY COUNT(publisher) DESC
LIMIT 10;

-- 3.2 가장 많이 평가된 책과 그 평점
-- 가장 많이 평가된 책이 무엇인지 확인합니다.
SELECT book_title, COUNT(book_title), AVG(Book_Rating)
FROM books
JOIN ratings ON books.isbn = ratings.isbn
GROUP BY book_title
ORDER BY COUNT(book_title) DESC
LIMIT 10;


-- 4.1 책 평점과 출판 연도 간의 관계
-- 책의 출판 연도와 평점 간의 관계를 확인합니다.
SELECT year_of_publication, AVG(Book_Rating)
FROM books
JOIN ratings ON books.isbn = ratings.isbn
GROUP BY year_of_publication;

-- 4.2사용자 위치별 평점 차이
-- 위치에 따라 평균 평점을 출력합니다. 적어도 10개 이상의 평가를 한 경우만 출력합니다.
SELECT Location, AVG(Book_Rating), COUNT(Book_Rating)
FROM users
JOIN ratings ON users.User_ID = ratings.User_ID
GROUP BY Location
HAVING COUNT(Book_Rating) > 9
ORDER BY AVG(Book_Rating) DESC
LIMIT 10;

-- 4.3 책 저자별 평균 평점
-- 각 저자별로 평균 평점이 어떻게 다른지 확인합니다. 적어도 10개 이상의 평가를 한 경우만 출력합니다.
SELECT book_author, AVG(Book_Rating), COUNT(Book_author)
FROM books
JOIN ratings ON books.isbn = ratings.isbn
GROUP BY book_author
HAVING COUNT(Book_Rating) > 10
ORDER BY AVG(Book_Rating) DESC
LIMIT 10;



-- books [isbn, book_title, book_author, year_of_publication, publisher, ~]
-- users [User_ID, Location, Age]
-- ratings [User_ID, ISBN, Book_Rating]

-- 4.4 평점 상위 10개의 책이 출판된 연도 분포
-- 평점 상위 10개의 책이 어느 연도에 많이 출판되었는지 확인합니다.
SELECT b.year_of_publication, COUNT(b.book_title) AS cnt_book_title
FROM books b
JOIN
(SELECT a.isbn,
SUM(c.book_rating) / COUNT(c.book_rating) AS avg_rating
FROM ratings c
JOIN books a
ON a.isbn = c.isbn
GROUP BY a.isbn
ORDER BY avg_rating DESC
LIMIT 10) r
ON b.isbn = r.isbn
GROUP BY b.year_of_publication
ORDER BY cnt_book_title DESC;

-- 강사님 코드
WITH Top10Books AS (
  SELECT
    r.ISBN,
    b.Book_Title,
    b.Year_Of_Publication,
    AVG(r.Book_Rating) AS Avg_Rating
  FROM
    ratings_view r
  JOIN
    books_view b ON r.ISBN = b.ISBN
  GROUP BY
    r.ISBN, b.Book_Title, b.Year_Of_Publication
  HAVING 
    COUNT(r.ISBN) > 10
  ORDER BY
    Avg_Rating DESC
  LIMIT 10
)

SELECT
  Year_Of_Publication,
  COUNT(*) AS Number_Of_Books
FROM
  Top10Books
GROUP BY
  Year_Of_Publication
ORDER BY
  Number_Of_Books DESC;