{{ config(materialized='table') }}

with raw_data as (
    -- Her bruger vi 'source' i stedet for et hårdkodet navn
    select * from {{ source('snowflake_raw', 'CHAT_MESSAGES') }}
)

select
    *,
    current_timestamp() as dbt_updated_at -- Vi tilføjer en tidsstempling
from raw_data
where message is not null -- Eksempel på oprydning