DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS screens;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE screens (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  capacity INT
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  cost INT,
  rating INT
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  time_date VARCHAR(255),
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  screen_id INT4 REFERENCES screens(id) ON DELETE CASCADE
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE
);
