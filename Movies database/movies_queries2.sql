/* Find the names of all reviewers who rated Gone with the Wind.*/
SELECT DISTINCT name
FROM movie, rating, reviewer
WHERE movie.mID = rating.mID AND rating.rID = reviewer.rID 
AND rating.mID = 101;

/* For any rating where the reviewer is the same as the director of the movie, 
return the reviewer name, movie title, and number of stars.*/
SELECT name, title, stars
FROM movie, rating, reviewer
WHERE movie.mID = rating.mID AND rating.rID = reviewer.rID 
AND name = director;

/*Return all reviewer names and movie names together in a single list, alphabetized. 
(Sorting by the first name of the reviewer and first word in the title is fine;
no need for special processing on last names or removing "The".)*/
SELECT title AS merged
FROM movie
UNION
SELECT name 
FROM reviewer
ORDER BY merged;

/*Find the titles of all movies not reviewed by Chris Jackson.*/
SELECT DISTINCT title
FROM movie
WHERE mID not in (SELECT movie.mID FROM movie, rating, reviewer
WHERE movie.mID = rating.mID AND rating.rID = reviewer.rID AND name = "Chris Jackson");

/*For all pairs of reviewers such that both reviewers gave a rating to 
the same movie, return the names of both reviewers. 
Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once.
For each pair, return the names in the pair in alphabetical order.*/
SELECT DISTINCT N1.name, N2.name
FROM (SELECT * FROM rating join reviewer using(rID)) N1,
(SELECT * FROM rating join reviewer using(rID)) N2
WHERE N1.mID = N2.mID AND N1.name < N2.name
ORDER BY N1.name;

/*For each rating that is the lowest (fewest stars) currently in the database, 
return the reviewer name, movie title, and number of stars.*/
SELECT name, title, stars
FROM (movie join rating using(mID)) join reviewer using(rID)
WHERE stars = (SELECT MIN(stars) FROM rating);

/*List movie titles and average ratings, from highest-rated to lowest-rated. 
If two or more movies have the same average rating, list them in alphabetical order.*/
SELECT title, AVG(stars) AS average
FROM movie join rating using(mID)
GROUP BY title
ORDER BY average DESC, title;

/*Find the names of all reviewers who have contributed three or more ratings.
 (As an extra challenge, try writing the query without HAVING or without COUNT.)*/
SELECT name
FROM rating join reviewer using(rID)
GROUP BY name
HAVING COUNT(*) >= 3;

/*Some directors directed more than one movie. For all such directors, 
return the titles of all movies directed by them, along with the director name. 
Sort by director name, then movie title. (As an extra challenge, 
try writing the query both with and without COUNT.)*/
SELECT title, director
FROM movie
WHERE director in (SELECT director FROM movie GROUP BY director
HAVING COUNT(*) >= 2)
ORDER BY director, title;

/*Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
(Hint: This query is more difficult to write in SQLite than other systems; 
you might think of it as finding the highest average rating and then choosing 
the movie(s) with that average rating.)*/
SELECT S.T, avgstars
FROM (SELECT AVG(stars) AS avgstars, title AS T FROM rating join movie using(mID) GROUP BY title) AS S
WHERE avgstars in 
(SELECT MAX(BV.AV) FROM (SELECT AVG(stars) AS AV FROM rating join movie using(mID) GROUP BY title) AS BV);

/*Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
(Hint: This query may be more difficult to write in SQLite than other systems; you might think
 of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)*/
SELECT S.T, avgstars
FROM (SELECT AVG(stars) AS avgstars, title AS T FROM rating join movie using(mID) GROUP BY title) AS S
WHERE avgstars in 
(SELECT MIN(BV.AV) FROM (SELECT AVG(stars) AS AV FROM rating join movie using(mID) GROUP BY title) AS BV);

/*For each director, return the director's name together with the title(s) of the movie(s) they 
directed that received the highest rating among all of their movies, and the value of that rating.
Ignore movies whose director is NULL.*/
SELECT director, title, MAX(stars)
FROM movie join rating USING(mID) join reviewer USING(rID)
WHERE director IS NOT NULL
GROUP BY director;
 