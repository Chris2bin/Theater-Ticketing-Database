--[display amount of ticket available for each concert]
--[percentage of ticket sell, vip, normal] order by -- for now dont need vip and normal
--[No of ticket purchase by a customer -> rewards]
--[No of ticket sold by agent -> rewards ]
--[time schedule for a day in the theatre]

--[discount for senior citizen]---> Might be scraped
--[freebies for those total_price more than specific number]
--[Top ten customer, agent]
--{{{{{{{{check for a day, month, year}}}}}}}}


--1) ticket sold, percentage
--2) 

--check for amount
CREATE VIEW SeatCapacity AS -- Rejected
SELECT Con_Title, Seat_Capacity
FROM CONCERT C, THEATRE T
WHERE T.Theatre_ID = C.Theatre_ID;

--Ticket that are sold
SELECT  CON_ID,  COUNT ( TICKET_ID ) AS TICKET_SOLD
FROM  TICKET
GROUP BY ( CON_ID );

--ticket that are sold VIP AND NORMAL
CREATE VIEW SEAT_STATUS AS
SELECT  CON_TITLE,  
COUNT(CASE WHEN TICKET_TYPE = 'NORMAL' THEN TICKET_TYPE END) AS NORMAL_SOLD,
CAST(ROUND(SEAT_CAPACITY * (1 - VIP_PERCENT), 0)AS INT) AS NORMAL_CAPACITY,
COUNT(CASE WHEN TICKET_TYPE = 'VIP' THEN TICKET_TYPE END) AS VIP_SOLD,
CAST(ROUND(SEAT_CAPACITY * VIP_PERCENT, 0) AS INT) AS VIP_CAPACITY,
SEAT_CAPACITY
FROM  TICKET TK, CONCERT CN, THEATRE TT
WHERE TK.CON_ID = CN.CON_ID
AND TT.THEATRE_ID = CN.THEATRE_ID
GROUP BY ( CON_TITLE, SEAT_CAPACITY, VIP_PERCENT);
--HAVING BOOKING_ID IS NOT NULL;

--percentage of ticket sold
CREATE VIEW PERCENT_SOLD AS
SELECT CON_TITLE,
CAST(CAST(NORMAL_SOLD AS DECIMAL(8,6)) /NORMAL_CAPACITY AS DECIMAL(5,3)) AS N_PERCENT_SOLD,
CAST(CAST(VIP_SOLD AS DECIMAL(8,6)) /VIP_CAPACITY AS DECIMAL(5,3)) AS V_PERCENT_SOLD
FROM SEAT_STATUS;



--total ticket sold
-- CREATE VIEW TOTAL_TICKET_STATS AS
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
-- CREATE VIEW NORMAL_TICKET_STATS AS
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
-- CREATE VIEW VIP_TICKET_STATS AS
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


--REFERENCE
--SELECT COUNT( PERSON_ID ) AS FRIEND_COUNT, 
--	   CAST( ( ( CAST( COUNT( PERSON_ID ) AS DECIMAL( 6, 2 ) ) - 200 ) /  COUNT( PERSON_ID ) ) AS DECIMAL ( 3, 2 ) ) AS PERCENTAGE 
--FROM FRIEND@

-- TEST CAST
SELECT THEATRE_ID, CAST(ROUND(SEAT_CAPACITY * VIP_PERCENT, 0) AS INT) AS VIP_SEAT, CAST(ROUND(SEAT_CAPACITY * (1 - VIP_PERCENT), 0)AS INT) AS NORMAL_SEAT
FROM THEATRE;

-- TESTING 1
CREATE VIEW SEAT_STATUS AS
SELECT  CON_TITLE,  
COUNT(CASE WHEN TICKET_TYPE = 'NORMAL' THEN TICKET_TYPE END) AS NORMAL_SOLD,
CAST(ROUND(SEAT_CAPACITY * (1 - VIP_PERCENT), 0)AS INT) AS NORMAL_SEAT,
COUNT(CASE WHEN TICKET_TYPE = 'VIP' THEN TICKET_TYPE END) AS VIP_SOLD,
CAST(ROUND(SEAT_CAPACITY * VIP_PERCENT, 0) AS INT) AS VIP_SEAT,
SEAT_CAPACITY
--CAST(ROUND((SELECT COUNT(CON_ID) FROM TICKET WHERE TICKET_TYPE = 'NORMAL') / (SEAT_CAPACITY * (1 - VIP_PERCENT)), 5)AS DECIMAL(7,5)) AS N_SOLD_PERCENT,
--CAST(ROUND((SELECT COUNT(CON_ID) FROM TICKET WHERE TICKET_TYPE = 'VIP') / (SEAT_CAPACITY * VIP_PERCENT), 5) AS DECIMAL(7,5)) AS V_SOLD_PERCENT
FROM  TICKET TK, CONCERT CN, THEATRE TT
INNER JOIN (SELECT
CAST(CAST(NORMAL_SOLD AS DECIMAL(8,6)) /NORMAL_SEAT AS DECIMAL(8,6)) ON 
FROM SEAT_STATUS)
WHERE TK.CON_ID = CN.CON_ID
AND TT.THEATRE_ID = CN.THEATRE_ID
GROUP BY ( CON_TITLE, SEAT_CAPACITY, VIP_PERCENT);



TESTING;
SELECT CAST(CAST(NORMAL_SOLD AS DECIMAL(8,6)) /NORMAL_SEAT AS DECIMAL(8,6)),
CAST(CAST(VIP_SOLD AS DECIMAL(8,6)) /VIP_SEAT AS DECIMAL(8,6))
FROM SEAT_STATUS;

CREATE VIEW PERCENT_SOLD AS
SELECT CON_TITLE,
CAST(CAST(NORMAL_SOLD AS DECIMAL(8,6)) /NORMAL_SEAT AS DECIMAL(5,3)) AS N_PERCENT_SOLD,
CAST(CAST(VIP_SOLD AS DECIMAL(8,6)) /VIP_SEAT AS DECIMAL(5,3)) AS V_PERCENT_SOLD
FROM SEAT_STATUS;

DELETE FROM TICKET
     WHERE CON_ID = 'CN0002';

--check for status for the amount of ticket sold (V1)
CREATE VIEW Sales_Status AS
--SELECT Con_Title,  Seat_Capacity, COUNT( Ticket_ID ) AS Ticket_Sold
SELECT COUNT( Ticket_Type ) AS Ticket_Sold
FROM TICKET T1--, CONCERT C, THEATRE T2
--WHERE C.Con_ID = T1.Con_ID
--AND C.Theatre_ID = T2.Theatre_ID
GROUP BY Ticket_ID 
HAVING TICKET_ID IS NOT NULL;
--ORDER BY Ticket_Sold Desc;

--SELECT ticket group by concert id
SELECT  CON_ID,  COUNT ( TICKET_TYPE ) AS TICKET_SOLD
FROM  TICKET
GROUP BY ( CON_ID );



--testing
CREATE VIEW Normal_Sold AS
SELECT COUNT(Ticket_Type)

DROP TABLE AGENT;
DROP TABLE BOOKING;

DROP TABLE CUSTOMER;
DROP TABLE NORMAL_TICKET;

DROP TABLE TICKET;
DROP TABLE VIP_TICKET;

DROP TABLE THEATRE;
DROP TABLE CONCERT;

CREATE TABLE THEATRE
( Theatre_ID CHAR(6) NOT NULL CHECK (Theatre_ID like '[T][T][0-9][0-9][0-9][0-9]' ),
  Theatre_Name VARCHAR(20) ,
  Theatre_Venue VARCHAR(20) ,
  Seat_Capacity INT  CHECK (Seat_Capacity BETWEEN 500 AND 5000),
  VIP_Percent DECIMAL(3,2) CHECK (VIP_Percent BETWEEN 0.00 AND 1.00),
  Zone_Count INT  CHECK (Zone_Count BETWEEN 1 AND 10),
  PRIMARY KEY (Theatre_ID)
);

CREATE TABLE TICKET(
Ticket_ID CHAR(6) NOT NULL, -- CHECK (Ticket_ID like '[T][K][0-9][0-9][0-9][0-9]' ),
Ticket_Price DECIMAL(5,2) CHECK (Ticket_Price BETWEEN 0 AND 9999.99),
Ticket_Type VARCHAR(6),
Con_ID CHAR(6) NOT NULL, -- CHECK (Con_ID like '[C][N][0-9][0-9][0-9][0-9]' ),
PRIMARY KEY (Ticket_ID,Con_ID),
FOREIGN KEY (Con_ID) REFERENCES CONCERT (Con_ID)
);


CREATE TABLE TICKET
(
	Ticket_ID 		CHAR( 6 )		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL,
	Ticket_Price 	DECIMAL( 6, 2 ) NOT NULL 	CHECK ( Ticket_Price BETWEEN 0 AND 9999.99 ),
	Ticket_Type 	VARCHAR( 6 ) 	NOT NULL,
	Booking_ID 		CHAR( 6 ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Con_ID ) 	   REFERENCES CONCERT ( Con_ID ),
	FOREIGN KEY ( Booking_ID ) REFERENCES BOOKING ( Booking_ID )
);

CREATE TABLE NORMAL_TICKET
(
	Ticket_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL 	CHECK ( Con_ID BETWEEN 'CN0000' AND 'CN9999' ),
	Zone_No 		CHAR( 1 ) 		NOT NULL 	CHECK ( Zone_No BETWEEN 'A' AND 'F' ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Ticket_ID, Con_ID ) REFERENCES TICKET ( Ticket_ID, Con_ID )
);

CREATE TABLE VIP_TICKET
(
	Ticket_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL 	CHECK ( Con_ID BETWEEN 'CN0000' AND 'CN9999' ),
	Seat_No 		CHAR( 1 ) 		NOT NULL 	CHECK ( Seat_No BETWEEN 'A' AND 'F' ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Ticket_ID, Con_ID ) REFERENCES TICKET ( Ticket_ID, Con_ID )
);

INSERT INTO CUSTOMER VALUES('CS0001', 'CHRIS', 'TOO', 18, 'M');
INSERT INTO CUSTOMER VALUES('CS0002', 'JAMES', 'NG', 9, 'M');
INSERT INTO CUSTOMER VALUES('CS0003', 'RHINO', 'CHENG', 20, 'M');
INSERT INTO CUSTOMER VALUES('CS0004', 'DESA', 'DENG', 21, 'F');

INSERT INTO AGENT VALUES('AG0001', 'HI', 'FI', 24, 'F');
INSERT INTO AGENT VALUES('AG0002', 'LETITIA', 'LOO', 24, 'F');
--[display amount of ticket available for each concert]
--[percentage of ticket sell, vip, normal] order by -- for now dont need vip and normal
--[No of ticket purchase by a customer -> rewards]
--[No of ticket sold by agent -> rewards ]
--[time schedule for a day in the theatre]
INSERT INTO BOOKING VALUES('BK0001', 'CS0001', 'AG0001', '2017-04-01 08:03:06', 20);
INSERT INTO BOOKING VALUES('BK0002', 'CS0001', 'AG0002', '2017-04-02 09:14:06', 40);
INSERT INTO BOOKING VALUES('BK0003', 'CS0001', 'AG0002', '2017-04-02 09:14:06', 60);
INSERT INTO BOOKING VALUES('BK0004', 'CS0001', 'AG0001', '2017-04-02 09:14:06', 60);

INSERT INTO TICKET VALUES('TK0001',  'CN0001', 10.00, 'NORMAL', 'BK0001');
INSERT INTO TICKET VALUES('TK0002',  'CN0001', 10.00, 'NORMAL', 'BK0001');
INSERT INTO TICKET VALUES('TK0003',  'CN0001', 10.00, 'NORMAL', 'BK0002');
INSERT INTO TICKET VALUES('TK0004',  'CN0001', 10.00, 'NORMAL', 'BK0002');
INSERT INTO TICKET VALUES('TK0005',  'CN0001', 10.00, 'NORMAL', 'BK0002');
INSERT INTO TICKET VALUES('TK0006',  'CN0001', 10.00, 'NORMAL', 'BK0002');
INSERT INTO TICKET VALUES('TK0001', 'CN0002', 30.00, 'VIP', 'BK0003');
INSERT INTO TICKET VALUES('TK0002', 'CN0002', 30.00, 'VIP', 'BK0003');
INSERT INTO TICKET VALUES('TK0003', 'CN0002', 30.00, 'VIP', 'BK0004');
INSERT INTO TICKET VALUES('TK0004', 'CN0002', 30.00, 'VIP', 'BK0004');

INSERT INTO VIP_TICKET VALUES('TK0001', 'CN0002', 'V0001');
INSERT INTO VIP_TICKET VALUES('TK0002', 'CN0002', 'V0002');
INSERT INTO VIP_TICKET VALUES('TK0003', 'CN0002', 'V0003');
INSERT INTO VIP_TICKET VALUES('TK0004', 'CN0002', 'V0004');

INSERT INTO NORMAL_TICKET VALUES('TK0001', 'CN0001', 'A');
INSERT INTO NORMAL_TICKET VALUES('TK0002', 'CN0001', 'A');
INSERT INTO NORMAL_TICKET VALUES('TK0003', 'CN0001', 'A');
INSERT INTO NORMAL_TICKET VALUES('TK0004', 'CN0001', 'A');
INSERT INTO NORMAL_TICKET VALUES('TK0005', 'CN0001', 'B');
INSERT INTO NORMAL_TICKET VALUES('TK0006', 'CN0001', 'B');

SELECT * FROM CONCERT;
SELECT * FROM THEATRE;
SELECT * FROM TICKET;
SELECT * FROM VIP_TICKET;
SELECT * FROM NORMAL_TICKET;
SELECT * FROM CUSTOMER;
SELECT * FROM AGENT;
SELECT * FROM BOOKING;
SELECT * FROM NORMAL_TICKET_STATS;
SELECT * FROM VIP_TICKET_STATS;
SELECT * FROM TOTAL_TICKET_STATS;