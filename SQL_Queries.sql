
--Query1: Retrieve id,first_name and last_name of actor whose first_name is 'Luis'
--Query1         
select id,first_name,last_name from actors where first_name='Luis';

--Query2: Retrieve all the movies name where 'painter' role is casted.
--Query2
select movies.name from movies join 
(select distinct movie_id from roles where role='painter') as sq1
on (sq1.movie_id=movies.id);


--Query3. List the first and last names of all the actors who were cast in the 'Rush Hour' movie:
--Query3
select first_name,last_name 
from 
actors as ac 
join 
(select distinct actor_id from roles as rc 
 join
(select id from movies where name='Rush Hour' ) as mv on (mv.id=rc.movie_id)) 
as pq 
on (pq.actor_id=ac.id) 
order by first_name, last_name;


--Query4 List all the directors (first and last names) who directed movies who casted the role of 'Musician'.
--Query4
select first_name,last_name 
from 
directors as dc 
join 
(select distinct director_id from movies_directors as md
 natural join
(select distinct movie_id from roles where role='Musician') as di) 
as dq 
on (dq.director_id=dc.id) 
order by first_name, last_name;

--Query5. List all the actors who acted in a film before 1950 and also in a film after 2000.
--Query5
select * from 
(select first_name,last_name from actors join 
(select distinct actor_id from roles join (select id from movies where year>=2000) as m 
on (roles.movie_id=m.id)) as dcm 
on (dcm.actor_id=actors.id)) as l1
INTERSECT
(select first_name,last_name from actors join 
(select distinct actor_id from roles join (select id from movies where year<=1950) as m 
on (roles.movie_id=m.id)) as dcm 
on (dcm.actor_id=actors.id))
order by first_name, last_name;

--Query6. Retrieve all the directors name who directed more than 10 'Thriller' movies in movies_genres.
--Query6

select first_name,last_name from directors natural join
(select director_id as id, count(*) as cs from movies_directors natural join
(select movie_id from movies_genres where genre='Thriller') as md
group by director_id) as sq
where cs>10
order by cs DESC;


--Query7.  Write query to retrieve all the actors' first and last name, the movie name, the number of distinct roles  where one actor played more than 5 roles in that particular movie.

--Query7
select name as movie_name,first_name,last_name,role_n from actors join 
(select movies.name,actor_id,role_n from movies join
(select movie_id,actor_id,count(distinct role) as role_n from roles 
group by movie_id,actor_id) as sq1
on (movies.id=sq1.movie_id)) as sq2
on (actors.id=sq2.actor_id)
where role_n>5
order by role_n DESC;

--Query8. Calculate the percentage of Male and Female actors in actors table.

--Query 8
select sq1.gender,sq1.count*100/sum(sq1.count) over () as percentage from 
(select gender,count(*) from actors group by gender) as sq1;
