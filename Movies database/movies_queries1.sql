/* Find the titles of all movies directed by Steven Spielberg */
SELECT title
FROM movie
WHERE director = "Steven Spielberg";

/* Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.*/
SELECT DISTINCT year
FROM rating, movie
WHERE movie.mID = rating.mID
AND stars >= 4
ORDER BY year ASC;

/* Find the titles of all movies that have no ratings.*/
SELECT DISTINCT title
FROM rating, movie
WHERE movie.mID not in (SELECT mID FROM rating);

/* Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.*/
SELECT name
FROM rating, reviewer
WHERE rating.rID = reviewer.rID
AND ratingDate IS NULL;

/* Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.*/
SELECT name, title, stars, ratingDate
FROM movie, rating, reviewer
WHERE movie.mID = rating.mID AND rating.rID = reviewer.rID
ORDER BY name, title, stars;

/*For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
return the reviewer's name and the title of the movie.*/
SELECT name, title
FROM movie, reviewer, rating R1, rating R2
WHERE movie.mID = R1.mID AND R1.rID = reviewer.rID AND R1.mID = R2.mID AND R1.rID = R2.rID
AND R1.ratingDate > R2.ratingDate AND R1.stars > R2.stars;

/*For each movie that has at least one rating, find the highest number of stars that movie received. 
Return the movie title and number of stars. Sort by movie title.*/
SELECT title, MAX(stars)
FROM movie, rating
WHERE movie.mID = rating.mID
GROUP BY title;

/*For each movie that has at least one rating, find the highest number of stars that movie received. 
Return the movie title and number of stars. Sort by movie title.*/
SELECT title, MAX(stars) - MIN(stars) AS ratingSpread
FROM movie, rating
WHERE movie.mID = rating.mID
GROUP BY title
ORDER BY ratingSpread DESC, title;

/*Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
(Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after.
 Don't just calculate the overall average rating before and after 1980.)*/
SELECT AVG(A.avgbf)- AVG(B.avgaf)
FROM (SELECT AVG(stars) AS avgbf
FROM movie, rating
WHERE movie.mID = rating.mID AND year < 1980
GROUP BY title) A, (SELECT AVG(stars) AS avgaf
FROM movie, rating
WHERE movie.mID = rating.mID AND year > 1980
GROUP BY title) B;