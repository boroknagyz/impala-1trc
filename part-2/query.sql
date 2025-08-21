-- Query of the One Trillion Row Challenge to calculate the
-- min/max/avig of measure.
SELECT station, min(measure), max(measure), avg(measure)
FROM measurements_1trc
GROUP BY station
ORDER BY station;

