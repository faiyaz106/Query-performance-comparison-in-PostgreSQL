DROP TABLE IF EXISTS directors CASCADE;
CREATE TABLE directors (
	id int PRIMARY KEY,
	first_name varchar(100),
	last_name varchar(100)	
);

COPY directors
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\directors.csv'
DELIMITER ',' CSV ;


DROP TABLE IF EXISTS movies CASCADE;
CREATE TABLE movies (
	id int PRIMARY KEY,
	name varchar(100),
                  year int,
	rank float 
);

COPY movies
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\movies.csv'
DELIMITER ',' CSV ;

DROP TABLE IF EXISTS actors CASCADE;
CREATE TABLE actors (
	id int PRIMARY KEY,
	first_name varchar(100),
	last_name varchar(100),
	gender char(1)
);
COPY actors
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\actors.csv'
DELIMITER ',' CSV ;

DROP TABLE IF EXISTS movies_directors CASCADE;
CREATE TABLE movies_directors( 
	              director_id int references directors(id) NOT NULL,
                  movie_id int references movies(id) NOT NULL,
                  PRIMARY KEY (movie_id,director_id)
);

COPY movies_directors
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\movies_directors.csv'
DELIMITER ',' CSV;


DROP TABLE IF EXISTS roles CASCADE;
CREATE TABLE roles( 
                  actor_id int references actors(id) NOT NULL,
                  movie_id int references movies(id) NOT NULL,
                  role varchar
                  --PRIMARY KEY (actor_id, movie_id, role)
);

COPY roles
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\roles.csv'
DELIMITER ',' CSV ;

DROP TABLE IF EXISTS directors_genres CASCADE;
CREATE TABLE directors_genres( 
                  director_id int references directors(id) NOT NULL,
                  genre varchar(100) ,
                  prob float,
                  PRIMARY KEY (director_id, genre)
);
COPY directors_genres
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\directors_genres.csv'
DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS movies_genres CASCADE;

CREATE TABLE movies_genres( 
                  movie_id int references movies(id) NOT NULL,
                  genre varchar(100) ,
                  PRIMARY KEY (movie_id, genre)
);

COPY movies_genres
FROM 'C:\Program Files\PostgreSQL\15\pgAdmin 4\New folder\movies_genres.csv'
DELIMITER ',' CSV;




