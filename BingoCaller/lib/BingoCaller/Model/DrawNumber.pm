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

sub context {
  my ( $self, $context ) = @_;
  if ( $context ) {
    $self->{context} = $context;
  }
  return $self->{context};
}

sub game_id {
  my ( $self, $game_id ) = @_;
  if ( $game_id ) {
    $self->{game_id} = $game_id;
  }
  return $self->{game_id};
}

sub draw_number {
  my ( $self ) = @_;

  my $c = $self->context();

  my @drawn_numbers = $self->drawn_numbers();
  my @remaining_numbers = shuffle ( $self->remaining_numbers() );

  my $next_number = shift @remaining_numbers;
  push @drawn_numbers, $next_number;

  $self->store( {
    remaining_numbers => \@remaining_numbers,
    drawn_numbers => \@drawn_numbers,
  } );

  return $next_number;
}

sub last_drawn_number {
  my ( $self ) = @_;

  my $c = $self->context;

  my @drawn_numbers = $self->drawn_numbers();
  return $drawn_numbers[-1];
}

sub last_five_numbers {
  my ( $self ) = @_;

  my $c = $self->context;

  my @drawn_numbers = $self->drawn_numbers();
  my @last_five = scalar @drawn_numbers < 6 ? @drawn_numbers
                :                             @drawn_numbers[-5..-1]
                ;
  return @last_five;
}

sub drawn_numbers {
  my ( $self ) = @_;

  my $c = $self->context;

  my @number_rs = $c->model( 'BingoCallerDB::Number' )->search(
    {
      game_id => $self->game_id(),
    },
    {
      columns => [qw/drawn_numbers/],
    },
  );
warn $number_rs[0]->drawn_numbers();
  if ( ! $number_rs[0]->drawn_numbers() ) {
    return ();
  }
  my @drawn_numbers = split /[ ]/xms, $number_rs[0]->drawn_numbers();
  
  return @drawn_numbers;
}

sub sorted_drawn_numbers {
  my ( $self ) = @_;

  my $c = $self->context;
  my @drawn_numbers = sort { $a <=> $b } $self->drawn_numbers();
  return @drawn_numbers;
}

sub remaining_numbers {
  my ( $self ) = @_;

  my $c = $self->context;
  
  my @number_rs = $c->model( 'BingoCallerDB::Number' )->search(
    {
      game_id => $self->game_id(),
    },
    {
      columns => [qw/remaining_numbers/],
    },
  );

warn scalar ($number_rs[0]->remaining_numbers());
  my @remaining_numbers = split /[ ]/xms, $number_rs[0]->remaining_numbers();
#  my @remaining_numbers = split / /xms, $number_rs->get_column( 'remaining_numbers' );
warn scalar @remaining_numbers;  
  return @remaining_numbers;
}

sub store {
  my ( $self, $arg_refs ) = @_;

  my $c = $self->context;
  my $number_rs = $c->model( 'BingoCallerDB::Number' )->search(
    {
      game_id => $self->game_id(),
    }
  );
  $number_rs->update(
    {
      game_id => $self->game_id(),
      remaining_numbers => ( join q{ }, @{ $arg_refs->{remaining_numbers} } ),
      drawn_numbers => ( join q{ }, @{ $arg_refs->{drawn_numbers} } ),
    },
  );

  return;
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

Copyright (C) 2011 Andy Brown (setitesuk@gmail.com)

This file is part of BingoCaller: you can redistribute it and/or modify
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

