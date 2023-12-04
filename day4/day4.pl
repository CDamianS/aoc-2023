#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(min);

my @lines;
my $p1 = 0;
my $p2 = 0;
while (<>) {chomp; push @lines, $_;}
my @multiplier = (1) x @lines;

for my $i (0 .. $#lines) {
    my ($winning, $have) = (split /:/, $lines[$i])[1] =~ /^([^\|]+)\|(.+)$/;
    my %winning_set = map { $_ => 1 } split ' ', $winning;
    my @have = grep { exists $winning_set{$_} } split ' ', $have;
    $p1 += 2 ** (@have - 1) if @have;

    my $mymult = $multiplier[$i];
    for my $j ($i + 1 .. min($i + @have, $#lines)) {$multiplier[$j] += $mymult;}
    $p2 += $mymult;
}

print "Part 1: $p1\nPart 2: $p2\n";
