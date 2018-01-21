

============================    \\                     //                 ||  ============================
============================      \\                 //					 ||  ============================
============================        \\             //				     ||  ============================
============================	      \\         //				         ||  ============================
============================		    \\     //     				     ||  ============================
============================		      \\ //				             ||  ============================
============================                \/				             ||  ============================
============================         CHECK USING TICKET          ============================
============================                ===========                  ============================
============================              |  WORKING  |                ============================
============================                ===========                  ============================
--total ticket sold
CREATE VIEW TOTAL_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( TICKET_ID ) AS TICKETS_SOLD,
	   SEAT_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / SEAT_CAPACITY ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM TICKET T
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = T.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
GROUP BY ( CON_TITLE, SEAT_CAPACITY );
-- HAVING BOOKING_ID IS NOT NULL;

--normal ticket sold
CREATE VIEW NORMAL_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( TICKET_ID ) AS NORMAL_SOLD,
	   SEAT_CAPACITY - VIP_COUNT AS NORMAL_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / (SEAT_CAPACITY - VIP_COUNT) ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM TICKET T
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = T.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
WHERE TICKET_TYPE = 'NORMAL'
GROUP BY ( CON_TITLE, SEAT_CAPACITY, VIP_COUNT );
-- HAVING BOOKING_ID IS NOT NULL;

--vip ticket sold
CREATE VIEW VIP_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( TICKET_ID ) AS VIP_SOLD,
	   VIP_COUNT AS VIP_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / (VIP_COUNT) ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM TICKET T
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = T.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
WHERE TICKET_TYPE = 'VIP'
GROUP BY ( CON_TITLE, VIP_COUNT );
-- HAVING BOOKING_ID IS NOT NULL;

============================    \\                     //             ******             ============================
============================      \\                 //			  **          **          ============================
============================        \\             //			**	           **       ============================
============================	      \\         //				**             **         ============================
============================		    \\     //     				          **            ============================
============================		      \\ //				              **                ============================
============================                \/				     ************     ============================
============================                MORE EFFICIENT                         ============================
============================         CHECK USING VIP_TICKET                 ============================
============================                            AND                                  ============================
============================                  NORMAL_TICKET                       ============================

--total ticket sold
CREATE VIEW TOTAL_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( TICKET_ID ) AS TICKETS_SOLD,
	   SEAT_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / SEAT_CAPACITY ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM TICKET T
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = T.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
LEFT OUTER JOIN BOOKING B
ON B.BOOKING_ID = T.BOOKING_ID
WHERE T.BOOKING_ID IS NOT NULL
GROUP BY ( CON_TITLE, SEAT_CAPACITY );




--normal ticket sold
CREATE VIEW NORMAL_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( NT.TICKET_ID ) AS NORMAL_SOLD,
	   SEAT_CAPACITY - VIP_COUNT AS NORMAL_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( NT.TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / (SEAT_CAPACITY - VIP_COUNT) ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM NORMAL_TICKET NT
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = NT.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
LEFT OUTER JOIN TICKET T
ON NT.TICKET_ID = T.TICKET_ID
AND NT.CON_ID = T.CON_ID
LEFT OUTER JOIN BOOKING B
ON B.BOOKING_ID = T.BOOKING_ID
WHERE T.BOOKING_ID IS NOT NULL
GROUP BY ( CON_TITLE, SEAT_CAPACITY, VIP_COUNT );


--vip ticket sold
CREATE VIEW VIP_TICKET_STATS AS
SELECT CON_TITLE, 
	   COUNT( VT.TICKET_ID ) AS VIP_SOLD,
	   VIP_COUNT AS VIP_CAPACITY,
	   ( CAST( ( ( ( CAST( COUNT( VT.TICKET_ID ) AS DECIMAL ( 7, 3 ) ) ) / (VIP_COUNT) ) * 100) AS DECIMAL ( 5, 2 ) ) ) AS SOLD_PERCENT
FROM VIP_TICKET VT
LEFT OUTER JOIN CONCERT C
ON C.CON_ID = VT.CON_ID
LEFT OUTER JOIN THEATRE TT
ON C.THEATRE_ID = TT.THEATRE_ID
LEFT OUTER JOIN TICKET T
ON VT.TICKET_ID = T.TICKET_ID
AND VT.CON_ID = T.CON_ID
LEFT OUTER JOIN BOOKING B
ON B.BOOKING_ID = T.BOOKING_ID
WHERE T.BOOKING_ID IS NOT NULL
GROUP BY ( CON_TITLE, VIP_COUNT );

