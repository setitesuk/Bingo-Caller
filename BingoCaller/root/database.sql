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

CREATE UNIQUE INDEX game_drawnno on drawn_numbers (game_id, drawn_number);
CREATE UNIQUE INDEX loc_name on location (name);