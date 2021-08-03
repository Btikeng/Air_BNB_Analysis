CREATE TABLE listings (
	id  INT Not NULL,
	name VARCHAR (500) NOT NULL,
	host_id INT NOT NULL,
	host_name VARCHAR (500) NOT NULL,
	neighbourhood_group (500) VARCHAR NOT NULL,
	neighbourhood (500) VARCHAR NOT NULL,
	latitude VARCHAR (50) NOT NULL,
	longitude VARCHAR (50) NOT NULL,
	room_type VARCHAR (500) NOT NULL,
	price INT NOT NULL,
	minimum_nights INT NOT NULL,
	number_of_reviews INT NOT NULL,
	last_review DATE NOT NULL,
	reviews_per_month VARCHAR NOT NULL,
	calculated_host_listings_count INT NOT NULL,
	availability_365 INT NOT NULL	
);

CREATE TABLE clean_calendar (
	listing_id INT NOT NULL,
	date DATE,
	available VARCHAR (50) NOT NULL,
	price INT NOT NULL,
	adjusted_price INT NOT NULL,
	minimum_nights INT NOT NULL,
	maximum_nights INT NOT NULL

);

CREATE TABLE neighbourhoods (
	neighbourhood_group varchar (500) NOT NULL,
	neighbourhood varchar (500) NOT NULL,

);

CREATE TABLE reviews (
	listing_id INT NOT NULL,
	date DATE

);

SELECT * FROM calendar;
SELECT * FROM listings;
SELECT * FROM neighbourhoods;
SELECT * FROM reviews;

--Q# 01: What is the total of bookings price per quarter and year?
SELECT extract(year from last_review) AS Year,
 extract(QUARTER from last_review) AS Quarter, SUM(price) AS Total_Booking_Price
FROM listings
WHERE last_review IS NOT NULL 
GROUP BY extract(YEAR from last_review),extract(QUARTER from last_review)
ORDER BY 1,2;


--Q# 02: What is the neighbourhood with the most bookings? 

SELECT neighbourhood, SUM(price) Total_Booking
FROM Listings
GROUP BY neighbourhood
HAVING SUM(price) =(SELECT MAX(Total_Booking) AS Total_Booking
	FROM (
		SELECT neighbourhood, SUM(price) AS Total_Booking
		FROM Listings
		GROUP BY neighbourhood
	) AS TBLa);
	
--Q# 03: What property has the least bookings price?

SELECT room_type, SUM(price) Total_Booking
FROM Listings
GROUP BY room_type
HAVING SUM(price) =(SELECT MIN(Total_Booking) AS Total_Booking
	FROM (
		SELECT room_type, SUM(price) AS Total_Booking
		FROM Listings
		GROUP BY room_type
	) AS TBLa);
	
--Q# 04: What property has the most bookings price?

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
	
	
--Q# 07: How many rooms type are available?

SELECT COUNT(DISTINCT room_type) AS No_of_Rooms_Type
FROM Listings;


--Q# 08: What is the average booking price? 

SELECT AVG(price) AS Average_Booking_Price
FROM Listings;


--Q# 09: In Minimum how many nights should I post my listing for booking?

SELECT MIN(minimum_nights) AS minimum_nights
FROM Listings
WHERE number_of_reviews=(SELECT MAX(number_of_reviews) FROM Listings);









