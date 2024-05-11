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








