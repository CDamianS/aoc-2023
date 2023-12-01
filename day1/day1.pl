#!/usr/bin/perl

use strict;
use warnings;

my $sum = 0;
my $sum2 = 0;

my %word_to_digit = (
    'one'   => 1,
    'two'   => 2,
    'three' => 3,
    'four'  => 4,
    'five'  => 5,
    'six'   => 6,
    'seven' => 7,
    'eight' => 8,
    'nine'  => 9
);

while (<>) {
    chomp;
    my ($first_digit) = $_ =~ /(\d)/;
    my ($last_digit)  = $_ =~ /(\d)\D*$/;
    $sum += $first_digit * 10 + $last_digit;

    my @matches = $_ =~ /(?:one|two|three|four|five|six|seven|eight|nine)|\d/ig;
    $first_digit = $matches[0];
    my $line_reversed = reverse $_;
    my @matcheslast = $line_reversed =~ /(?:eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)|\d/ig;
    $last_digit = $matcheslast[0];

    $first_digit = defined $first_digit ? $word_to_digit{$first_digit} // $first_digit : undef;
    $last_digit  = defined $last_digit ? $word_to_digit{reverse $last_digit} // $last_digit : undef;

    $sum2 += $first_digit * 10 + $last_digit;
}

print "Part one: $sum\nPart two: $sum2\n";
