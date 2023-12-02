#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(max);

my $game_sum_one = 0;
my $game_sum_two = 0;

while (<>) {
    my ($game) = /(\d+): /;
    if (max(/ (\d+) red/g) <= 12 && max(/ (\d+) green/g) <= 13 && max(/ (\d+) blue/g) <= 14){
     $game_sum_one += $game
    }
    $game_sum_two += max(/ (\d+) red/g) * max(/ (\d+) green/g) * max(/ (\d+) blue/g);
}

print "Part one: $game_sum_one\nPart two: $game_sum_two\n";
