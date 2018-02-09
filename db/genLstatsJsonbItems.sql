INSERT INTO lstats VALUES (1, 1, '{"name": "blue house", "tags": ["coffee", "open space"], "free": true}');
INSERT INTO lstats VALUES (2, 1, '{"name": "red house", "tags": ["coffee", "open space"], "free": false}');

SELECT data->>'name' AS name FROM lstats;
SELECT * FROM lstats WHERE data->>'free' = 'true';

