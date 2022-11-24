INSERT INTO instrument_type (name)
VALUES
    ('Guittar'),
    ('Flute'),
    ('Piano'),
    ('Drums'),
    ('Harp');


INSERT INTO instruments (brand, fee, instrument_type_id)
VALUES
    ('ITK', 200, 1),
    ('ITK', 300, 1),
    ('Qmisk', 150, 1),
    ('Tmeit', 250, 2),
    ('Tmeit', 200, 2),
    ('ITK', 320, 3),
    ('Qmisk', 280, 3),
    ('Qmisk', 630, 4),
    ('Tmeit', 200, 4),
    ('ITK', 500, 5),
    ('ITK', 550, 5);
    