/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(250), date_of_birth date,
    escape_attempts INT, neutered boolean,
    weight_kg decimal
);
ALTER TABLE animals add species varchar(50);

/* Vet clinic database: query multiple tables */
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, full_name VARCHAR(250), age int);
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR(100));
ALTER TABLE animals ADD PRIMARY KEY(id);
ALTER TABLE animals DROP species;
ALTER TABLE animals ADD species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;
ALTER TABLE animals ADD owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id) ON DELETE CASCADE;