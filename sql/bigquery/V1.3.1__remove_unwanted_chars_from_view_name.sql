DROP VIEW IF EXISTS dsongcp.delayed_10_2015;

CREATE OR REPLACE VIEW dsongcp.delayed_10 AS
SELECT * FROM dsongcp.flights WHERE dep_delay >= 10;

DROP VIEW IF EXISTS dsongcp.delayed_15_2015;

CREATE OR REPLACE VIEW dsongcp.delayed_15 AS
SELECT * FROM dsongcp.flights WHERE dep_delay >= 15;

DROP VIEW IF EXISTS dsongcp.delayed_20_2015;

CREATE OR REPLACE VIEW dsongcp.delayed_20 AS
SELECT * FROM dsongcp.flights WHERE dep_delay >= 20;