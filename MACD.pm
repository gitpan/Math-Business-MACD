package Math::Business::MACD;

use strict;
use warnings;

our $VERSION = '0.96';

use Carp;
use Math::Business::EMA;

1;

sub new { 
    bless {
        slow_EMA => new Math::Business::EMA,
        fast_EMA => new Math::Business::EMA,
        trig_EMA => new Math::Business::EMA,
        days     => 0,
    } 
}

sub set_days {
    my $this = shift;
    my ($slow, $fast, $trig) = @_;

    croak "slow days must be a positive non-zero integers" if $slow <= 0;
    croak "fast days must be a positive non-zero integers" if $fast <= 0;
    croak "trig days must be a positive non-zero integers" if $trig <= 0;

    $this->{days} = 1;

    $this->{slow_EMA}->set_days($slow);
    $this->{fast_EMA}->set_days($fast);
    $this->{trig_EMA}->set_days($fast);
}

sub query {
    my $this = shift;

    return $this->{fast_EMA}->query - $this->{slow_EMA}->query;
}

sub insert {
    my $this  = shift;
    my $value = shift;;

    croak "You must set the number of days before you try to insert" if not $this->{days};

    $this->{slow_EMA}->insert($value);
    $this->{fast_EMA}->insert($value);

    $this->{trig_EMA}->insert( $this->query );
}

sub query_trig_ema { my $this = shift; return $this->{trig_EMA}->query }
sub query_slow_ema { my $this = shift; return $this->{slow_EMA}->query }
sub query_fast_ema { my $this = shift; return $this->{fast_EMA}->query }

__END__

=head1 NAME

Math::Business::MACD - Perl extension for calculating MACDs

=head1 SYNOPSIS

  use Math::Business::MACD;

  my $macd = new Math::Business::MACD;

  my ($slow, $fast, $trigger) = (26, 12, 9);

  set_days $macd $slow, $fast, $trigger;

  my @closing_values = qw(
      3 4 4 5 6 5 6 5 5 5 5 
      6 6 6 6 7 7 7 8 8 8 8 
  );

  foreach(@closing_values) {
      $macd->insert( $_ );
      print "       MACD: ", $macd->query,          "\n",
            "Trigger EMA: ", $macd->query_trig_ema, "\n",
            "   Fast EMA: ", $macd->query_fast_ema, "\n",
            "   Slow EMA: ", $macd->query_slow_ema, "\n";
  }

=head1 AUTHOR

Jettero Heller jettero@cpan.org

http://www.voltar.org

=head1 SEE ALSO

perl(1), Math::Business::EMA(3).

=cut
