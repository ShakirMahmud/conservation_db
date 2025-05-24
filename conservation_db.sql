-- Active: 1748082802934@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,        
    name VARCHAR(50) NOT NULL,          
    region VARCHAR(25)                   
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,                        
    common_name VARCHAR(50) NOT NULL,                    
    scientific_name VARCHAR(50),                         
    discovery_date DATE NOT NULL,                        
    conservation_status VARCHAR(30)                                            
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,                   
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),  
    species_id INT NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,                 
    location VARCHAR(50) NOT NULL,                   
    notes TEXT                                        
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

SELECT *
FROM sightings
WHERE location LIKE '%Pass%';

SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
RIGHT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name
ORDER BY rangers.name;

SELECT species.common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.sighting_id IS NULL;

SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

CREATE OR REPLACE FUNCTION get_time_of_day(ts TIMESTAMP)
RETURNS TEXT AS $$
BEGIN
  IF EXTRACT(HOUR FROM ts) < 12 THEN
    RETURN 'Morning';
  ELSIF EXTRACT(HOUR FROM ts) BETWEEN 12 AND 16 THEN
    RETURN 'Afternoon';
  ELSE
    RETURN 'Evening';
  END IF;
END;
$$ LANGUAGE plpgsql;

SELECT sighting_id, get_time_of_day(sighting_time) AS time_of_day
FROM sightings
ORDER BY sighting_id;


DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);


SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;

DROP TABLE rangers;

DROP TABLE species;

DROP TABLE sightings;