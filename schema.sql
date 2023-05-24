/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(250), date_of_birth date,
    escape_attempts INT, neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals add species varchar(50);
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -5.7;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -45;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -12.13;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg = -11;
COMMIT;
