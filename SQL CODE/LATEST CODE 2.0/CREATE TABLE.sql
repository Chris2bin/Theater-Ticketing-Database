CREATE TABLE THEATRE
(
	Theatre_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Theatre_ID BETWEEN 'TT0000' AND 'TT9999' ),
	Theatre_Name 	VARCHAR( 20 ) 	NOT NULL,
	Theatre_Venue 	VARCHAR( 20 ) 	NOT NULL,
	Seat_Capacity 	INTEGER 		NOT NULL 	CHECK ( Seat_Capacity BETWEEN 50 AND 125000 ),
	VIP_Count 		INTEGER 		NOT NULL,
	Zone_Count 		INTEGER 		NOT NULL 	CHECK ( Zone_Count BETWEEN 1 AND 6 ),
	PRIMARY KEY ( Theatre_ID )
)@

CREATE TABLE CONCERT
(
	Con_ID 			CHAR( 6 )		NOT NULL 	CHECK ( Con_ID BETWEEN 'CN0000' AND 'CN9999' ),
	Con_Title 		VARCHAR( 20 ) 	NOT NULL,
	Con_Artist 		VARCHAR( 20 ),
	Con_Date 		DATE 			NOT NULL,
	Con_TimeStart 	TIME 			NOT NULL,
	Con_TimeEnd 	TIME 			NOT NULL,
	VIP_Price 		DECIMAL( 6, 2 ) NOT NULL,
	Normal_Price 	DECIMAL( 6, 2 ) NOT NULL,	
	Theatre_ID 		CHAR( 6 ) 		NOT NULL,
	PRIMARY KEY ( Con_ID ),
	FOREIGN KEY ( Theatre_ID ) REFERENCES THEATRE( Theatre_ID ) ON DELETE CASCADE
)@

CREATE TABLE CUSTOMER
(
	Cus_ID 			CHAR( 6 ) 		NOT NULL 	CHECK ( Cus_ID BETWEEN 'CS0000' AND 'CS9999' ),
	Cus_FName 		VARCHAR( 15 ) 	NOT NULL,
	Cus_LName 		VARCHAR( 15 ) 	NOT NULL,
	Cus_Age 		INTEGER,
	Cus_Gender 		CHAR( 1 ) 		NOT NULL,
	PRIMARY KEY ( Cus_ID )
)@

CREATE TABLE AGENT
(
	Agent_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Agent_ID BETWEEN 'AG0000' AND 'AG9999' ),
	Agent_FName 	VARCHAR( 15 ) 	NOT NULL,
	Agent_LName 	VARCHAR( 15 ) 	NOT NULL,
	Agent_Age 		INTEGER,
	Agent_Gender 	CHAR( 1 ) 		NOT NULL,
	PRIMARY KEY ( Agent_ID )
)@

CREATE TABLE BOOKING
(
	Booking_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Booking_ID BETWEEN 'BK0000' AND 'BK9999' ),
	Cus_ID 			CHAR( 6 ) 		NOT NULL,
	Agent_ID 		CHAR( 6 ) 		NOT NULL,
	Booking_Time 	TIMESTAMP 		NOT NULL,
	Total_Price 	DECIMAL( 8, 2 ) NOT NULL 	DEFAULT 0.0,
	PRIMARY KEY ( Booking_ID ),
	FOREIGN KEY ( Cus_ID ) 	 REFERENCES CUSTOMER( Cus_ID ),
	FOREIGN KEY ( Agent_ID ) REFERENCES AGENT   ( Agent_ID )
)@

CREATE TABLE TICKET
(
	Ticket_ID 		CHAR( 6 )		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL,
	Ticket_Price 	DECIMAL( 6, 2 ) NOT NULL 	CHECK ( Ticket_Price BETWEEN 0 AND 9999.99 ),
	Ticket_Type 	VARCHAR( 6 ) 	NOT NULL,
	Booking_ID 		CHAR( 6 ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Con_ID ) 	   REFERENCES CONCERT ( Con_ID ) ON DELETE CASCADE,
	FOREIGN KEY ( Booking_ID ) REFERENCES BOOKING ( Booking_ID ) ON DELETE CASCADE
)@
	  
CREATE TABLE VIP_TICKET
(
	Ticket_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL 	CHECK ( Con_ID BETWEEN 'CN0000' AND 'CN9999' ),
	Seat_No 		CHAR( 5 ) 		NOT NULL 	CHECK ( Seat_No BETWEEN 'V0000' AND 'V9999' ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Ticket_ID, Con_ID ) REFERENCES TICKET ( Ticket_ID, Con_ID ) ON DELETE CASCADE
)@

CREATE TABLE NORMAL_TICKET
(
	Ticket_ID 		CHAR( 6 ) 		NOT NULL 	CHECK ( Ticket_ID BETWEEN 'TK0000' AND 'TK9999' ),
	Con_ID 			CHAR( 6 ) 		NOT NULL 	CHECK ( Con_ID BETWEEN 'CN0000' AND 'CN9999' ),
	Zone_No 		CHAR( 1 ) 		NOT NULL 	CHECK ( Zone_No BETWEEN 'A' AND 'F' ),
	PRIMARY KEY ( Ticket_ID, Con_ID ),
	FOREIGN KEY ( Ticket_ID, Con_ID ) REFERENCES TICKET ( Ticket_ID, Con_ID ) ON DELETE CASCADE
)@