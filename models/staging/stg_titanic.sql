with source as (

    select * from {{ source('titanic', 'TITANIC_RAW') }}

),
renamed as (

    select
    PASSENGERID,
    SURVIVED,
    PCLASS,
    NAME,
    SEX,
    AGE,
    SIBSP,
    PARCH,
    FARE,
    EMBARKED
    from source

)

select * from renamed