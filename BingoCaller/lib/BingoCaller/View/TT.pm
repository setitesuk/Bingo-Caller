package BingoCaller::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
  TEMPLATE_EXTENSION => '.tt',
  EVAL_PERL => 1,
  WRAPPER => q{bingocaller_wrapper.tt},
  INCLUDE_PATH => [
      BingoCaller->path_to( 'root', 'src' ),
    ],
#	LOAD_FILTERS => [ $FILTERS ],
);

=head1 NAME

BingoCaller::View::TT - TT View for BingoCaller

=head1 DESCRIPTION

TT View for BingoCaller.

=head1 SEE ALSO

L<BingoCaller>

=head1 AUTHOR

Andy Brown

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
