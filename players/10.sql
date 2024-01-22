SELECT AVG(weight) AS 'Average Weights for players > 190'
FROM players
WHERE height > 80
ORDER BY height;