# vi:set syntax=perl:

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Math::Business::MACD',
    'VERSION_FROM' => 'MACD.pm',
    'PREREQ_PM'    => {'Math::Business::EMA'=>"1.06"},
);
