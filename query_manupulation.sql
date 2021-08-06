--Q# 01: What is the total of bookings price per quarter and year?

SELECT extract(year from last_review) AS Year,
 extract(QUARTER from last_review) AS Quarter, SUM(price) AS Total_Booking_Price
FROM Listings
WHERE last_review IS NOT NULL 
GROUP BY extract(YEAR from last_review),extract(QUARTER from last_review)
ORDER BY 1,2;

--Q# 02: What is the total number of neighbourhoods with the most bookings? 

SELECT neighbourhood, SUM(price) Total_Booking
FROM Listings
GROUP BY neighbourhood
HAVING SUM(price) =(SELECT MAX(Total_Booking) AS Total_Booking
	FROM (
		SELECT neighbourhood, SUM(price) AS Total_Booking
		FROM Listings
		GROUP BY neighbourhood
	) AS TBLa);


--Q# 03: What is the total number property with least bookings price?

SELECT room_type, SUM(price) Total_Booking
FROM Listings
GROUP BY room_type
HAVING SUM(price) =(SELECT MIN(Total_Booking) AS Total_Booking
	FROM (
		SELECT room_type, SUM(price) AS Total_Booking
		FROM Listings
		GROUP BY room_type
	) AS TBLa);

--Q# 04: What is the total number property with the highest  bookings price?

SELECT room_type, SUM(price) as Total_Booking
FROM Listings
GROUP BY room_type
HAVING SUM(price) =(SELECT max(Total_Booking) AS Total_Booking
	FROM (
		SELECT room_type, SUM(price) AS Total_Booking
		FROM Listings
		GROUP BY room_type
	) AS TBLa);



--Q# 05: What property has the most availability? (Least demand)

SELECT room_type, SUM(availability_365) AS Total_Booking
FROM Listings
GROUP BY room_type
HAVING SUM(availability_365) =(SELECT MAX(Availability) AS Availability
	FROM (
		SELECT room_type, SUM(availability_365) AS Availability
		FROM Listings
		GROUP BY room_type
	) AS TBLa);


--Q# 06: What property has the least availability? (in demand)

SELECT room_type, SUM(availability_365) AS Least_Availability
FROM Listings
GROUP BY room_type
HAVING SUM(availability_365) =(SELECT MIN(Availability) AS Availability
	FROM (
		SELECT room_type, SUM(availability_365) AS Availability
		FROM Listings
		GROUP BY room_type
	) AS TBLa);


--Q# 07: How many rooms type available?

SELECT COUNT(DISTINCT room_type) AS No_of_Rooms_Type
FROM Listings;

--Q# 08: What is the average booking price? 

SELECT AVG(price) AS Average_Booking_Price
FROM Listings;


--Q# 09: Minimum how many nights should I post my listing for booking?

SELECT MIN(minimum_nights) AS minimum_nights
FROM Listings
WHERE number_of_reviews=(SELECT MAX(number_of_reviews) FROM Listings);
