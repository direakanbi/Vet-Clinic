SELECT * 
  FROM animals 
  WHERE 
    name LIKE '%mon';

/* select all animals born between the years 2016 and 2019 */
SELECT * 
  FROM animals 
  WHERE date_of_birth 
    BETWEEN 'Jan 1, 2016' AND 'Jan 1, 2019';

/* get all animals that are neutered and have escape attempts below 3 */
SELECT * 
  FROM animals 
  WHERE neutered=true 
    AND escape_attempts<3;

/* get the date_of_birth of animals with name Agumon or Pikachu */
SELECT date_of_birth 
  FROM animals 
  WHERE name='Agumon' OR name='Pikachu';

/* get name and escape attempts of animals that their weight is greater than 10.5 in kg */
SELECT name, escape_attempts 
  FROM animals 
  WHERE weight_kg > 10.5;

/* select all animals that are neutered */
SELECT * 
  FROM animals 
  WHERE neutered=true;

/* get all animals not name Gabumon */
SELECT * 
  FROM animals 
  WHERE name!='Gabumon';

/* get all animals with weight between 10.4 and 17.3 */
SELECT * 
  FROM animals 
  WHERE weight_kg 
    BETWEEN 10.4 AND 17.3;

/* count number of animals */
SELECT COUNT(*)
  FROM animals;

/* count number of animals that have not attempted escape */
SELECT COUNT(*)
  FROM animals
  WHERE escape_attempts = 0;

/* avarage weight of animals */
SELECT AVG(weight_kg)
  FROM animals;

/* sum escape attempts and compare
   between neutered and non-neutered
*/
SELECT neutered, SUM(escape_attempts)
  FROM animals
  GROUP BY neutered;

/* minimum and maximum weights of each type of animal*/
SELECT neutered, MIN(weight_kg), MAX(weight_kg)
  FROM animals
  GROUP BY neutered;

/* average number of escape attempts per animal 
   type of those born between 1990 and 2000
*/
SELECT neutered, AVG(escape_attempts)
  FROM animals
  WHERE date_of_birth 
    BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000'
  GROUP BY neutered;

/* write queries using join to answer the following questions */

-- What animals belong to Melody Pond?
SELECT *
  FROM animals a
  INNER JOIN owners o
  ON a.owner_id = o.id
  WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT *
  FROM animals a
  INNER JOIN species s
  ON a.species_id = s.id
  WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT *
  FROM owners o
  FULL OUTER JOIN animals a
  ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*)
  FROM species s
  LEFT JOIN animals a
  ON s.id =  a.species_id
  GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT *
  FROM animals a
  INNER JOIN owners o
  ON a.owner_id = o.id
  WHERE o.full_name = 'Jennifer Orwell' 
  AND a.species_id = 
    (SELECT id from species WHERE name = 'Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT *
  FROM animals a
  INNER JOIN owners o
  ON a.owner_id = o.id
  WHERE o.full_name = 'Dean Winchester' 
  AND a.escape_attempts <= 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*)
  FROM owners o
  LEFT JOIN animals a
  ON o.id =  a.owner_id
  GROUP BY o.full_name
  ORDER BY COUNT DESC
  LIMIT 1;