-- A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

-- First we get the crime scene report for the details we have.
SELECT *  
FROM crime_scene_report 
WHERE type = 'murder' AND date = '20180115' AND city = 'SQL City';

-- Now from the info we have we can find the witnesses to get more details on the crime
-- For the first witness:
SELECT * 
FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number desc
LIMIT 1;

-- For the second witness:
SELECT * 
FROM person 
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave';

-- Next to get their witness report  we use the interview table to retrieve the data for the witnesses of the murder.
SELECT * 
FROM interview 
WHERE person_id IN (14887, 16371);

-- Using the transcript from both witnesses we can try to trace the murderer from the details provided
SELECT * 
FROM get_fit_now_check_in 
WHERE membership_id  
LIKE '48Z%' AND check_in_date LIKE '%0109'

-- With the details we have been able to streamline, we will try to get more details on the two suspects we have and match it with other details since we know the member is a gold member and has a plate_number with "H42W".included.

-- To solve this new challenge we will have to read Jeremy’s transcript from the interview.

SELECT * 
FROM interview 
WHERE person_id = '67318'

-- To find the exact person in one query, we use; 
SELECT 
  d.*, 
  p.id, 
  p.name 
FROM drivers_license AS d
  LEFT JOIN person AS p ON d.id = p.license_id
  LEFT JOIN facebook_event_checkin AS f ON p.id = f.person_id
WHERE height BETWEEN '65' AND '67'
    AND hair_color = 'red' 
    AND car_model = 'Model S'
    AND gender = 'female'
    AND f.event_name = 'SQL Symphony Concert'
    AND f.date like '201712%'
GROUP BY 
  d.id, p.id, p.name
HAVING COUNT(f.person_id) = 3;

-- Check your solution
INSERT INTO solution VALUES (1, 'Miranda Priestly');
 SELECT value FROM solution;

-- Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!

-- OUR MAIN CULPRIT IS MIRANDA PRIESTLY SUCCESSFULLY GOTTEN IN TWO QUERIES
              



