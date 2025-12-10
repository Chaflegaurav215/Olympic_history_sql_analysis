
--This project analyzes 120 years of Olympic history using two datasets — athletes and athlete_events 
-- -containing detailed information about athletes, events, performances, and medal achievements. 
--The aim of the project is to understand long-term Olympic trends, identify top-performing nations and athletes,
--and discover patterns in medal distribution. The dataset was validated for missing values, inconsistent entries,
--and duplicate athlete records before analysis. SQL queries were applied to extract meaningful insights such as 
--identifying nations with maximum gold medals, determining players with exclusive gold achievements, 
--analyzing yearly top performers, and detecting athletes with medals across multiple seasons. 
--Further, advanced queries explored India’s first medals, multi-medal achievements in a single Olympics,
--and consistency patterns like consecutive wins in the same event. This project demonstrates strong database querying,
--data cleaning, and analytical interpretation skills using structured Olympic data.

--1 which team has won the maximum gold medals over the years.
select top 1  team,count(distinct event) as cnt from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by team
order by cnt desc

--2 for each team print total silver medals and year in which they won maximum silver medal..output 3 columns
-- team,total_silver_medals, year_of_max_silver
with cte as (
select a.team,ae.year , count(distinct event) as silver_medals
,rank() over(partition by team order by count(distinct event) desc) as rn
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Silver'
group by a.team,ae.year)
select team,sum(silver_medals) as total_silver_medals, max(case when rn=1 then year end) as  year_of_max_silver
from cte
group by team;

--3 which player has won maximum gold medals  amongst the players 
--which have won only gold medal (never won silver or bronze) over the years
with cte as (
select name,medal
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id)
select top 1 name , count(1) as no_of_gold_medals
from cte 
where name not in (select distinct name from cte where medal in ('Silver','Bronze'))
and medal='Gold'
group by name
order by no_of_gold_medals desc

--4 In each year which player has won maximum gold medal . Write a query to print year,player name 
--and no of golds won in that year . In case of a tie print comma separated player names.
with cte as (
select ae.year,a.name,count(1) as no_of_gold
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by ae.year,a.name)
select year,no_of_gold,STRING_AGG(name,',') as players from (
select *,
rank() over(partition by year order by no_of_gold desc) as rn
from cte) a where rn=1
group by year,no_of_gold
;
--5 In which event and year India has won its first gold medal,first silver medal and first bronze medal
--print 3 columns medal,year,sport
select distinct * from (
select medal,year,event,rank() over(partition by medal order by year) rn
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where team='India' and medal != 'NA'
) A
where rn=1

--6 Find players who won gold medal in summer and winter olympics both.
select a.name  
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by a.name having count(distinct season)=2

--7 Find players who won gold, silver and bronze medal in a single olympics. print player name along with year.
select year,name
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal != 'NA'
group by year,name having count(distinct medal)=3

--8 find players who have won gold medals in consecutive 3 summer olympics in the same event . Consider only olympics 2000 onwards. 
--Assume summer olympics happens every 4 year starting 2000. print player name and event name.
with cte as (
select name,year,event
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where year >=2000 and season='Summer'and medal = 'Gold'
group by name,year,event)
select * from
(select *, lag(year,1) over(partition by name,event order by year ) as prev_year
, lead(year,1) over(partition by name,event order by year ) as next_year
from cte) A
where year=prev_year+4 and year=next_year-4


