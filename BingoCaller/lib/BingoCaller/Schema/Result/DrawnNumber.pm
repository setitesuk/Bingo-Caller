package BingoCaller::Schema::Result::DrawnNumber;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

BingoCaller::Schema::Result::DrawnNumber

=cut

__PACKAGE__->table("drawn_numbers");

=head1 ACCESSORS

=head2 game_id

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 drawn_number

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 order_drawn

  data_type: INTEGER
  default_value: undef
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
  "drawn_number",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "order_drawn",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.05000 @ 2010-11-21 08:42:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VyedsXejmnsebRF5ff3DZQ

__PACKAGE__->add_unique_constraint( 
  game_drawnno => [ qw{ game_id drawn_number } ],
);

__PACKAGE__->belongs_to( q{game}, q{BingoCaller::Schema::BingoGame}, 
  { game_id => q{game_id} },
);

1;
