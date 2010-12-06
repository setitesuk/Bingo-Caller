# $Id$
use strict;
use warnings;
use Carp;
use English qw{-no_match_vars};
use Test::More 'no_plan';#tests => ;
use Test::Exception;
use lib qw{t};

BEGIN {
  use_ok( q{BingoCaller::Model::DrawNumber} );
}

{

  my $draw_number;
  lives_ok {
    $draw_number = BingoCaller::Model::DrawNumber->new();
  } q{object created ok};

  isa_ok( $draw_number, q{BingoCaller::Model::DrawNumber}, q{$draw_number} );

  my $drawn_numbers = [ (1, 3..48, 50..90) ];

  my %potential_draw = (
    2 => 1,
    49 => 1,
  );

  foreach my $count ( 1..25 ) {
    my $result;
    lives_ok {
      $result = $draw_number->draw_number( {
        max_value => 90,
        already_drawn => $drawn_numbers,
      } );
    } q{draw_number method ok};
    ok( $potential_draw{ $result }, q{drawn number ok} );
  }




}
1;