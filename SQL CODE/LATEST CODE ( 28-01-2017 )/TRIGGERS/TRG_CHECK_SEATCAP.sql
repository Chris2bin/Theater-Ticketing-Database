CREATE TRIGGER TRG_CHECK_SEATCAP
BEFORE INSERT ON THEATRE
REFERENCING NEW AS N
FOR EACH ROW MODE DB2SQL
BEGIN	
	IF N.VIP_Count > N.Seat_Capacity
		THEN
			CALL DBMS_OUTPUT.PUT( 'VIP count exceeded seat capacity. VIP count is set to seat capacity instead.' );
			CALL DBMS_OUTPUT.NEW_LINE;
	ELSE
		SET N.VIP_Count = N.Seat_Capacity;
	END IF;
END@