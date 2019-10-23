--Q1
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;
SELECT COUNT(DISTINCT utm_source)
FROM page_visits;
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

--Q2
SELECT DISTINCT page_name
FROM page_visits;

--Q3
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(ft.first_touch_at) as num_first_touches
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign;

--Q4
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(lt.last_touch_at) as num_last_touches
FROM last_touch as lt
JOIN page_visits as pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2 DESC;

--Q5
SELECT COUNT(DISTINCT user_id) AS num_purchase
FROM page_visits
WHERE page_name = '4 - purchase';

--Q6
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(lt.last_touch_at) as num_last_touches
FROM last_touch as lt
JOIN page_visits as pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;

