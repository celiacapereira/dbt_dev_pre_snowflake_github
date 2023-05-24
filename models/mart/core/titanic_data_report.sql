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
final as (
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
)
select 
    *
from
    final