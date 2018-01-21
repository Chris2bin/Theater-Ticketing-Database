CREATE TRIGGER TRG_GEN_CONCERT_TICKET
AFTER INSERT ON CONCERT
REFERENCING NEW AS N
FOR EACH ROW MODE DB2SQL
BEGIN
	-- Declare variables
	DECLARE I INTEGER;			-- Counter = 0
	DECLARE ID CHAR( 6 );		-- Ticket ID
	DECLARE VIP_ID CHAR( 5 );	-- VIP ticket ID
	DECLARE T_TYPE CHAR( 6 );	-- Ticket type
	DECLARE T_ZONE CHAR( 1 );	-- Ticket zone
	DECLARE NO_SEATS INTEGER;	-- Number of seats
	DECLARE NO_VIP INTEGER;		-- Number of VIP_TICKETS
	DECLARE NO_NORM INTEGER;	-- Number of NORMAL_TICKETS
	DECLARE VIP_P DECIMAL( 6, 2 );		-- VIP ticket price
	DECLARE NORM_P DECIMAL( 6, 2 );		-- Normal ticket price
	DECLARE NO_ZONE INTEGER;	-- Number of zones
	
	-- Initialize vairables
	SET I = 0;
	SET VIP_P = ( SELECT VIP_PRICE FROM CONCERT WHERE N.CON_ID = CONCERT.CON_ID );		
	SET NORM_P = ( SELECT NORMAL_PRICE FROM CONCERT WHERE N.CON_ID = CONCERT.CON_ID );
	SET NO_SEATS = ( SELECT SEAT_CAPACITY							
					 FROM THEATRE 
					 WHERE N.THEATRE_ID = THEATRE.THEATRE_ID );
	SET NO_VIP = ( SELECT VIP_COUNT									
				   FROM THEATRE 
				   WHERE N.THEATRE_ID = THEATRE.THEATRE_ID );
	SET NO_NORM = NO_SEATS - NO_VIP;
	SET NO_ZONE = ( SELECT ZONE_COUNT									
					FROM THEATRE 
					WHERE N.THEATRE_ID = THEATRE.THEATRE_ID );
	  
	WHILE I < NO_SEATS
	DO
		-- Determine TICKET_ID
		SET ID = ( 'TK' || LPAD( I, 4, 0 ) );
		SET VIP_ID = ( 'V' || LPAD( I, 4, 0 ) );
		
		-- Determine TICKET_TYPE
		IF I < NO_VIP
			THEN
				SET T_TYPE = 'VIP';
				-- Insert the generated VIP_TICKET into TICKET
				INSERT INTO TICKET VALUES ( ID, N.CON_ID, VIP_P, T_TYPE, NULL );
				-- Insert the generated VIP_TICKET into VIP_TICKET
				INSERT INTO VIP_TICKET VALUES ( ID, N.CON_ID, VIP_ID );
		ELSE
			SET T_TYPE = 'NORMAL';
				
				IF I <= ( NO_VIP + ( NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'A';
				ELSEIF I <= ( NO_VIP + ( 2 * NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'B';
				ELSEIF I <= ( NO_VIP + ( 3 * NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'C';
				ELSEIF I <= ( NO_VIP + ( 4 * NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'D';
				ELSEIF I <= ( NO_VIP + ( 5 * NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'E';
				ELSEIF I <= ( NO_VIP + ( 6 * NO_NORM / NO_ZONE ) )
					THEN
						SET T_ZONE = 'F';
				END IF;
			-- Insert the generated NORMAL_TICKET into TICKET
			INSERT INTO TICKET VALUES ( ID, N.CON_ID, NORM_P, T_TYPE, NULL );
			-- Insert the generated NORMAL_TICKET into NORMAL_TICKET
			INSERT INTO NORMAL_TICKET VALUES ( ID, N.CON_ID, T_ZONE );
		END IF;
		
		-- Increase counter by 1
		SET I = I + 1;
		
	END WHILE;
END@