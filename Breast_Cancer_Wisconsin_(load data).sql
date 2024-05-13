-- Data from https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic

CREATE TABLE IF NOT EXISTS Wdbc (
    ID_NUMBER INT PRIMARY KEY,
    DIAGNOSIS VARCHAR(2),
    radius DECIMAL(10,3),
    texture DECIMAL(10,3),
    perimeter DECIMAL(10,4),
    area INT,
    smothness DECIMAL(10,5),
    copactness DECIMAL(10,5),
    concavity DECIMAL(10,7),
    concave_points DECIMAL(10,7),
    symetry DECIMAL(10,5),
    fractial_dimension DECIMAL(10,5),
    radius_se DECIMAL(10,5),
    texture_se DECIMAL(10,5),
    perimeter_se DECIMAL(10,5),
    area_se DECIMAL(10,4),
    smothness_se DECIMAL(10,6),
    compactness_se DECIMAL(10,7),
    concavity_se DECIMAL(10,7),
    concave_points_se DECIMAL(10,7),
    symetry_se DECIMAL(10,7),
    fractal_dimension_se DECIMAL(10,7),
    worst_radius DECIMAL(10,5),
    worst_texture DECIMAL(10,5),
    worst_perimeter DECIMAL(10,5),
    worst_area INT,
    worst_smothness DECIMAL(10,7),
    worst_compactness DECIMAL(10,5),
    worst_concavity DECIMAL(10,7),
    worst_concave_points DECIMAL(10,7),
    worst_symetry DECIMAL(10,5),
    worst_factral_dimension DECIMAL(10,7)
    );
    
LOAD DATA INFILE 'C:/Users/mcabo/Desktop/Proyects/SQL/SQL_/breast+cancer+wisconsin+diagnostic/wdbc.data' 
INTO TABLE Wdbc 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT DIAGNOSIS, 
	AVG(radius), 
	AVG(texture),
    AVG(perimeter),
	AVG(area),
    AVG(smothness)
FROM wdbc
GROUP BY DIAGNOSIS
;