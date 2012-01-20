package BingoCaller::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

BingoCaller::Controller::Root - Root Controller for BingoCaller

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}


=head2 game_setup

Setup this game with parameters given

=cut

sub game_setup :Local {
  my ( $self, $c ) = @_;

  my $location_rs = $c->model( 'BingoCallerDB::Location' )->find_or_create(
    {
      name => $c->req->body_params->{location},
    },
  );

  my $max_ball = $c->req->body_params->{max_ball};

  my $game_rs = $c->model( 'BingoCallerDB::BingoGame' )->create(
    {
      location_id => $location_rs->location_id(),
      max_bingo_value => $max_ball,
    },
  );

  my $full_batch = join q{ }, (1..$max_ball);

  my $number_rs = $c->model( 'BingoCallerDB::Number' )->create(
    {
      game_id => $game_rs->game_id(),
      drawn_numbers => q{},
      remaining_numbers => $full_batch,
    },
  );

  my $location = $location_rs->name();
  my $game_id = $game_rs->game_id();

  $c->stash(
    game_id => $game_id,
    location => $location,
  );

}

=head2 game_start

Starts the game and draws the first ball

=cut

sub game_start :Local {
  my ( $self, $c ) = @_;

  my $drawnumber = $c->model( 'DrawNumber' );
  $drawnumber->game_id( $c->req->body_params->{game_id} );
  $drawnumber->context( $c );
  $drawnumber->clear_drawn_numbers_cache();


  my $line_drawn = $c->req->body_params->{line_drawn} || 0;
  $c->stash(
    game_id => $drawnumber->game_id(),
#    ball_img => $drawnumber->ball_img( $drawnumber ),
    line_drawn => $line_drawn,
    drawn_number => $drawnumber->draw_number(),
    draw_number_model => $drawnumber,
    template => 'draw_number.tt',
  );

}

=head2 draw_next_ball

=cut

sub draw_next_ball :Local {
  my ( $self, $c ) = @_;

  my $line_drawn = $c->req->body_params->{line_drawn};
  my $drawnumber = $c->model( 'DrawNumber' );
  $drawnumber->game_id( $c->req->body_params->{game_id} );
  $drawnumber->context( $c );

  $c->stash(
    game_id => $drawnumber->game_id(),
    line_drawn => $line_drawn,
    drawn_number => $drawnumber->draw_number(),
    draw_number_model => $drawnumber,
    template => 'draw_number.tt',
  );
}

=head2 house

=cut

sub house :Local {
  my ( $self, $c ) = @_;

  my $drawnumber = $c->model( 'DrawNumber' );
  $drawnumber->game_id( $c->req->body_params->{game_id} );
  $drawnumber->context( $c );
  $drawnumber->clear_drawn_numbers_cache();

  $c->stash(
    game_id => $drawnumber->game_id(),
    line_drawn => 1,
    last_drawn_number => $drawnumber->last_drawn_number(),
    draw_number_model => $drawnumber,
#    all_numbers => $c->model( 'DrawNumber' )->sorted_drawn_numbers(),
  );
}

=head2 line

=cut

sub line :Local {
  my ( $self, $c ) = @_;
  
  my $line_drawn = $c->req->body_params->{line_drawn};
  my $drawnumber = $c->model( 'DrawNumber' );
  $drawnumber->game_id( $c->req->body_params->{game_id} );
  $drawnumber->context( $c );
  $drawnumber->clear_drawn_numbers_cache();

  $c->stash(
    game_id => $drawnumber->game_id(),
    line_drawn => $line_drawn,
    last_drawn_number => $drawnumber->last_drawn_number(),
    draw_number_model => $drawnumber,
#    all_numbers => $c->model( 'DrawNumber' )->sorted_drawn_numbers(),
  );
}

=head2 house_won

=cut

sub house_won :Local {
  my ( $self, $c ) = @_;
  $c->stash(
    house_won => 1,
    template => 'index.tt',
  );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 ball_image

=cut

sub ball_image :Local {
  my ( $self, $c ) = @_;

  my $ball = $c->req->params->{ball_number};
  use Test::More; diag explain $c->req->params();
  my $drawnumber = $c->model( 'DrawNumber' );

  $c->res->content_type(qq{img/png});
  $c->res->body( $drawnumber->ball_img( $ball ) );
  return;
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Andy Brown

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
