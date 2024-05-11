# SQL Murder Mystery Investigation

## Introduction
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

## Crime Scene Report
The crime scene report provides essential details about the murder.

````sql
SELECT *  
FROM crime_scene_report 
WHERE type = 'murder' AND date = '20180115' AND city = 'SQL City';
````

![sol 1](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/8df4eb29-6183-4471-923c-063f63fa3248)

## Witnesses
Information about the witnesses and their statements.

### Witness 1
Full Details of the first witness.
````sql
SELECT * 
FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number desc
LIMIT 1;
````
![Screenshot_11-5-2024_214518_mystery knightlab com](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/6e1daa68-858e-414e-965e-1277c6409179)

### Witness 2
Full Details of the second witness.
````sql
SELECT * 
FROM person 
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave';
````
![Screenshot_11-5-2024_215237_mystery knightlab com](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/d3b698ae-49d6-4b0e-8479-99c1a9744f6c)

**Retrieving Interview Transcript for both Withnesses using their person_id from their full details**
````sql
SELECT * 
FROM interview 
WHERE person_id IN (14887, 16371)
````
![Screenshot_11-5-2024_22154_mystery knightlab com](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/3d65d4db-a042-4046-b4f9-cca01a9e9060)

## Suspects
Using the transcript from both witnesses, we can try to trace the murderer from the details provided.
````sql
SELECT * 
FROM get_fit_now_check_in 
WHERE membership_id  
LIKE '48Z%' AND check_in_date LIKE '%0109'
````
![Screenshot_11-5-2024_224724_mystery knightlab com](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/c7b7a309-cd65-4569-bea4-86366150cea1)

Getting more details on the suspects since we know the murderer is a gold member and has a plate_number with "H42W" included.
````sql
SELECT * 
FROM get_fit_now_member 
WHERE membership_status = 'gold' AND id LIKE '48Z%'
````
![Screenshot_11-5-2024_23419_mystery knightlab com](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/b4daeeed-9730-4514-956d-f816b08c713a)

Matching person_id with license_id
````sql
SELECT id as license_id 
FROM drivers_license 
WHERE plate_number like '%H42W%';
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/1710f7c7-0651-4837-9ab6-2df852254ec5)

````sql
SELECT * 
FROM person 
WHERE license_id in ('183779', '423327', '664760') 
AND id in ('28819', '67318');
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/d20a0b68-6285-454c-9ee6-82290c2b96d7)

**Jeremy is the murderer**

## View Murderer Full details
````sql
SELECT * 
FROM drivers_license 
WHERE id = '423327'
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/a189f3e4-f5fa-483a-a3a2-27b5286e7761)

## Solution Verification
````sql
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
   SELECT value FROM solution;
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/e94194b8-d910-4432-9321-3cbddecdc463)

### Additional Investigation.
````sql
SELECT * 
FROM interview 
WHERE person_id = '67318'
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/70329349-52bb-4f72-95f5-1fd92021a6e5)

Finding the main culprit in one query:
````sql
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
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/2ac43f59-c5bf-4bb3-99e6-ec331344e967)

## Solution Verification
````sql
INSERT INTO solution VALUES (1, 'Miranda Priestly');
 SELECT value FROM solution;
````
![image](https://github.com/austinosho/SQL-Murder-Mystery-Investigation/assets/166131518/30bdf0fa-2c05-4110-92c7-dfecb30141ad)

**OUR MAIN CULPRIT IS MIRANDA PRIESTLY SUCCESSFULLY GOTTEN IN TWO QUERIES**






