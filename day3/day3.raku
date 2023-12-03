#!/usr/bin/raku

use v6;

my @matrix = $*ARGFILES.lines».comb».Array;
my @matches = @matrix.keys X @matrix[0].keys;
my @sym_pos;
for @matches -> ($x, $y) { @sym_pos.push(($x, $y)) if @matrix[$x][$y] !~~ /\d|'.'/ ; }

my $sum = 0;

for @matrix.keys -> $elem {
    my $start = 0;
    ADJ: while $start < @matrix[$elem].elems {
        while @matrix[$elem][$start] !~~ /\d/ {
            $start++;
            last ADJ if $start >= @matrix[$elem].elems;
        }
        my $num = @matrix[$elem][$start].Int;
        my $end = $start + 1;
        while $end < @matrix[$elem].elems && @matrix[$elem][$end] ~~ /\d/ {
            $num = $num * 10 + @matrix[$elem][$end].Int;
            $end++;
        }

        my $adjacent = False;
        for @sym_pos -> [$sr, $sc] {
            $adjacent = True if $sr >= $elem-1 && $sr <= $elem+1 && $sc >= $start-1 && $sc <= $end;
        }
        $sum += $num if $adjacent;
        $start = $end;
    }
}

my @gears = @matrix.keys X @matrix[0].keys;
my @gear_pos;
my @gear_adjacencies;
for @gears -> ($x, $y) { @gear_pos.push(($x, $y)) if @matrix[$x][$y] eq '*'; }

for @matrix.keys -> $elem {
    my $start = 0;
    NUM: while $start < @matrix[$elem].elems {
        while @matrix[$elem][$start] !~~ /\d/ {
            $start++;
            last NUM if $start >= @matrix[$elem].elems;
        }
        my $num = @matrix[$elem][$start].Int;
        my $end = $start + 1;
        while $end < @matrix[$elem].elems && @matrix[$elem][$end] ~~ /\d/ {
            $num = $num * 10 + @matrix[$elem][$end].Int;
            $end++;
        }

        for @gear_pos.kv -> $gi, [$sr, $sc] {
            if $sr >= $elem-1 && $sr <= $elem+1 && $sc >= $start-1 && $sc <= $end {
                @gear_adjacencies[$gi] //= [];
                @gear_adjacencies[$gi].push($num);
            }
        }
        $start = $end;
    }
}

my $sum_two = 0;
for @gear_adjacencies -> @adj {
    $sum_two += [*] @adj if @adj.elems == 2;
}
"Part one: $sum\nPart two: $sum_two".say;
