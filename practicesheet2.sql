select * from titles;
select * from subscribers;
select * from watch;

-- average rating by genre
select round(avg(rating),2) as avg_rating ,type
from titles
group by type;

-- Minutes watched per plan
select s.plan as groupedplan, sum(w.minutes_watched) as total_minutes
from subscribers s 
inner join watch w
on s.user_id = w.user_id
group by groupedplan;

-- subquery version
SELECT s.plan,
       SUM((
           SELECT SUM(w.minutes_watched)
           FROM watch w
           WHERE w.user_id = s.user_id
       )) AS total_minutes
FROM subscribers s
GROUP BY s.plan;

-- Top 3 most watched per plan
select s.plan, w.minutes_watched as total_minutes , w.user_id
from subscribers s 
inner join watch w
on s.user_id = w.user_id
order by total_minutes desc limit 3;

-- For each user , count distinct titles watched
SELECT user_id,
       COUNT(DISTINCT title_id) AS distinct_titles_watched
FROM watch
GROUP BY user_id;

-- above 4.2 rated shows
select *
from titles
where type = "show" and rating > 4.2
order by rating desc;

-- Genre share of total minutes(percentage)
SELECT 
    t.genre,
    ROUND(SUM(w.minutes_watched) * 100.0 / ( SELECT SUM(minutes_watched) FROM watch), 2) AS genre_share_percentage
FROM watch w
JOIN titles t ON w.title_id = t.title_id
GROUP BY t.genre;

-- Plan with average rating of watched > 4.5
SELECT DISTINCT s.plan
FROM subscribers s
WHERE s.user_id IN ( SELECT DISTINCT w.user_id FROM watch w JOIN titles t ON w.title_id = t.title_id
		WHERE t.title_id IN ( SELECT title_id
							   FROM titles
							   GROUP BY title_id
							   HAVING AVG(rating) > 4.5)
);







