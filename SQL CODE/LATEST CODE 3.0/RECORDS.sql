-- THEATRE
INSERT INTO THEATRE VALUES ( 'TT0000','Stadium Merdeka', 'Bukit Jalil', 50, 10, 6 )@
INSERT INTO THEATRE VALUES ( 'TT0001','Stadium Arena', 'Genting Highland', 100, 30, 4 )@
INSERT INTO THEATRE VALUES ( 'TT0002','Grand Hall', 'MMU Cyberjaya', 50, 55, 6 )@

-- CONCERT
INSERT INTO CONCERT VALUES ( 'CN0000', 'The Invincible', 'Jay Chou', '2017-01-27', '20:00:00', '23:00:00', 5000.00, 1000.0, 'TT0000' )@
INSERT INTO CONCERT VALUES ( 'CN0001', 'Maroon 5 Genting', 'Maroon 5', '2017-12-31', '20:00:00', '23:00:00', 200.00, 100.0, 'TT0001' )@
INSERT INTO CONCERT VALUES ( 'CN0002', 'Party Rock!', '-KHUN-', '2017-05-22', '20:00:00', '23:00:00', 200.00, 100.0, 'TT0002' )@

-- CUSTOMER
INSERT INTO CUSTOMER VALUES ( 'CS0000', 'GOH', 'KUN SHUN', 19, 'M' )@
INSERT INTO CUSTOMER VALUES ( 'CS0001', 'CHRISTOPHER', 'TOO WEI BIN', 19, 'M' )@
INSERT INTO CUSTOMER VALUES ( 'CS0002', 'JOHN', 'ESCOBIA', 19, 'M' )@
INSERT INTO CUSTOMER VALUES ( 'CS0003', 'NG', 'JING KEONG', 19, 'M' )@
INSERT INTO CUSTOMER VALUES ( 'CS0004', 'ONG', 'SHU YU', 19, 'F' )@
INSERT INTO CUSTOMER VALUES ( 'CS0005', 'CHEW', 'PEI SHAN', 19, 'F' )@
INSERT INTO CUSTOMER VALUES ( 'CS0006', 'TEE', 'WEI WEI', 19, 'F' )@
INSERT INTO CUSTOMER VALUES ( 'CS0007', 'ABBY', 'LOW', 20, 'F' )@

-- AGENT
INSERT INTO AGENT VALUES ( 'AG0000', 'ELON', 'MUSK', 45, 'M' )@
INSERT INTO AGENT VALUES ( 'AG0001', 'BILL', 'GATES', 61, 'M' )@
INSERT INTO AGENT VALUES ( 'AG0002', 'NEIL', 'TYSON', 58, 'M' )@
INSERT INTO AGENT VALUES ( 'AG0003', 'STEPHEN', 'HAWKING', 75, 'M' )@
INSERT INTO AGENT VALUES ( 'AG0004', 'WARREN', 'BUFFET', 86, 'M' )@
INSERT INTO AGENT VALUES ( 'AG0005', 'OPRAH', 'WINFREY', 62, 'F' )@
INSERT INTO AGENT VALUES ( 'AG0006', 'HEDY', 'LAMARR', 85, 'F' )@

-- BOOKING
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0000', 'CS0000', 'AG0000' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0001', 'CS0004', 'AG0006' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0002', 'CS0005', 'AG0006' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0003', 'CS0004', 'AG0003' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0004', 'CS0003', 'AG0005' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0005', 'CS0007', 'AG0002' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0006', 'CS0006', 'AG0005' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0007', 'CS0003', 'AG0004' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0008', 'CS0002', 'AG0001' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0009', 'CS0001', 'AG0002' )@
INSERT INTO BOOKING ( Booking_ID, Cus_ID, Agent_ID ) VALUES ( 'BK0010', 'CS0004', 'AG0006' )@

-- TICKET

-- Trying to book one expired concert’s ticket, and one available ticket 	
UPDATE TICKET
SET Booking_ID = 'BK0000'
WHERE Ticket_ID = 'TK0049' AND Con_ID = 'CN0000' OR		-- Expired concert
	  Ticket_ID = 'TK0050' AND Con_ID = 'CN0001'@		-- Okay concert
-- Check the outcome
SELECT * FROM TICKET 
WHERE ( Ticket_ID = 'TK0049' AND Con_ID = 'CN0000' ) OR
	  ( Ticket_ID = 'TK0050' AND Con_ID = 'CN0001' )@

-- Trying to book different ticket types
UPDATE TICKET
SET Booking_ID = 'BK0001'								
WHERE Ticket_ID = 'TK0029' AND Con_ID = 'CN0001' OR		-- VIP ticket
	  Ticket_ID = 'TK0030' AND Con_ID = 'CN0001'@		-- Normal ticket
-- Check the outcome
SELECT * FROM TICKET 
WHERE Ticket_ID = 'TK0029' AND Con_ID = 'CN0001' OR
	  Ticket_ID = 'TK0030' AND Con_ID = 'CN0001'@
  
-- Trying to book 2 invalid tickets
UPDATE TICKET
SET Booking_ID = 'BK0002'
WHERE Ticket_ID = 'TK0029' AND Con_ID = 'CN0001' OR		-- Booked ticket
	  Ticket_ID = 'TK9999' AND Con_ID = 'CN0001'@		-- Invalid ticket ID
-- Check the outcome
SELECT * FROM TICKET 
WHERE Ticket_ID = 'TK0029' AND Con_ID = 'CN0001' OR
	  Ticket_ID = 'TK9999' AND Con_ID = 'CN0001'@
  
-- Booking multiple tickets with BETWEEN
UPDATE TICKET
SET Booking_ID = 'BK0004'
WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0010' AND 'TK0025'@
-- Check the outcome
SELECT * FROM TICKET 
WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0010' AND 'TK0025'@

-- Booking using subquery
UPDATE TICKET
SET Booking_ID = 'BK0004'
WHERE Ticket_ID = 'TK0000' AND
	  Con_ID IN ( SELECT Con_ID
				  FROM CONCERT
				  WHERE Con_Date > '2017-06-01' )@
-- Check the outcome
SELECT * FROM TICKET 
WHERE Ticket_ID = 'TK0000' AND
	  Con_ID IN ( SELECT Con_ID
				  FROM CONCERT
				  WHERE Con_Date > '2017-06-01' )@	  
	  
-- Booking using multi-level subqueries and LIKE
UPDATE TICKET
SET Booking_ID = 'BK0005'
WHERE Ticket_ID = 'TK0001' AND 
	  Con_ID IN ( SELECT Con_ID
	   			  FROM CONCERT
				  WHERE Theatre_ID IN ( SELECT Theatre_ID
									    FROM THEATRE 
									    WHERE Theatre_Name LIKE 'Stadium%' ) )@
-- Check the outcome
SELECT * FROM TICKET 
WHERE Ticket_ID = 'TK0001' AND 
	  Con_ID IN ( SELECT Con_ID
	   			  FROM CONCERT
				  WHERE Theatre_ID IN ( SELECT Theatre_ID
									    FROM THEATRE 
									    WHERE Theatre_Name LIKE 'Stadium%' ) )@
						   

-- VIP only
UPDATE TICKET
SET Booking_ID = 'BK0006'
WHERE Con_ID = 'CN0002' AND
	  Ticket_ID BETWEEN 'TK0000' AND 'TK0005' AND
	  Ticket_Type = 'VIP'@
-- Check the outcome
SELECT * FROM TICKET
WHERE Con_ID = 'CN0002' AND
	  Ticket_ID BETWEEN 'TK0000' AND 'TK0005' AND
	  Ticket_Type = 'VIP'@
	  
-- Book normal only
UPDATE TICKET
SET Booking_ID = 'BK0007'
WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0025' AND 'TK0035' AND
	  TICKET_TYPE = 'NORMAL'@
-- Check the outcome
SELECT * FROM TICKET
WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0025' AND 'TK0035' AND
	  TICKET_TYPE = 'NORMAL'@
		
-- Booking ticket based on price
UPDATE TICKET
SET Booking_ID = 'BK0008'
WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0025' AND 'TK0035' AND
	  Ticket_Price > 100.0@
-- Check the outcome
SELECT * FROM TICKET
	  WHERE Con_ID = 'CN0001' AND
	  Ticket_ID BETWEEN 'TK0025' AND 'TK0035' AND
	  Ticket_Price > 100.0@
	  
-- Aggregate function
-- Depend on price
UPDATE TICKET
SET Booking_ID = 'BK0009'
WHERE ( Con_ID = 'CN0001' OR Con_ID = 'CN0002' ) AND
	  ( Ticket_ID BETWEEN 'TK0040' AND 'TK0044' ) AND
	  Ticket_Price < ( SELECT AVG( Ticket_Price )
					   FROM TICKET
					   GROUP BY Con_ID
					   HAVING Con_ID = 'CN0002' )@
-- Check the outcome
SELECT * FROM TICKET 
WHERE ( Con_ID = 'CN0001' OR Con_ID = 'CN0002' ) AND
	  ( Ticket_ID BETWEEN 'TK0040' AND 'TK0044' ) AND
	  Ticket_Price < ( SELECT AVG( Ticket_Price )
					   FROM TICKET
					   GROUP BY Con_ID
					   HAVING Con_ID = 'CN0002' )@