CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;
CREATE EXTENSION postgis_topology;

DROP TABLE IF EXISTS municipis ;
	
CREATE TABLE municipis (
	nom VARCHAR(50) PRIMARY KEY,
	ajuntament	GEOMETRY);
	
INSERT INTO municipis(nom,ajuntament) VALUES
	('Girona',ST_MakePolygon(ST_MakeLine( ARRAY[ ST_GeomFromText('POINT( 2.8248281 41.9832217)', 4326),ST_GeomFromText('POINT( 2.8247114 41.9830348)', 4326),
				ST_GeomFromText('POINT( 2.8249837 41.9829249)', 4326), ST_GeomFromText('POINT( 2.825124 41.9831003)', 4326),ST_GeomFromText('POINT( 2.8248281 41.9832217)', 4326) ])));


	
DROP TABLE IF EXISTS papereres ;

CREATE TABLE papereres (
	codi SERIAL PRIMARY KEY,
	geom	GEOMETRY,
	municipi  VARCHAR(50),
	CONSTRAINT fk_banc_municipi
    FOREIGN KEY (municipi)
    REFERENCES municipis (nom));
	
INSERT INTO papereres(geom,municipi) VALUES
	(ST_GeomFromText('POINT(2.8305053 41.9608524)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8312346 41.9645052)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8290227 41.9642339)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8307883 41.9638847)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8304852 41.9632898)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8311310 41.9627444)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8309331 41.9617399)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8296681 41.9643638)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8286875 41.9627017)', 4326),'Girona');
	
DROP TABLE IF EXISTS bancs ;
CREATE TABLE bancs (
	codi SERIAL PRIMARY KEY,
	geom	GEOMETRY,
	municipi  VARCHAR(50),
	CONSTRAINT fk_banc_municipi
    FOREIGN KEY (municipi)
    REFERENCES municipis (nom)
	);
  	
INSERT INTO bancs(geom,municipi) VALUES
	(ST_GeomFromText('POINT( 2.8301526 41.9638672)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8306599 41.9636872)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8296708 41.9644299)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8308959 41.9638301)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8284675 41.9625402)', 4326),'Girona'),
	(ST_GeomFromText('POINT(2.8308369 41.9618127)', 4326),'Girona');


DROP TABLE IF EXISTS usuaris ;

CREATE TABLE usuaris(
	username varchar(25) PRIMARY KEY,
	pass     varchar(30) NOT NULL,
	email 	 varchar(90) NOT NULL,
	nom      varchar(50),
	cognom   varchar(50)
  );
  
  INSERT INTO usuaris VALUES
	('prova1','prova1','prova1@prova1.com','prova1','u'),
	('prova2','prova2','prova2@prova2.com','prova2','d');
	
CREATE INDEX bancs_idx ON bancs USING GIST (geom);
CREATE INDEX papereres_idx ON papereres USING GIST (geom);
CREATE INDEX municipis_idx ON municipis USING GIST (ajuntament);

