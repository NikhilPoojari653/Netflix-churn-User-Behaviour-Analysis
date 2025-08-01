---Most Watched Genres
SELECT favorite_genre, 
  ROUND(SUM("watch_time_hours")::numeric, 2) AS total_watch_hours
FROM netflix_users
GROUP BY favorite_genre
ORDER BY total_watch_hours DESC;

---Average Watch Time per User
SELECT ROUND(AVG("watch_time_hours")::numeric, 2) AS avg_watch_time
FROM netflix_users;

---Average Watch Time per User using Subscription Type
SELECT subscription_type, 
  ROUND(AVG(watch_time_hours)::numeric, 2) AS avg_watch_time
FROM netflix_users
GROUP BY subscription_type
ORDER BY avg_watch_time DESC;

---Genre vs. Likely Churn
SELECT favorite_genre, 
  COUNT(*) AS total_users,
  COUNT(*) FILTER (WHERE last_login < '2025-01-01') AS likely_churned_users
FROM netflix_users
GROUP BY favorite_Genre
ORDER BY likely_churned_users DESC;

---User Count by Country
SELECT country, 
  COUNT(user_ID) AS total_users
FROM netflix_users
GROUP BY country
ORDER BY total_users DESC;

---Engagement by Subscription Type
SELECT subscription_type, 
  COUNT(user_ID) AS user_count,
  ROUND(AVG(watch_time_hours)::numeric, 2) AS avg_watch_time
FROM netflix_users
GROUP BY subscription_type
ORDER BY avg_watch_time DESC;

---Engagement Score
SELECT subscription_type, 
  ROUND(AVG(watch_time_hours * CASE
    WHEN Age < 25 THEN 1.2
    WHEN Age BETWEEN 25 AND 45 THEN 1.0
    ELSE 0.8
  END)::numeric, 2) AS weighted_engagement_score
FROM netflix_users
GROUP BY subscription_type;

