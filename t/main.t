# vi:fdm=marker fdl=0 syntax=perl:
# $Id: main.t,v 1.3 2002/10/13 15:25:03 jettero Exp $

use Test;

@close = qw(
    5 6 7 8 7 8 7 8 9 6 5 43 3 65 7 7 4 6 3 6 3 6 3
);

plan tests => 2 + int(@close);

use Math::Business::MACD; ok 1;

$macd = new Math::Business::MACD;

$macd->set_days(26, 12, 9);

foreach(@close) {
    $macd->insert( $_ ); ok 1;
    printf STDERR " Close: \%5.2f, MACD: \%4.2f, Trigger EMA: \%4.2f\n", $_, $macd->query, $macd->query_trig_ema;
}

# ok, we don't actually check the calculation...
# but at least we know this works syntatically. ;)
$macd->start_with(
    $macd->query_slow_ema,
    $macd->query_fast_ema,
    $macd->query_trig_ema,
);

ok 1;
