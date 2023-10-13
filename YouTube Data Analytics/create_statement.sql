----------YT Final------------

DROP TABLE IF EXISTS public.youtube_final ;

CREATE TABLE public.youtube_final AS
(
SELECT 
channel_name,
title,
definition,
tags,
caption,
day,
year,
month,
EXTRACT(HOUR FROM published_date) as published_hour,
published_date,
time_seconds as video_duration,
views as view_count,
likes as like_count,
comments as comment_count,
tag_count
FROM public.youtube
);


----------ytChannel_StatsFinal------------

DROP TABLE IF EXISTS public.ytChannel_StatsFinal;

CREATE TABLE public.ytChannel_StatsFinal AS 
(
 SELECT 
	distinct channel_name,
	subscribers,
	views as total_views,
	total_videos
	FROM public.yt_channel_stats
);

-------------------------------------

SELECT DISTINCT channel_name
FROM public.youtube;

SELECT *
FROM public.youtube;

SELECT distinct caption
FROM public.youtube;

SELECT *
  FROM information_schema.columns
 WHERE table_name   = 'youtube'
     ;

SELECT *
FROM public.youtube_final
WHERE video_duration <=180
--and channel_name = 'Trakin Tech English'
--video_duration >60 and ;

SELECT channel_name, count(*)
FROM public.youtube_final
WHERE LOWER(title) LIKE '%shorts'
GROUP BY 1;
--video_duration <=180
--and channel_name = 'Trakin Tech English'
--video_duration >60 and ;

SELECT channel_name, avg(view_count)
FROM public.youtube_final
--WHERE LOWER(title) LIKE '%shorts'
GROUP BY 1;