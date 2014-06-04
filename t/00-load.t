#!perl -T

use Test::More;

BEGIN {
    use_ok('TVRage::Client::Client');
}

diag( "Testing TVRage::Client $TVRage::Client::VERSION, Perl $], $^X" );

done_testing();
