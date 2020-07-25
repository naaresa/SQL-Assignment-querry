--QUESTION 1:  How many users does Wave have? 
SELECT COUNT (u_id) from users;

--QUESTION 2: How many transfers have been sent in the currency CFA?  
SELECT COUNT (transfer_id) FROM transfers WHERE send_amount_currency = 'CFA';

--QUESTION 3:  How many different users have sent a transfer in CFA? 
SELECT COUNT (DISTINCT u_id) FROM transfers WHERE send_amount_currency = 'CFA';

--QUESTION 4: How many agent_transactions did we have in the months of 2018 (broken down by month)?

SELECT COUNT(atx_id) FROM agent_transactions
WHERE EXTRACT (YEAR FROM when_created)='2018'
GROUP BY EXTRACT (MONTH FROM when_created);

--QUESTION 5: Over the course of the last week, how many Wave agents were “net depositors” vs. “net withdrawers”? 
SELECT SUM (CASE WHEN amount < 0 THEN amount ELSE 0 END) AS depositors, 
SUM (CASE WHEN amount > 0 THEN amount ELSE 0 END) AS withdrawers,
CASE WHEN ((SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END)) > ((SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END))) * -1)
THEN 'net withdrawers' ELSE 'net depositors' 
END AS agent_status, COUNT(*)FROM agent_transactions WHERE when_created BETWEEN (NOW() - '1 WEEK'::INTERVAL) AND NOW();

---QUESTION 6:Build an “atx volume city summary” table: find the volume of agent transactions created in the last week, grouped by city. You can determine the city where the agent transaction took place from the agent’s city field. 
SELECT COUNT (atx.amount) AS "atx volume city summary", ag.city
FROM agent_transactions AS atx LEFT OUTER JOIN agents AS ag ON
atx.atx_id = ag.agent_id
WHERE atx.when_created BETWEEN NOW()::DATE-EXTRACT (DOW FROM NOW())::INTEGER-7
AND NOW()::DATE-EXTRACT (DOW FROM NOW())::INTEGER
GROUP BY ag.city;

--QUESTION 7: Now separate the atx volume by country as well (so your columns should be country, city, volume). 
SELECT COUNT(ag.country) AS "country", COUNT (ag.city) AS "city", COUNT (atx.atx_id) AS "volume" 
FROM agent_transactions AS atx INNER JOIN agents AS ag ON
atx.atx_id = ag.agent_id
GROUP BY ag.country;

----QUESTION 8:  Build a “send volume by country and kind” table: find the total volume of transfers (by send_amount_scalar) sent in the past week, grouped by country and transfer kind
SELECT transfers.kind AS Kind, wallets.ledger_location AS Country,
SUM (transfers.send_amount_scalar) AS Volume FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
WHERE (transfers.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY wallets.ledger_location, transfers.kind;

--QUESTION 9:  Then add columns for transaction count and number of unique senders (still broken down by country and transfer kind). 
SELECT COUNT(transfers.source_wallet_id) AS Unique_Senders, 
COUNT (transfer_id) AS Transaction_Count, transfers.kind AS Transfer_Kind, wallets.ledger_location AS Country, 
SUM (transfers.send_amount_scalar) AS Volume FROM transfers 
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id 
WHERE (transfers.when_created > (NOW() - INTERVAL '1 week')) 
GROUP BY wallets.ledger_location, transfers.kind; 

--QUESTION 10: Finally, which wallets have sent more than 10,000,000 CFA in transfers in the last month (as identified by the source_wallet_id column on the transfers table), and how much did they send? 

SELECT u_id, source_wallet_id, send_amount_scalar
FROM transfers WHERE send_amount_currency = 'CFA' 
AND (send_amount_scalar>10000000) 
AND (transfers.when_created > (NOW() - INTERVAL '1 month'))
GROUP BY u_id, source_wallet_id, send_amount_scalar;