# vi:fdm=marker fdl=0 syntax=perl:
# $Id: main.t,v 1.2 2002/06/05 01:06:36 jettero Exp $

use Test;

@close = qw(
    5 6 7 8 7 8 7 8 9 6 5 43 3 65 7 7 4 6 3 6 3 6 3
);

plan tests => 1 + int(@close);

use Math::Business::MACD; ok 1;

$macd = new Math::Business::MACD;

$macd->set_days(26, 12, 9);

foreach(@close) {
    $macd->insert( $_ ); ok 1;
    printf STDERR " Close: \%5.2f, MACD: \%4.2f, Trigger EMA: \%4.2f\n", $_, $macd->query, $macd->query_trig_ema;
}