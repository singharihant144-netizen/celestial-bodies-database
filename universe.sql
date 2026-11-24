--
-- PostgreSQL database dump
-- Celestial Bodies Database (universe)
-- Recreated from the database built for the freeCodeCamp project
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS universe;

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C.UTF-8';

ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

CREATE TABLE public.galaxy_type (
    galaxy_type_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE public.galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years INT NOT NULL,
    distance_from_earth NUMERIC(10,2),
    has_black_hole BOOLEAN NOT NULL
);

CREATE TABLE public.star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    description TEXT,
    is_spherical BOOLEAN NOT NULL,
    distance_from_earth NUMERIC(10,2)
);

CREATE TABLE public.planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    description TEXT,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN,
    age_in_millions_of_years INT
);

CREATE TABLE public.moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    description TEXT,
    is_spherical BOOLEAN NOT NULL,
    distance_from_planet NUMERIC(10,2)
);

ALTER TABLE public.galaxy_type OWNER TO freecodecamp;
ALTER TABLE public.galaxy OWNER TO freecodecamp;
ALTER TABLE public.star OWNER TO freecodecamp;
ALTER TABLE public.planet OWNER TO freecodecamp;
ALTER TABLE public.moon OWNER TO freecodecamp;

ALTER SEQUENCE public.galaxy_type_galaxy_type_id_seq OWNER TO freecodecamp;
ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;
ALTER SEQUENCE public.star_star_id_seq OWNER TO freecodecamp;
ALTER SEQUENCE public.planet_planet_id_seq OWNER TO freecodecamp;
ALTER SEQUENCE public.moon_moon_id_seq OWNER TO freecodecamp;

INSERT INTO public.galaxy_type (name, description) VALUES
  ('Spiral', 'A galaxy with spiral arms'),
  ('Elliptical', 'A galaxy with an elliptical shape'),
  ('Irregular', 'A galaxy without a distinct shape');

INSERT INTO public.galaxy (name, description, age_in_millions_of_years, distance_from_earth, has_black_hole) VALUES
  ('Milky Way', 'The galaxy containing our solar system', 13600, 0, TRUE),
  ('Andromeda', 'The nearest large spiral galaxy to the Milky Way', 10000, 2500000, TRUE),
  ('Triangulum', 'A spiral galaxy in the Triangulum constellation', 12000, 3000000, FALSE),
  ('Whirlpool', 'A grand design spiral galaxy', 8000, 23000000, TRUE),
  ('Sombrero', 'A spiral galaxy with a bright nucleus', 13000, 29000000, TRUE),
  ('Pinwheel', 'A face-on spiral galaxy', 7000, 21000000, FALSE);

INSERT INTO public.star (name, galaxy_id, description, is_spherical, distance_from_earth) VALUES
  ('Sun', 1, 'The star at the center of our solar system', TRUE, 0),
  ('Proxima Centauri', 1, 'The closest star to the Sun', TRUE, 4.24),
  ('Alpha Centauri', 1, 'A binary star system', TRUE, 4.37),
  ('Sirius', 1, 'The brightest star in the night sky', TRUE, 8.60),
  ('TRAPPIST-1', 1, 'An ultra-cool dwarf star', TRUE, 39.46),
  ('Kepler-452', 1, 'A Sun-like star', TRUE, 1400);

INSERT INTO public.planet (name, star_id, description, has_life, is_spherical, age_in_millions_of_years) VALUES
  ('Mercury', 1, 'The smallest planet in our solar system', FALSE, TRUE, 4500),
  ('Venus', 1, 'The hottest planet in our solar system', FALSE, TRUE, 4500),
  ('Earth', 1, 'Our home planet', TRUE, TRUE, 4500),
  ('Mars', 1, 'The red planet', FALSE, TRUE, 4600),
  ('Jupiter', 1, 'The largest planet in our solar system', FALSE, TRUE, 4500),
  ('Saturn', 1, 'The planet with prominent rings', FALSE, TRUE, 4500),
  ('Uranus', 1, 'An ice giant planet', FALSE, TRUE, 4500),
  ('Neptune', 1, 'The farthest planet from the Sun', FALSE, TRUE, 4500),
  ('Proxima Centauri b', 2, 'An exoplanet in the habitable zone', FALSE, TRUE, 4800),
  ('Alpha Centauri Bb', 3, 'An exoplanet orbiting Alpha Centauri B', FALSE, TRUE, 5000),
  ('TRAPPIST-1e', 5, 'An exoplanet in the habitable zone', FALSE, TRUE, 7000),
  ('Kepler-452b', 6, 'An Earth-like exoplanet', FALSE, TRUE, 6000);

INSERT INTO public.moon (name, planet_id, description, is_spherical, distance_from_planet) VALUES
  ('Moon', 3, 'Earth natural satellite', TRUE, 384400),
  ('Phobos', 4, 'The larger moon of Mars', FALSE, 9376),
  ('Deimos', 4, 'The smaller moon of Mars', FALSE, 23463),
  ('Io', 5, 'The most volcanically active moon', TRUE, 421700),
  ('Europa', 5, 'An icy moon with a subsurface ocean', TRUE, 670900),
  ('Ganymede', 5, 'The largest moon in the solar system', TRUE, 1070400),
  ('Callisto', 5, 'A heavily cratered moon', TRUE, 1882700),
  ('Amalthea', 5, 'A small irregular moon of Jupiter', FALSE, 181400),
  ('Titan', 6, 'The largest moon of Saturn', TRUE, 1221870),
  ('Rhea', 6, 'The second largest moon of Saturn', TRUE, 527100),
  ('Iapetus', 6, 'A moon with a two-toned surface', TRUE, 3560800),
  ('Enceladus', 6, 'An icy moon with geysers', TRUE, 238000),
  ('Dione', 6, 'A moon of Saturn', TRUE, 377400),
  ('Tethys', 6, 'A moon of Saturn', TRUE, 294700),
  ('Mimas', 6, 'A small moon of Saturn', TRUE, 185500),
  ('Titania', 7, 'The largest moon of Uranus', TRUE, 436300),
  ('Oberon', 7, 'The outermost major moon of Uranus', TRUE, 583500),
  ('Ariel', 7, 'A moon of Uranus', TRUE, 191000),
  ('Umbriel', 7, 'A dark moon of Uranus', TRUE, 266000),
  ('Miranda', 7, 'The smallest major moon of Uranus', TRUE, 129900);
