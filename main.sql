
-- ##creating a movie table and loading it from dataset
CREATE TABLE movies (
    tconst varchar(10),
    titleType text, 
    primaryTitle text,
    originalTitle text,
    isAdult boolean,
    startYear int,
    endYear int default NULL,
    runtimeMinutes int,
    genres text[],
    PRIMARY KEY (tconst)
);
\copy movies from 'title.basics.tsv';




-- ##creating a ratings table and loading it from dataset
CREATE TABLE ratings(
  tconst varchar(10) PRIMARY KEY,
  averageRating real,
  numVotes int,
  CONSTRAINT fk_ratings_movies FOREIGN KEY (tconst) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE
);
\copy ratings from 'title.ratings.tsv';




-- ##creating a crew table and loading it from dataset
CREATE TABLE crew(
  tconst varchar(10) PRIMARY KEY, 
  directors text[],
  writers text[]
);
\copy crew from 'title.crew.tsv';

-- ##deleting the rows of crew which doesn't have a movieId in movies which will conflict foreign keys
DELETE FROM crew WHERE tconst IN (SELECT c.tconst FROM crew c LEFT JOIN movies m ON c.tconst=m.tconst WHERE m.tconst IS NULL);

-- ## now adding the foreign keys constraints after delting those keys
ALTER TABLE crew ADD CONSTRAINT fk_crew_movies FOREIGN KEY (tconst) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE;




-- ##creating a name_basics table and loading it from dataset
CREATE TABLE name_basics(
  nconst varchar(10) PRIMARY KEY , 
  primaryName text,
  birthyear int,
  deathyear int,
  primaryProfession text[],
  knownForTitles text[]
);
\copy name_basics from 'name.basics.tsv';




-- ##creating a episode table and loading it from dataset
CREATE TABLE episode(
  tconst varchar(10) PRIMARY KEY,
  parentTconst varchar(10),
  seasonNumber int,
  episodeNumber int
);

\copy episode from 'title.episode.tsv';

-- ## deleting the id's which doesn't have the respective movieId in movies which will conflict foreign keys
DELETE FROM episode  WHERE tconst IN ( SELECT c.tconst FROM episode c LEFT JOIN movies m ON c.tconst=m.tconst WHERE m.tconst IS NULL);
DELETE FROM episode  WHERE parentTconst IN ( SELECT c.parentTconst FROM episode c LEFT JOIN movies m ON c.parentTconst=m.tconst WHERE m.tconst IS NULL);

-- ## Adding the foreign key constraints
ALTER TABLE episode ADD CONSTRAINT fk_episode_movies FOREIGN KEY(tconst) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE episode ADD CONSTRAINT fk_parentTconst_movie FOREIGN KEY(parentTconst) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE;




-- ##creating a principals table and loading it from dataset
CREATE TABLE principals(
  tconst  varchar(10),
  ordering  int,
  nconst  varchar(10) ,
  category  text,
  job text,
  characters text
);
\copy principals from 'title.principals.tsv';

-- ## deleting the rows which doesn't have the respective movieId and names which will conflict foreign keys
DELETE FROM principals  WHERE tconst IN ( SELECT c.tconst FROM principals c LEFT JOIN movies m ON c.tconst=m.tconst WHERE m.tconst IS NULL);
DELETE FROM principals  WHERE nconst IN ( SELECT c.nconst FROM principals c LEFT JOIN name_basics m ON c.nconst=m.nconst WHERE m.nconst IS NULL);

-- ## Adding the foreign key constraints
ALTER TABLE principals ADD CONSTRAINT fk_principals_movies FOREIGN KEY(tconst) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE principals ADD CONSTRAINT fk_principals_names FOREIGN KEY(nconst) REFERENCES name_basics(nconst) ON DELETE CASCADE ON UPDATE CASCADE;




-- creating a title_akas table and loading it from dataset
CREATE TABLE title_akas(
  titleId varchar(10),
  ordering  int,
  title text,
  region  text,
  language  text,
  types text,
  attributes text, 
  isOriginalTitle boolean
);
\copy title_akas from 'title.akas.tsv';

-- ## deleting the rows which doesn't have id's in movie
DELETE FROM title_akas  WHERE titleId IN ( SELECT c.titleId FROM title_akas c LEFT JOIN movies m ON c.titleId=m.tconst WHERE m.tconst IS NULL);

-- ## finally adding the foreign key constraint
ALTER TABLE title_akas ADD CONSTRAINT fk_akas_movie FOREIGN KEY(titleId) REFERENCES movies(tconst) ON DELETE CASCADE ON UPDATE CASCADE;

 