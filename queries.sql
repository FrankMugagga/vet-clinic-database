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


/*  Vet clinic database: query and update animals table */
BEGIN;
SAVEPOINT SP1;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK TO SP1;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'Pokemon' WHERE name NOT LIKE '%mon';
COMMIT;

BEGIN;
SAVEPOINT SP2;
DELETE FROM animals;
ROLLBACK TO SP2;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -5.7;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -45;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -12.13;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -11;
COMMIT;

SAVEPOINT SP3;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP3;
SELECT COUNT(name) from animals;
SELECT * FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;




