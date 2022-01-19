/*It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
DELETE FROM highschooler
WHERE grade = 12;

/*If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.*/
DELETE FROM Likes
WHERE ID1 IN (SELECT L.ID1 
	FROM Likes L JOIN Friend F
	USING (ID1)
	WHERE L.ID2 = F.ID2)
AND ID2 NOT IN(SELECT L.ID1 
	FROM Likes L JOIN Friend F
	USING (ID1)
	WHERE L.ID2 = F.ID2);
    
  /*For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
  Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
  (This one is a bit challenging; congratulations if you get it right.)*/  
INSERT INTO friend
SELECT f1.id1, f2.id2
FROM friend f1 JOIN friend f2 ON f1.id2 = f2.id1
WHERE f1.id1 <> f2.id2
EXCEPT
SELECT * FROM friend;
