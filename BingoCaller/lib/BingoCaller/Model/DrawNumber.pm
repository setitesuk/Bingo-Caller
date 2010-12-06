#############
# $Id$
# Created By: setitesuk
# Last Maintained By: $Author$
# Created On: 
# Last Changed On: $Date$
# $HeadURL$

package BingoCaller::Model::DrawNumber;

use strict;
use warnings;
use Carp;
use Readonly; Readonly::Scalar our $VERSION => do { my ($r) = q$Revision: 8991 $ =~ /(\d+)/mxs; $r; };

use List::Util qw( shuffle );

use base 'Catalyst::Model';

## no critic (Documentation::RequirePodAtEnd)

=head1 NAME

BingoCaller::Model::DrawNumber

=head1 VERSION

$Revision: 8991 $

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SUBROUTINES/METHODS

=head2 draw_number

Draws a random number between 1 and the max value given as an option, that has not already been drawn.

  my $iDrawnNumber = $oBingoCallerModelDrawNumber->new( {
    max_value => $iMaxValue,
    already_drawn => $aDrawnNumbers,
  } );

=cut

sub draw_number {
  my ( $self, $arg_refs ) = @_;

  my $max_value = $arg_refs->{max_value};
  my $already_drawn = {};
  foreach my $drawn_number ( @{ $arg_refs->{already_drawn} } ) {
    $already_drawn->{$drawn_number}++;
  }

  my @to_pick_from;
  foreach my $value ( 1..$max_value ) {
    if ( ! $already_drawn->{$value} ) {
      push @to_pick_from, $value;
    }
  }

  return (shuffle @to_pick_from)[0];
}



1;
__END__

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Carp

=item Readonly

=item Catalyst::Model::DBIC::Schema

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

$Author$

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2010 Andy Brown (setitesuk@gmail.com)

This file is part of NPG.

NPG is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

