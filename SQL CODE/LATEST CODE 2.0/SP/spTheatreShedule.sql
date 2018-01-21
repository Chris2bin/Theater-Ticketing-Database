CREATE PROCEDURE spTheatreSchedule( IN theatreID CHAR(6), concertDate DATE )
    BEGIN
        DECLARE c cursor with return for
            SELECT DISTINCT CONCERT.CON_TITLE, CONCERT.CON_TIMESTART, CONCERT.CON_TIMEEND
            FROM CONCERT, THEATRE
            WHERE theatreID = THEATRE.THEATRE_ID
            AND theatreID = CONCERT.THEATRE_ID
            AND concertDate = CONCERT.CON_DATE
            ORDER BY CONCERT.CON_TIMESTART;
        OPEN c;
    END@
