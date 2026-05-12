CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);

CREATE TABLE developers (
    id BIGSERIAL PRIMARY KEY,
    studioName VARCHAR(255) NOT NULL,
    countryOrigin VARCHAR(100),
    website VARCHAR(255),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);

CREATE TABLE games (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    summary TEXT,
    price DECIMAL(10,2) NOT NULL,
    developers_id BIGINT REFERENCES developers(id),
    categories_id BIGINT REFERENCES categories(id),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    userName VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    walletBalance DECIMAL(10,2) DEFAULT 0.00,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);

CREATE TABLE licenses (
    id BIGSERIAL PRIMARY KEY,
    users_id BIGINT REFERENCES users(id),
    games_id UUID REFERENCES games(id),
    playTime DECIMAL(10,2) DEFAULT 0.00,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);

CREATE TABLE accessLogs (
    id BIGSERIAL PRIMARY KEY,
    licenses_id BIGINT REFERENCES licenses(id),
    ipAddress VARCHAR(45),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INTEGER,
    modified_id INTEGER
);


INSERT INTO categories (name) VALUES ('Action'), ('RPG'), ('Adventure'), ('Strategy'), ('Indie');
INSERT INTO developers (studioName, countryOrigin) VALUES ('FromSoftware', 'Japan'), ('CD Projekt', 'Poland'), ('Supergiant', 'USA'), ('Team Cherry', 'Australia'), ('Santa Monica', 'USA');
INSERT INTO games (title, price, developers_id, categories_id) VALUES 
('Elden Ring', 59.99, 1, 2), ('The Witcher 3', 39.99, 2, 2), ('Hades', 24.99, 3, 1), ('Hollow Knight', 14.99, 4, 3), ('God of War', 49.99, 5, 1);
INSERT INTO users (userName, email, password, walletBalance) VALUES 
('tyrone_dev', 'ty@mail.com', '123', 100.00), ('juan_gamer', 'j@mail.com', '123', 50.00), ('ana_rpg', 'a@mail.com', '123', 25.00), ('carla_v', 'c@mail.com', '123', 200.00), ('luis_s', 'l@mail.com', '123', 0.00);
INSERT INTO licenses (users_id, games_id) 
SELECT u.id, g.id FROM users u, games g WHERE u.userName = 'tyrone_dev' AND g.title = 'Elden Ring';
INSERT INTO licenses (users_id, games_id) 
SELECT u.id, g.id FROM users u, games g WHERE u.userName = 'juan_gamer' AND g.title = 'Hades';
INSERT INTO accessLogs (licenses_id, ipAddress) VALUES (1, '192.168.1.10'), (2, '192.168.1.11');
