-- \connect preprocessing

-- ##name.basics.tsv.gz 
-- ##nconst(string):  alphanumeric, unique identifier(PRIMARY KEY)
-- ##primaryName: Name of the person
-- ##birthyear: YYYY Format
-- ##deathyear: YYYY format
-- ##primaryProfession: Top-3 professions of a person
-- ##knownForTitles: Titles the person known for

CREATE TABLE name_basics(
  nconst varchar(10), 
  primaryName varchar(200),
  birthyear int,
  deathyear int,
  primaryProfession varchar(100),
  knownForTitles varchar(100)
);

\copy name_basics FROM 'name.basics.tsv';

UPDATE name_basics SET primaryprofession = '{' || primaryProfession || '}', knownForTitles = '{' || knownForTitles || '}';

\copy (SELECT * FROM name_basics) TO 'data/name.basics.tsv';

DROP TABLE name_basics;



-- ##title.basics.tsv.gz
-- ##tconst (string): alphanumeric unique identifier of title
-- ##titleType (string):  type/format of the title. movie, short, tvseries, tvepisode, video
-- ##primaryTitle (string): more popular title
-- ##originalTitle (string): original title
-- ##isAdult (boolean): 0: non-adult title; 1: adult title.
-- ##startYear (YYYY): release year
-- ##endYear (YYYY): TV Series end year
-- ##runtimeMinutes:  runtime in minutes
-- ##genres(string array):array of three genres

CREATE TABLE title_basics(
  tconst varchar(10),
  titleType varchar(15),
  primaryTitle varchar(500),
  originalTitle varchar(500),
  isAdult boolean,
  startYear int,
  endYear int,
  runtimeMinutes int,
  genres varchar(200)
);



\copy title_basics FROM 'title.basics.tsv';

UPDATE title_basics SET genres = '{' || genres || '}';

\copy (SELECT * FROM title_basics) TO 'data/title.basics.tsv';


DROP TABLE title_basics;

-- ALTER TABLE title_crew ALTER COLUMN directors TYPE varchar(1000);

-- ##title.crew.tsv.gz
-- ##Contains the director and writer information for all the titles in IMDb. Fields include:
-- ##tconst (string)
-- ##directors (array of nconsts) - director(s) of the given title
-- ##writers (array of nconsts) – writer(s) of the given title

CREATE TABLE title_crew(
  tconst varchar(10),
  directors varchar(10000),
  writers varchar(10000)
);

\copy title_crew FROM 'title.crew.tsv';

UPDATE title_crew SET directors = '{' || directors || '}', writers = '{' || writers || '}';

\copy (SELECT * FROM title_basics) TO 'data/title.crew.tsv';

-- title.principals.tsv
-- tconst (string)
-- principalCast (array of nconsts) – title’s top-billed cast/crew


-- CREATE TABLE title_principals(
--   tconst varchar(10),
--   principalCast varchar(10000)
-- );

-- \copy title_principals FROM '/Users/apple/Desktop/Sem 6/DBMS/A2/Data/3.tsv';

-- UPDATE title_principals SET principalCast = '{' || principalCast || '}';

-- \copy (SELECT * FROM title_principals) TO '/Users/apple/Desktop/Sem 6/DBMS/A2/Data/modify/title.principals.tsv';
