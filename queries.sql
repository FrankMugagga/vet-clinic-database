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

/* Vet clinic database: query multiple tables */
SELECT name, full_name FROM animals a JOIN owners o ON o.id = a.owner_id WHERE full_name = 'Melody Pond';
SELECT a.name, s.name FROM animals a JOIN species s ON s.id = a.species_id WHERE species_id = 1;
SELECT o.*, name FROM owners o FULL JOIN animals a ON a.owner_id = o.id;
SELECT species_id,s.name, COUNT(species_id) FROM animals a JOIN species s ON s.id = a.species_id GROUP BY species_id, s.name;
SELECT full_name, a.name, s.name FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON s.id = a.species_id WHERE full_name = 'Jennifer Orwell' AND species_id = 2;
SELECT full_name, a.name,escape_attempts FROM animals a JOIN owners o ON a.owner_id = o.id WHERE full_name=
'Dean Winchester' AND escape_attempts > 0;
SELECT full_name, MAX(owner_count) FROM (SELECT full_name, COUNT(owner_id) AS owner_count FROM animals a JOIN owners o ON a.owner_id = o.id GROUP BY full_name, owner_id) AS subquery GROUP BY full_name;

/* Vet clinic database: add "join table" for visits */

SELECT animals.name AS animal_last_seen_by_William, vets.name, MAX(date_of_visit) AS last_vist FROM visits JOIN animals ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'William Tatcher' GROUP BY animals.name, vets.name ORDER BY last_vist DESC LIMIT 1;
SELECT animals.name AS animals_seen_by_StephanieMendez, vets.name, COUNT(visits.animals_id) FROM visits JOIN animals ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 3 GROUP BY animals.name, vets.name;
SELECT vets.name AS VetsNames, species.name AS Specialities, specializations.species_id FROM SPECIALIZATIONS FULL JOIN vets ON specializations.vets_id = vets.id FULL JOIN species ON species.id = specializations. species_id GROUP BY specializations.species_id, vets.name, species.name;
SELECT animals.name AS animals_that_visited, visits.date_of_visit, vets.name FROM VISITS JOIN ANIMALS ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 3 AND date_of_visit BETWEEN '2020-04-1' AND '2020-08-30' GROUP BY animals.name, vets.name, visits.date_of_visit;
SELECT animals.name AS animal_with_most_visits, COUNT(visits.animals_id) AS Animal_visits FROM visits JOIN 
animals ON animals.id = animals_id JOIN vets ON vets.id = visits.vets_id GROUP BY animals.name ORDER BY Animal_visits de
sc;
SELECT animals.name AS animal_with_most_visits, COUNT(visits.animals_id) AS Animal_visits FROM visits JOIN animals ON animals.id = animals_id JOIN vets ON vets.id = visits.vets_id GROUP BY animals.name ORDER BY Animal_visits desc limit 2;
SELECT animals.name AS first_animal_to_visit_Maisy, vets.name, MIN(visits.date_of_visit) FROM VISITS JOIN animals ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' group by animals.name, vets.name, visits.date_of_visit limit 1;
SELECT * FROM visits JOIN animals ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vets_id ORDER BY visits.date_of_visit desc limit 1;
SELECT COUNT(*) AS visits_with_a_vet_tha_did_no_specialize FROM visits JOIN (SELECT vets.id FROM vets FULL JOIN specializations ON vets.id = specializations.vets_id FULL JOIN species ON species.id = specializations.species_id WHERE specializations.species_id IS NULL) AS
 vet ON vet.id = visits.vets_id;
 SELECT s.name AS species_name_Maisy_should_consider, COUNT(vis.date_of_visit) AS total_visits FROM visits AS vis JOIN animals AS 
a ON vis.animals_id = a.id JOIN species AS s ON a.species_id = s.id JOIN vets AS v ON vis.vets_id = v.id WHERE v.name = 
 'Maisy Smith' GROUP BY s.name ORDER BY total_visits DESC LIMIT 1;