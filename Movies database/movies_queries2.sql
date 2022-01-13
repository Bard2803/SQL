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