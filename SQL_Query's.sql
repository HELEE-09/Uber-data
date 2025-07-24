create database uberdb;---creation of database
use uberdb;--using database


-- creating table Uber_Data$ from import data using Wizard 

--1.TOP 10
USE uberdb;
GO
SELECT TOP 10 * FROM Uber_Data$; 

--2.TOTAL REQUESTS PER TIME SLOT
SELECT time_slot, COUNT(*) AS total_requests
FROM Uber_Data$
GROUP BY time_slot
ORDER BY total_requests DESC;

--3.REQUEST STATUS COUNT PER PICKUP POINT
SELECT pickup_point, status, COUNT(*) AS total_requests
FROM Uber_Data$
GROUP BY pickup_point, status
ORDER BY pickup_point, total_requests DESC;

--4.REQUEST STATUS BY TIME SLOT
SELECT time_slot, status, COUNT(*) AS request_count
FROM Uber_Data$
GROUP BY time_slot, status
ORDER BY time_slot, request_count DESC;

--5.MOST 'NO CARS AVAILAIBLE' REQUESTS BY TIME SLOT
SELECT time_slot, COUNT(*) AS no_cars_count
FROM Uber_Data$
WHERE status = 'No Cars Available'
GROUP BY time_slot
ORDER BY no_cars_count DESC;

--6.MOST CANCELLATIONS BY PICKUP POINT
SELECT pickup_point, COUNT(*) AS cancelled_count
FROM Uber_Data$
WHERE status = 'Cancelled'
GROUP BY pickup_point
ORDER BY cancelled_count DESC;

--7.FULFILLMENT RATE BY PICKUP POINT
SELECT pickup_point,
       COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) AS fulfilled,
       COUNT(*) AS total_requests,
       CAST(COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS fulfillment_rate
FROM Uber_Data$
GROUP BY pickup_point
ORDER BY fulfillment_rate DESC;

--8.TOTAL REQUESTS BY PICKUP POINT
SELECT pickup_point, COUNT(*) AS total_requests
FROM Uber_Data$
GROUP BY pickup_point
ORDER BY total_requests DESC;

--9.TOTAL TRIPS COMPLETED BY TIME SLOT 
SELECT time_slot, COUNT(*) AS completed_trips
FROM Uber_Data$
WHERE status = 'Trip Completed'
GROUP BY time_slot
ORDER BY completed_trips DESC;

--10.TOTAL CANCELLATION PER HOUR
SELECT DATEPART(HOUR, request_timestamp) AS request_hour,
       COUNT(*) AS cancelled_count
FROM Uber_Data$
WHERE status = 'Cancelled'
GROUP BY DATEPART(HOUR, request_timestamp)
ORDER BY cancelled_count DESC;

--11.TRIP COMPLETION RATE BY TIMESLOT
SELECT time_slot,
       COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) AS completed,
       COUNT(*) AS total_requests,
       CAST(COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completion_rate
FROM Uber_Data$
GROUP BY time_slot
ORDER BY completion_rate DESC;

--12.REQUESTS WITH MISSING DROP TIMESTAMP--(identify failed trips)
SELECT COUNT(*) AS missing_drop_timestamp
FROM [Uber_Data$]
WHERE TRY_CONVERT(DATETIME, drop_timestamp) IS NULL;

--13.REQUESTS GROUPED BY STATUS AND TIMESLOT
SELECT status, time_slot, COUNT(*) AS count
FROM Uber_Data$
GROUP BY status, time_slot
ORDER BY status, count DESC;

--14.CANCELLED REQUESTS AT AIRPORT BY TIME SLOT
SELECT time_slot, COUNT(*) AS cancelled_requests
FROM Uber_Data$
WHERE pickup_point = 'Airport' AND status = 'Cancelled'
GROUP BY time_slot
ORDER BY cancelled_requests DESC;

--15.TOP TIMESLOTS WITH HIGHEST TRIP SUCCESS (Completed % over 40%)
SELECT time_slot,
       COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) AS completed,
       COUNT(*) AS total,
       CAST(COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completion_percent
FROM Uber_Data$
GROUP BY time_slot
--HAVING CAST(COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) > 60
HAVING CAST(COUNT(CASE WHEN status = 'Trip Completed' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) > 40
ORDER BY completion_percent DESC;

--16.DRIVER AVAILABILITY TREND – How Many Unique Drivers Per Time Slot
SELECT time_slot, COUNT(DISTINCT driver_id) AS unique_drivers
FROM Uber_Data$
WHERE driver_id IS NOT NULL
GROUP BY time_slot
ORDER BY unique_drivers DESC;

--17.CANCELLATION RATIO PER PICKUP POINT
SELECT pickup_point,
       COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled,
       COUNT(*) AS total,
       CAST(COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS cancellation_ratio
FROM Uber_Data$
GROUP BY pickup_point
ORDER BY cancellation_ratio DESC;