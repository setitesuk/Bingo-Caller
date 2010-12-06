use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'BingoCaller' }
BEGIN { use_ok 'BingoCaller::Controller::Game' }

ok( request('/game')->is_success, 'Request should succeed' );
done_testing();
