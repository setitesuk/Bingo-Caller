package BingoCaller::Schema::Result::BingoGame;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

BingoCaller::Schema::Result::BingoGame

=cut

__PACKAGE__->table("bingo_game");

=head1 ACCESSORS

=head2 game_id

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 location_id

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 max_bingo_value

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 seconds_between_calls

  data_type: INTEGER
  default_value: 5
  is_nullable: 0
  size: undef

=cut

__PACKAGE__->add_columns(
  "game_id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "location_id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "max_bingo_value",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "seconds_between_calls",
  { data_type => "INTEGER", default_value => 5, is_nullable => 0, size => undef },
);
__PACKAGE__->set_primary_key("game_id");


# Created by DBIx::Class::Schema::Loader v0.05000 @ 2010-11-22 08:01:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LLCXLBkomYhe+CrGyyQDBw

__PACKAGE__->belongs_to( q{location}, q{BingoCaller::Schema::Location}, 
  { location_id => q{location_id} },
);

__PACKAGE__->has_many( q{drawn_numbers}, q{BingoCaller::Schema::DrawnNumber},
  { q{foreign.game_id} => q{self.game_id} },
);
1;
