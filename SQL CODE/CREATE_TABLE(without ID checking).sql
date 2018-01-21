CREATE TABLE THEATRE
( Theatre_ID CHAR(6) NOT NULL, --CHECK (Theatre_ID like 'TT[0-9][0-9][0-9][0-9]' ),
  Theatre_Name VARCHAR(20) NOT NULL,
  Theatre_Venue VARCHAR(20) NOT NULL,
  Seat_Capacity INT NOT NULL CHECK (Seat_Capacity BETWEEN 500 AND 5000),
  VIP_COUNT DECIMAL(3,2) CHECK (VIP_COUNT BETWEEN 0.00 AND 1.00),
  Zone_Count INT NOT NULL CHECK (Zone_Count BETWEEN 1 AND 10),
  PRIMARY KEY (Theatre_ID)
);


CREATE TABLE CONCERT(
Con_ID CHAR(6) NOT NULL, --CHECK (Con_ID like '[C][N][0-9][0-9][0-9][0-9]' ),
Con_Title VARCHAR(20) NOT NULL,
Con_Artist VARCHAR(20),
Con_TimeStart Time,
Con_TimeEnd Time,
Date DATE NOT NULL,
Theatre_ID CHAR(6), --CHECK (Theatre_ID like '[T][T][0-9][0-9][0-9][0-9]' ),
PRIMARY KEY (Con_ID),
FOREIGN KEY (Theatre_ID) REFERENCES THEATRE(Theatre_ID)
);


CREATE TABLE CUSTOMER(
Cus_ID CHAR(6) NOT NULL, -- CHECK (Cus_ID like '[C][S][0-9][0-9][0-9][0-9]' ),
Cus_FName VARCHAR(15) NOT NULL,
Cus_LName VARCHAR(15) NOT NULL,
Cus_Age INTEGER,
Cus_Gender CHAR(1) NOT NULL,
PRIMARY KEY (Cus_ID)
);


CREATE TABLE AGENT(
Agent_ID CHAR(6) NOT NULL, -- CHECK (Agent_ID like '[A][G][0-9][0-9][0-9][0-9]' ),
Agent_FName VARCHAR(15) NOT NULL,
Agent_LName VARCHAR(15) NOT NULL,
Agent_Age INTEGER,
Agent_Gender CHAR(1) NOT NULL,
PRIMARY KEY (Agent_ID)
);

CREATE TABLE BOOKING(
Booking_ID CHAR(6) NOT NULL, -- CHECK (Booking_ID like '[B][K][0-9][0-9][0-9][0-9]' ),
Cus_ID CHAR(6) NOT NULL, -- CHECK (Cus_ID like '[C][S][0-9][0-9][0-9][0-9]' ),
Agent_ID CHAR(6) NOT NULL, -- CHECK (Agent_ID like '[A][G][0-9][0-9][0-9][0-9]' ),
Booking_Time TIMESTAMP NOT NULL,
Total_Price DECIMAL(8,2),
PRIMARY KEY (Booking_ID),
FOREIGN KEY (Cus_ID) REFERENCES CUSTOMER (Cus_ID),
FOREIGN KEY (Agent_ID) REFERENCES AGENT (Agent_ID)
);

CREATE TABLE TICKET(
Ticket_ID CHAR(6) NOT NULL, -- CHECK (Ticket_ID like '[T][K][0-9][0-9][0-9][0-9]' ),
Ticket_Price DECIMAL(5,2) CHECK (Ticket_Price BETWEEN 0 AND 9999.99),
Ticket_Type VARCHAR(6),
Con_ID CHAR(6) NOT NULL, -- CHECK (Con_ID like '[C][N][0-9][0-9][0-9][0-9]' ),
Booking_ID CHAR(6) NOT NULL, -- CHECK (Booking_ID like '[B][K][0-9][0-9][0-9][0-9]' ),
PRIMARY KEY (Ticket_ID),
FOREIGN KEY (Con_ID) REFERENCES CONCERT (Con_ID),
FOREIGN KEY (Booking_ID) REFERENCES BOOKING (Booking_ID)
);

CREATE TABLE VIP_TICKET(
Ticket_ID CHAR(6) NOT NULL, -- CHECK (Ticket_ID like '[T][K][0-9][0-9][0-9][0-9]' ),
Con_ID CHAR(6) NOT NULL, -- CHECK (Con_ID like '[A][G][0-9][0-9][0-9][0-9]' ),
Seat_No CHAR(5) NOT NULL, -- CHECK (Seat_No like '[A-Z][0-9][0-9][0-9][0-9]' ),
PRIMARY KEY (Ticket_ID,Con_ID),
FOREIGN KEY (Ticket_ID) REFERENCES TICKET (Ticket_ID),
FOREIGN KEY (Con_ID) REFERENCES Concert (Con_ID)
);

CREATE TABLE NORMAL_TICKET(
Ticket_ID CHAR(6) NOT NULL, -- CHECK (Ticket_ID like '[T][K][0-9][0-9][0-9][0-9]' ),
Con_ID CHAR(6) NOT NULL, -- CHECK (Con_ID like '[A][G][0-9][0-9][0-9][0-9]' ),
Zone_No CHAR(5) NOT NULL, -- CHECK (Zone_No like '[A-Z][0-9][0-9][0-9][0-9]' ),
PRIMARY KEY (Ticket_ID,Con_ID),
FOREIGN KEY (Ticket_ID) REFERENCES TICKET (Ticket_ID),
FOREIGN KEY (Con_ID) REFERENCES Concert (Con_ID)
);