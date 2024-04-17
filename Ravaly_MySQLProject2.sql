-- Create database 

CREATE DATABASE painting;

-- use database painting;

USE painting;

-- show tables

SHOW TABLES;

-- Joining Tables:
-- 1. Retrieve the full name of artists along with the names of the museums where their works are displayed and the work name.

SELECT artist.full_name as "Artist Name", museum.name as "Museum Name", work.name as "Painting"
FROM ((work
INNER JOIN artist ON work.artist_id = artist.artist_id)
INNER JOIN museum ON work.museum_id = museum.museum_id);


-- 2. Group By and Count:
-- How many works does each artist have in the database? Display the artist's full name along with the count of their works, ordered by the count in descending order.

SELECT a.full_name as "Artist Name", count(*) AS "Work_Count"
FROM work w
INNER JOIN artist a ON w.artist_id = a.artist_id
GROUP BY a.full_name
ORDER BY Work_Count DESC; 


-- 3. Order By and Limit:
-- List the top 5 museums with the highest number of works displayed in the database, along with their respective counts.

SELECT m.name, count(w.work_id) AS "Work_Count"
FROM work w
INNER JOIN museum m ON w.museum_id = m.museum_id
GROUP BY m.name
ORDER BY Work_Count DESC
LIMIT 5;

-- 4. Join, Order By, and Limit:
-- Display the names and styles of the works along with the corresponding museum names, ordered by the museum name in ascending order. Limit the results to 10.


SELECT w.name AS "Work_Name", w.style AS "Work_Style", m.name AS "Museum_Name"
FROM work w
INNER JOIN museum m ON w.museum_id = m.museum_id
ORDER BY Museum_Name
LIMIT 10;


-- 5.Join, Group By, and Sum:
-- Show the total sale price for each artist's works. Display the artist's full name along with the total sale price, ordered by the total sale price in descending order.


SELECT a.full_name AS "Artist_Name" , sum(p.sale_price) "Total_Sale_Price"
FROM ((work w
INNER JOIN artist a ON w.artist_id = a.artist_id)
INNER JOIN product_size p ON w.work_id = p.work_id) 
GROUP BY Artist_Name
ORDER BY Total_Sale_Price DESC;


-- 6. Join, Group By, and Having:
-- List artists who have more than 3 works in the database, along with the count of their works.

SELECT a.full_name AS "Artist_Name", count(w.work_id) AS "Work_Count"
FROM work w
INNER JOIN artist a ON w.artist_id = a.artist_id
GROUP BY Artist_Name
HAVING Work_Count >3 ;


-- 7. Join, Where, and Order By:
-- Retrieve the names of works and their corresponding artists' full names for works that have a sale price smaller than their regular price. 

SELECT w.name AS "Work_Name", a.full_name AS "Artist_Name", sale_price , regular_price
FROM ((work w
INNER JOIN artist a ON w.artist_id = a.artist_id)
INNER JOIN product_size p ON w.work_id = p.work_id) 
WHERE sale_price < regular_price;


-- 8. Calculate the average height and width of the artworks in the database. Display the average height and width.

SELECT AVG(height) AS "Avg_Height", AVG(width) AS "Avg_Width"
FROM canvas_size;


-- Join, Group By, and Max:
-- 9 Find the maximum sale price among all the works in each museum. Display the museum name along with the maximum sale price.

SELECT m.name "Museum_Name", MAX(sale_price) "Max_Sale_Price"
FROM ((work w
INNER JOIN museum m ON w.museum_id = m.museum_id)
INNER JOIN product_size p ON w.work_id = p.work_id) 
GROUP BY Museum_Name;


-- Join, Group By, and Concatenate:
-- 10. Concatenate the first name and last name of artists along with their nationality, separated by a comma. Display the concatenated string along with the count of works by each artist, ordered by the count in descending order.

SELECT CONCAT(a.first_name, a.last_name,", ",a.nationality) AS Artist, COUNT(work_id) AS "Work_Count"
FROM work w
INNER JOIN artist a ON w.artist_id = a.artist_id
GROUP BY Artist
ORDER BY Work_Count DESC;

