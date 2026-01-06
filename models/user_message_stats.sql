-- Vi bygger denne som en tabel i Snowflake
{{ config(materialized='table') }}

with message_data as (
    -- ref() fortæller dbt, at denne model afhænger af din 'clean_chat_data'
    select 
        username,         -- Hvis denne fejler, så prøv 'sender_id' eller 'user'
        sent_at       -- Hvis denne fejler, så prøv 'sent_at' eller 'timestamp'
    from {{ ref('clean_chat_data') }}
)

select
    username,
    count(*) as total_messages,
    min(sent_at) as first_message_at,
    max(sent_at) as last_message_at
from message_data
group by 1
order by total_messages desc