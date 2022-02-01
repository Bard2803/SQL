/*For every situation where student A likes student B, but student B likes a different student C, 
return the names and grades of A, B, and C.*/
select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Highschooler H2, Highschooler H3, Likes L1, Likes L2
where H1.ID = L1.ID1 and H2.ID = L1.ID2 and H2.ID = L2.ID1 and H3.ID = L2.ID2 and H1.ID <> H3.ID;

/*Find those students for whom all of their friends are in different grades from themselves. 
Return the students' names and grades.*/
select avg(friend_count)
from (select count(F1.ID2) as friend_count
from (select name as N1, grade as G1, ID as ID1 from Highschooler H1) inner join Friend F1 using(ID1)
group by ID1)

/*Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra.
Do not count Cassandra, even though technically she is a friend of a friend.*/
select count(ID2)
from(
select ID2
from Friend
where ID1 =
(select H1.ID
from Highschooler H1
where name = 'Cassandra')

union 

select ID2
from Friend
where ID1 in (select ID2
from Friend
where ID1 =
(select H1.ID
from Highschooler H1
where name = 'Cassandra')) and ID2 <> (select H1.ID
from Highschooler H1
where name = 'Cassandra')
)

/*Find the name and grade of the student(s) with the greatest number of friends.*/
select N1, G1
from(
select H1.name as N1, H1.grade as G1, count(F1.ID2) as friend_count
 from Highschooler H1, Friend F1
 where H1.ID = F1.ID1 
 group by H1.ID)
 where friend_count = (select max(friend_count)
 from (select H1.name as N1, H1.grade as G1, count(F1.ID2) as friend_count
 from Highschooler H1, Friend F1
 where H1.ID = F1.ID1 
 group by H1.ID))