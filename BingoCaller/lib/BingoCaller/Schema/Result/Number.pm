package BingoCaller::Schema::Result::Number;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

BingoCaller::Schema::Result::Number

=cut

__PACKAGE__->table("numbers");

=head1 ACCESSORS

=head2 game_id

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 drawn_numbers

  data_type: TEXT
  default_value: undef
  is_nullable: 1
  size: undef

=head2 remaining_numbers

  data_type: TEXT
  default_value: undef
  is_nullable: 1
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
  "drawn_numbers",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "remaining_numbers",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.05000 @ 2011-05-14 11:48:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hRMEO1UeRS7DTmgyPXeLdw


__PACKAGE__->add_unique_constraint( 
  game_drawnno => [ qw{ game_id } ],
);

__PACKAGE__->belongs_to( q{game}, q{BingoCaller::Schema::BingoGame}, 
  { game_id => q{game_id} },
);

1;
