/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%__mon';
SELECT * FROM animals WHERE ( '2016-01-01' < date_of_birth AND date_of_birth < '201
9-01-01' );
SELECT * FROM animals WHERE (neutered IN (true) AND escape_attempts<3);
SELECT date_of_birth FROM animals WHERE (name IN ('Agumon') or name IN ('Pikachu'));
SELECT name, escape_attempts FROM animals WHERE (weight_kg > 10.5);
SELECT * FROM animals WHERE neutered IN (true);
SELECT * FROM animals WHERE name not IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg IN (10.4, 17.3) OR (weight_kg > 10.4 AND weight_kg < 17.3);
