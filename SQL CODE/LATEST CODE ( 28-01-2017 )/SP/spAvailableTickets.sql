CREATE PROCEDURE spAvailableTickets( IN concertID CHAR(6) )
    BEGIN
        DECLARE c cursor with return for
            SELECT DISTINCT TICKET.TICKET_ID AS AVAILABLE_TICKETS, TICKET.TICKET_TYPE, TICKET.TICKET_PRICE
            FROM TICKET, BOOKING, CONCERT
            WHERE TICKET.BOOKING_ID IS NULL
            AND concertID = CONCERT.CON_ID
            AND concertID = TICKET.CON_ID
            ORDER BY TICKET.TICKET_ID;
        OPEN c;
    END@
