#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(max);

my @hands;

while (<>) {
    chomp;
    my ($hand, $bid) = split / /;
    my $orighand = $hand;
    $hand =~ tr/AKQJT98765432/ABCDEFGHIJKLM/;

    # part 2
    # $hand =~ tr/AKQT98765432J/ABCDEFGHIJKLZ/;
    my %counts;
    my $noJokers = $hand;
    my $numJokers = $noJokers =~ tr/Z//d;
    ++$counts{$_} foreach split //, $noJokers;
    my %nums;
    ++$nums{$_} foreach values %counts;
    if ($numJokers > 0) {
        my $highest = max (0, keys %nums);
        --$nums{$highest};
        ++$nums{$highest + $numJokers};
    }

    my $cat;
    if ($nums{5}) {$cat = 1;}
    elsif ($nums{4}) {
        $cat = 2;
    } elsif ($nums{3} && $nums{2}) {
        $cat = 3;
    } elsif ($nums{3}) {
        $cat = 4;
    } elsif (defined $nums{2} && $nums{2} == 2) {
        $cat = 5;
    } elsif ($nums{2}) {
        $cat = 6;
    } elsif ($nums{1} == 5) {
        $cat = 7;
    }
    push @hands, [$cat, $hand, $bid, $orighand];
}

@hands = sort { ($b->[0] <=> $a->[0]) || ($b->[1] cmp $a->[1]) } @hands;

my $rank = 1;
my $total = 0;

foreach my $hand (@hands) {
    my ($category, $hand, $bid, $orighand) = @$hand;
    $total += $rank * $bid;
    ++$rank;
}

print "Total winnings: $total\n";
