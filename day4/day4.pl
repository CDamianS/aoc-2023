#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(min);

open my $file, '<', 'input.txt' or die $!;
my @ll = map { chomp; $_ } <$file>;
close $file;

my $p1 = 0;
my @multiplier = (1) x @ll;
my $p2 = 0;

for my $i (0 .. $#ll) {
    my ($winning, $have) = (split /:/, $ll[$i])[1] =~ /^([^\|]+)\|(.+)$/;

    my %winning_set = map { $_ => 1 } split ' ', $winning;
    my @have = grep { exists $winning_set{$_} } split ' ', $have;

    if (@have) {
        $p1 += 2 ** (@have - 1);
    }

    my $mymult = $multiplier[$i];

    for my $j ($i + 1 .. min($i + @have, $#ll)) {
        $multiplier[$j] += $mymult;
    }

    $p2 += $mymult;
}

print "Part 1: $p1\nPart 2: $p2\n";
