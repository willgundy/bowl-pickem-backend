DROP TABLE IF EXISTS user_picks;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS bowl_games;
DROP TABLE IF EXISTS bowls;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS conferences;

CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profiles (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    first_name TEXT,
    last_name TEXT,
    avatar VARCHAR,
    user_name TEXT,
    primary_color TEXT,
    secondary_color TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE bowls (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name TEXT NOT NULL,
    default_points INTEGER,
    stadium TEXT,
    location TEXT,
    payout TEXT,
    current_sponsor TEXT,
    first_year DATE,
    last_year DATE,
    alternate_names TEXT,
    image VARCHAR
);

CREATE TABLE conferences (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name TEXT NOT NULL,
    abbreviation TEXT NOT NULL,
    image VARCHAR,
    primary_color TEXT,
    secondary_color TEXT
);

CREATE TABLE teams (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name TEXT NOT NULL,
    abbreviation TEXT,
    conference_id BIGINT,
    mascot TEXT,
    primary_color TEXT,
    secondary_color TEXT,
    tertiary_color TEXT,
    helmet_image VARCHAR,
    image VARCHAR,
    current BOOLEAN NOT NULL DEFAULT FALSE,
    year_from DATE,
    year_to DATE,
    bowl_games INTEGER,
    bowl_wins INTEGER,
    bowl_losses INTEGER,
    bowl_ties INTEGER,
    FOREIGN KEY (conference_id) REFERENCES conferences (id)
);

CREATE TABLE bowl_games (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_id INTEGER NOT NULL,
    bowl_id BIGINT NOT NULL,
    year INTEGER NOT NULL,
    winner_id BIGINT,
    point_total INTEGER,
    home_team_id BIGINT,
    away_team_id BIGINT,
    home_team_score INTEGER,
    away_team_score INTEGER,
    attendance INTEGER,
    mvp TEXT,
    sponsor TEXT,
    game_date DATE,
    day_of_week TEXT,
    FOREIGN KEY (bowl_id) REFERENCES bowls (id),
    FOREIGN KEY (winner_id) REFERENCES teams (id),
    FOREIGN KEY (home_team_id) REFERENCES teams (id),
    FOREIGN KEY (away_team_id) REFERENCES teams (id)
);

CREATE TABLE user_picks (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    bowl_game_id BIGINT NOT NULL,
    pick_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (bowl_game_id) REFERENCES bowl_games (id),
    FOREIGN KEY (team_id) REFERENCES teams (id)
);

INSERT INTO users (email, password_hash) VALUES 
    ('pkbluhm@comcast.net', 'ottoshotdogs'),  
    ('willgunderson503@gmail.com', 'ottoshotdogs'),
    ('connerjohn1@comcast.net', 'ottoshotdogs'),
    ('Joeycorto2@comcast.net', 'ottoshotdogs'),
    ('kylecortopassi@gmail.com', 'ottoshotdogs'),
    ('tomcsfp@hotmail.com', 'ottoshotdogs'),
    ('garwood@gorge.net', 'ottoshotdogs'),
    ('Feltzlj@gmail.com', 'ottoshotdogs'),
    ('gundyclan@aol.com', 'ottoshotdogs'),
    ('bluhmjs@comcast.net', 'ottoshotdogs'),
    ('slong503@gmail.com', 'ottoshotdogs');

INSERT INTO profiles (user_id, first_name, last_name, avatar, user_name, primary_color, secondary_color) VALUES 
    (1, 'Paul', 'Bluhm', '', 'pkbluhm', '#00bcd4', '#ffffff'),
    (2, 'Will', 'Gunderson', '', 'willgundy', '#00bcd4', '#ffffff'),
    (3, 'Conner', 'Cortopassi', '', 'conpoop', '#00bcd4', '#ffffff'),
    (4, 'Joey', 'Cortopassi', '', 'jcort7', '#00bcd4', '#ffffff'),
    (5, 'Kyle', 'Cortopassi', '', 'primo', '#00bcd4', '#ffffff'),
    (6, 'Tom', 'Cortopassi', '', 'Al Tomaso', '#00bcd4', '#ffffff'),
    (7, 'David', 'Garwood', '', 'gar', '#00bcd4', '#ffffff'),
    (8, 'Laura', 'Feltz', '', 'LJ', '#00bcd4', '#ffffff'),
    (9, 'Dave', 'Gunderson', '', 'Dave the Wave', '#00bcd4', '#ffffff'),
    (10, 'Jim', 'Bluhm', '', 'jBluhm', '#00bcd4', '#ffffff'),
    (11, 'Stef', 'Long', '', 'sLong', '#00bcd4', '#ffffff');

INSERT INTO bowls (name, default_points, stadium, location, payout, current_sponsor, first_year, last_year, alternate_names, image) VALUES 
    ('', 0, '', '', '', '', '', '', '', ''),
    ('', 0, '', '', '', '', '', '', '', '');

INSERT INTO conferences (name, abbreviation, image, primary_color, secondary_color) VALUES 
    ('', '', '', '', ''),
    ('', '', '', '', '');

INSERT INTO teams (name, abbreviation, conference_id, mascot, primary_color, secondary_color, tertiary_color, helmet_image, image, year_from, year_to, bowl_games, bowl_wins, bowl_losses, bowl_ties) VALUES 
    ('', '', 1, '', '', '', '', '', '', '', '', 0, 0, 0, 0),
    ('', '', 1, '', '', '', '', '', '', '', '', 0, 0, 0, 0);

INSERT INTO bowl_games (status_id, bowl_id, year, winner_id, point_total, home_team_id, away_team_id, home_team_score, away_team_score, attendance, mvp, sponsor, game_date, day_of_week) VALUES 
    (1, 1, 2021, 1, 0, 1, 1, 0, 0, 0, '', '', '', ''),
    (1, 1, 2021, 1, 0, 1, 1, 0, 0, 0, '', '', '', '');

INSERT INTO user_picks (status_id, user_id, bowl_game_id, pick_id) VALUES
    (1, 1, 1, 1),
    (1, 1, 2, 1);
