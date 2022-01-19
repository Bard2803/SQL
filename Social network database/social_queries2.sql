/*For every situation where student A likes student B, but student B likes a different student C, 
return the names and grades of A, B, and C.*/
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM highschooler H1, highschooler H2, highschooler H3, likes L1, likes L2
WHERE H1.ID = L1.ID1 AND H2.ID = L1.ID2 AND 
H2.ID IN (SELECT ID1 FROM likes WHERE ID1 = ID2);

/*Find those students for whom all of their friends are in different grades from themselves. 
Return the students' names and grades.*/
SELECT name, grade, ID2
FROM highschooler, friend
WHERE ID = ID1 