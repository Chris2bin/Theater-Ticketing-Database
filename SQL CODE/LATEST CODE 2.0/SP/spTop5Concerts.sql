CREATE PROCEDURE spTop5Concerts( IN startDate DATE, endDate DATE )
    BEGIN
        DECLARE c cursor with return for
            SELECT CONCERT.CON_TITLE, COUNT(TICKET.TICKET_ID) AS TICKETS_SOLD
            FROM CONCERT, TICKET, BOOKING
            WHERE CONCERT.CON_DATE BETWEEN startDate AND endDate
            AND BOOKING.BOOKING_ID = TICKET.BOOKING_ID
            AND  CONCERT.CON_ID = TICKET.CON_ID
            GROUP BY CONCERT.CON_TITLE
            ORDER BY COUNT(TICKET.TICKET_ID) DESC
            LIMIT 5;
        OPEN c;
    END@