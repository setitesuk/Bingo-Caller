create table bingo_game (
  game_id INTEGER PRIMARY KEY NOT NULL,
  location_id INTEGER NOT NULL,
  max_bingo_value INTEGER NOT NULL,
  seconds_between_calls INTEGER NOT NULL DEFAULT 5
);

create table location (
  location_id INTEGER PRIMARY KEY NOT NULL,
  name TEXT NOT NULL
);

create table drawn_numbers (
  game_id INTEGER NOT NULL,
  drawn_number INTEGER NOT NULL,
  order_drawn INTEGER NOT NULL
);

create table numbers (
  game_id INTEGER NOT NULL,
  drawn_numbers TEXT,
  remaining_numbers TEXT
);

CREATE UNIQUE INDEX game_drawnno on drawn_numbers (game_id, drawn_number);
CREATE UNIQUE INDEX game_numbers on numbers (game_id);
CREATE UNIQUE INDEX loc_name on location (name);