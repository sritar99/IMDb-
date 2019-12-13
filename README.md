# IMDb-
Designed an Entity-Relationship model for IMDb data maintaining referential integrity. The developed relational Model was populated with IMDb data and tested vigorously.



IMDB Data Base

Delete the header rows of every dataset


On psql server `create database preprocessing`

create a data folder to which these modified files will be copied to
In terminal `psql -U postgres -d preprocessing -a -f preprocessing.sql`



On psql server `create database imdb`

In terminal `psql -U postgres -d imdb -a -f main.sql`


Data file Used: name.basics.tsv, title.akas.tsv, title.basics.tsv, title.crew.tsv, title.episode.tsv, title.principals.tsv, title.ratings.tsv
