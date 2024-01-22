SELECT title
from episodes
WHERE strftime('%m', air_date) = '12';