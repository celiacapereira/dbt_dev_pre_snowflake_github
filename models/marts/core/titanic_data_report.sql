with titanic_ref as (
    
    select * from {{ ref('stg_titanic') }}

),
titanic_transformation as(
SELECT passengerid,sex,
  CASE 
    WHEN age is null and sex= 'female' THEN 26
    WHEN age is null and sex= 'male' THEN 29
    ELSE age
  END AS age
FROM titanic_ref
)
,
almost_final as (
    select 
    titanic_ref.PASSENGERID,
    SURVIVED,
    PCLASS,
    NAME,
    titanic_ref.SEX,
    titanic_transformation.AGE,
    SIBSP,
    PARCH,
    FARE,
    EMBARKED
    from titanic_ref inner join titanic_transformation on titanic_ref.PASSENGERID = titanic_transformation.PASSENGERID
),
final as (
SELECT
PASSENGERID,
SURVIVED,
PCLASS,
NAME,
SEX,
AGE,
SIBSP,
PARCH,
FARE,
EMBARKED,
CASE 
    WHEN AGE < 10 THEN '0-9'
    WHEN AGE >=10 and AGE <20  THEN '10-19'
    WHEN AGE >=20 and AGE <30  THEN '10-29'
    WHEN AGE >=30 and AGE <40  THEN '0-39'
    WHEN AGE >=40 and AGE <50  THEN '0-49'
    WHEN AGE >=50 and AGE <60  THEN '0-59'
    WHEN AGE >=60 and AGE <70  THEN '0-69'
    WHEN AGE >=70 and AGE <80  THEN '0-79'
    WHEN AGE >=80 and AGE <90  THEN '0-89'
END AS AGE_RANGE
FROM almost_final
)

select 
    *
from
    final
