package BingoCaller::Controller::Game;
use Moose;
use Readonly;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

Readonly::Scalar our $CONTROLLER => q{game};

=head1 NAME

BingoCaller::Controller::Game - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BingoCaller::Controller::Game in Game.');
}

=head2 base

Can place common logic to start chained dispatch here

=cut

sub base :Chained( '/' ) :PathPart( 'game' ) :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    # Print a message to the debug log
    $c->log->debug('*** Controller Game ***');

    return;
}

=head2 start

=cut

sub start :Chained( 'base' ) :PathPart( 'start' ) :Args(0) {
  my ( $self, $c ) = @_;
  $c->stash->{template} = qq{$CONTROLLER/start.tt};
  return;
}

=head2 draw

=cut

sub draw :Chained( 'base' ) :PathPart( 'draw' ) :Args(0) {
  my ( $self, $c ) = @_;
  $c->stash->{template} = qq{$CONTROLLER/draw.tt};
}

=head1 AUTHOR

Andy Brown

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

