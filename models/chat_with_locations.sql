{{ config(materialized='table') }}

with chats as (
    select * from {{ ref('clean_chat_data') }}
),

users as (
    select * from {{ ref('manual_user_city') }}
)

select
    c.*,
    u.city
from chats c
left join users u 
    on c.username = u.email 