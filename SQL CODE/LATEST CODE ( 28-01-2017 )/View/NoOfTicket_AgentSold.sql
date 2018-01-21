--[No of ticket sold by agent -> rewards ]
SELECT  AGENT_FNAME, 
AGENT_LNAME,
COUNT(NT.TICKET_ID) AS NORMAL_SOLD,
COUNT(VT.TICKET_ID) AS VIP_SOLD,
COUNT(NT.TICKET_ID) + COUNT(VT.TICKET_ID) AS TOTAL_SOLD
FROM TICKET TK
LEFT OUTER JOIN NORMAL_TICKET NT
ON TK.TICKET_ID = NT.TICKET_ID
AND TK.CON_ID = NT.CON_ID
LEFT OUTER JOIN VIP_TICKET VT
ON TK.TICKET_ID = VT.TICKET_ID
AND TK.CON_ID = VT.CON_ID
LEFT OUTER JOIN BOOKING BK
ON BK.BOOKING_ID = TK.BOOKING_ID
LEFT OUTER JOIN AGENT AG
ON BK.AGENT_ID = AG.AGENT_ID
WHERE TK.BOOKING_ID IS NOT NULL
GROUP BY ( AGENT_FNAME, AGENT_LNAME )@