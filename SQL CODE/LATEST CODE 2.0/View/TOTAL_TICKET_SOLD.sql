--total ticket sold
CREATE VIEW TOTAL_TICKET_SOLD AS
SELECT CON_TITLE, 
	   COUNT( TICKET_ID ) AS TICKETS_SOLD,
	   SEAT_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / SEAT_CAPACITY ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM TICKET T
		LEFT OUTER JOIN CONCERT C
		ON C.CON_ID = T.CON_ID
		LEFT OUTER JOIN THEATRE TT
		ON C.THEATRE_ID = TT.THEATRE_ID
WHERE T.BOOKING_ID IS NOT NULL
GROUP BY ( CON_TITLE, SEAT_CAPACITY )@
