/*Find the names of all students who are friends with someone named Gabriel.*/
SELECT name
FROM highschooler
WHERE ID in
(SELECT ID2
FROM highschooler, friend 
WHERE ID = ID1 AND name = "Gabriel");

/*For every student who likes someone 2 or more grades younger than themselves, 
return that student's name and grade, and the name and grade of the student they like.*/
SELECT H1.name, H1.grade, H2.name,  H2.grade
FROM highschooler AS H1, highschooler AS H2, likes
WHERE H1.ID = likes.ID1 AND H2.ID = likes.ID2 AND H1.grade - H2.grade >= 2;

/*For every pair of students who both like each other, return the name and grade of both students. 
Include each pair only once, with the two names in alphabetical order.*/
SELECT H2.name,  H2.grade, H1.name, H1.grade
FROM highschooler AS H1, highschooler AS H2, likes
WHERE (likes.ID1 + likes.ID2) IN (SELECT (ID1 + ID2) AS theID FROM likes GROUP BY theID HAVING COUNT(*) >= 2) AND H1.ID = likes.ID1 AND H2.ID = likes.ID2 AND H1.name > H2.name
ORDER by H1.name, H2.name;

/*Find all students who do not appear in the Likes table (as a student who likes or is liked) 
and return their names and grades. Sort by grade, then by name within each grade.*/
SELECT DISTINCT name, grade
FROM highschooler, likes
WHERE ID not in (SELECT ID1 FROM likes UNION SELECT ID2 FROM likes);

/*For every situation where student A likes student B, but we have no information about whom B likes 
(that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM highschooler AS H1, highschooler AS H2, likes 
WHERE H1.ID = ID1 AND H2.ID = ID2
AND ID2 not in (SELECT ID1 FROM likes);

/*Find names and grades of students who only have friends in the same grade.
Return the result sorted by grade, then by name within each grade..*/
SELECT DISTINCT H1.name, H1.grade
FROM highschooler AS H1, highschooler AS H2, friend
WHERE H1.ID = ID1 AND H2.ID = ID2 and H1.grade = H2.grade
AND H1.ID NOT IN
(SELECT H1.ID
FROM highschooler AS H1, highschooler AS H2, friend
WHERE H1.ID = ID1 AND H2.ID = ID2 and H1.grade<> H2.grade)
ORDER BY H1.grade, H1.name;

/*For each student A who likes a student B where the two are not friends, 
find if they have a friend C in common (who can introduce them!). 
For all such trios, return the name and grade of A, B, and C..*/
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM highschooler H1, highschooler H2, highschooler H3, friend F1, friend F2, likes
WHERE H1.ID = likes.ID1 AND H2.ID = likes.ID2 AND 
H1.ID = F1.ID1 AND H2.ID = F2.ID1 AND H3.ID = F1.ID2 AND H3.ID = F2.ID2
AND (H1.ID + likes.ID2)
NOT IN (SELECT ID1 + ID2 FROM friend);

/*Find the difference between the number of students in the school and the 
number of different first names. */
SELECT COUNT(name) - COUNT(DISTINCT name)
FROM highschooler;

/*Find the name and grade of all students who are liked by more than one other student.*/
SELECT DISTINCT name, grade
FROM highschooler, likes
WHERE ID = ID2 AND ID2 in
(SELECT ID2 FROM likes GROUP BY ID2 HAVING COUNT(ID2)>= 2);
