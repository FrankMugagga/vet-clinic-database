/* Populate database with sample data. */
INSERT INTO animals (
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
    ) 
    VALUES ('Agumon', '2020-02-03', 10.23, true, 0);

INSERT INTO animals (
    name,
    date_of_birth,
    weight_kg, neutered,
    escape_attempts
    )
    VALUES ('Gabumon', '2018-11-15', 8, true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true, 5);


/*  Vet clinic database: query and update animals table */

INSERT INTO animals(
    name, date_of_birth, weight_kg, neutered, escape_attempts
    ) 
    VALUES ('Charmander', '2020-02-08', -11, false, 0));

INSERT INTO animals(
    name, date_of_birth, weight_kg, neutered, escape_attempts
    ) 
    VALUES ('Plantmon''2021-11-15', -5.7, true, 2), 
    ('Squirtle', '1993-04-02', -12.13, false, 3), 
    ('Angemon', '2005-01-12', -45, true, 1);

INSERT INTO animals(
    name, date_of_birth, weight_kg, neutered, escape_attempts
    ) 
    VALUES ('Boarmon', '2005-06-07', 20.4, true, 7), 
    ('Blossom', '1998-10-13', 17, true, 3), 
    ('Ditto', '2022-05-14', 22, true, 4);

/* Vet clinic database: query multiple tables */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell',19 ), ('Bob', 45 ), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');
UPDATE animals SET species_id = 2 WHERE name LIKE'%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE'%mon';
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5  WHERE name IN ('Angemon', 'Boarmon');

/* Vet clinic database: add "join table" for visits */
INSERT INTO VETS(NAME, AGE, DATE_OF_GRADUATION) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO VETS(NAME, AGE, DATE_OF_GRADUATION) VALUES ('Maisy Smith', 26, '2019-01-17'), ('Stephanie Mendez', 64, '1981-
05-4'), ('Jack Harkness', 38, '2008-06-8');
INSERT INTO SPECIALIZATIONS(SPECIES_ID, VETS_ID) VALUES (1, 1), (2, 3), (1, 3), (2, 4);
INSERT INTO VISITS (ANIMALS_ID, VETS_ID, DATE_OF_VISIT) VALUES(1, 1, '2020-05-24'), (1, 3, '2020-07-22'), (2, 4, '2021-02-02'), (3, 2, '2020-01-05'), (3, 2, '2020-03-08'), (3, 2, '2020-05-14'), (4, 3, '2021-05-04'), (5,
 4, '2021-02-24');
 INSERT INTO VISITS (ANIMALS_ID, VETS_ID, DATE_OF_VISIT) VALUES(6, 2, '2019-12-21'), (6, 1, '2020-08-10'
), (6, 2, '2021-04-07'), (7, 3, '2019-09-29'), (1, 4, '2020-10-03'), (1, 4, '2020-11-04'), (10, 1, '2021-01-11'), (10, 3, '2020-05-24');
INSERT INTO VISITS (ANIMALS_ID, VETS_ID, DATE_OF_VISIT) VALUES(9, 2, '2019-01-24'), (9, 2, '2020-02-27'), (9, 2, '2020-08-03');
 INSERT INTO VISITS (ANIMALS_ID, VETS_ID, DATE_OF_VISIT) VALUES(9, 2, '2019-05-15');

 /* Vet clinic database: database performance audit */
 
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';