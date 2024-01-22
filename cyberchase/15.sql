SELECT strftime('%Y', air_date) AS year, MIN(strftime('%m-%d', air_date)) as month_day
FROM episodes
GROUP BY strftime('%Y', air_date);