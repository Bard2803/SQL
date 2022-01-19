/*It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
DELETE FROM highschooler
WHERE grade = 12;

/*If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.*/
DELETE FROM likes
WHERE ID1 IN 
(SELECT likes.ID1 FROM friend, likes WHERE CONCAT(CAST(friend.ID1 AS CHAR(5)), CAST(friend.ID2 AS CHAR(5))) = CONCAT(CAST(likes.ID1 AS CHAR(5)), CAST(likes.ID2 AS CHAR(5))));

/*helper code*/
SELECT likes.ID1 FROM friend, likes WHERE CONCAT(CAST(friend.ID1 AS CHAR(5)), CAST(friend.ID2 AS CHAR(5))) = CONCAT(CAST(likes.ID1 AS CHAR(5)), CAST(likes.ID2 AS CHAR(5)))
;  
SELECT likes.ID1 FROM friend, likes WHERE CONCAT(CAST(friend.ID2 AS CHAR(5)), CAST(friend.ID1 AS CHAR(5))) = CONCAT(CAST(likes.ID1 AS CHAR(5)), CAST(likes.ID2 AS CHAR(5)));

DELETE FROM likes
WHERE ID1 IN 
(SELECT likes.ID1 FROM friend, likes WHERE CAST(friend.ID1 AS CHAR(5)) || CAST(friend.ID2 AS CHAR(5)) = CAST(likes.ID1 AS CHAR(5)) || CAST(likes.ID2 AS CHAR(5)))
AND likes.ID1 <> likes.ID2;

SELECT CAST(friend.ID1 AS CHAR(5)) || CAST(friend.ID2 AS CHAR(5)) FROM friend, likes