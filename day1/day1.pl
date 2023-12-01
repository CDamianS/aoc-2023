#!/usr/bin/perl

use strict;
use warnings;

my $sum = 0;

# while (<>) {
#     chomp;
#     my ($first_digit) = $_ =~ /(\d)/;
#     my ($last_digit)  = $_ =~ /(\d)\D*$/;
#     $sum += $first_digit * 10 + $last_digit;
# }

# print "Part one: " . $sum . "\n";

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
    my @matches = $_ =~ /(?:one|two|three|four|five|six|seven|eight|nine)|\d/ig;
    my $first_digit = $matches[0];
    my $last_digit = $matches[-1];

    $first_digit = defined $first_digit ? $word_to_digit{$first_digit} // $first_digit : undef;
    $last_digit  = defined $last_digit ? $word_to_digit{$last_digit} // $last_digit : undef;

    if (defined $first_digit && defined $last_digit) {
        $sum += $first_digit * 10 + $last_digit;
    }
}

print "Part two: $sum\n";
