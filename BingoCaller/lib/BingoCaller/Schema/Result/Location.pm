package BingoCaller::Schema::Result::Location;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

BingoCaller::Schema::Result::Location

=cut

__PACKAGE__->table("location");

=head1 ACCESSORS

=head2 location_id

  data_type: INTEGER
  default_value: undef
  is_nullable: 0
  size: undef

=head2 name

  data_type: TEXT
  default_value: undef
  is_nullable: 0
  size: undef

=cut

__PACKAGE__->add_columns(
  "location_id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("location_id");


# Created by DBIx::Class::Schema::Loader v0.05000 @ 2011-05-14 11:48:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Epj3i1ZftJ17ePID1l0ZKA


__PACKAGE__->add_unique_constraint( 
  location_name => [ qw{ name } ] 
);

__PACKAGE__->has_many( q{games}, q{BingoCaller::Schema::BingoGame},
  { q{foreign.location_id} => q{self.location_id} },
);

1;
