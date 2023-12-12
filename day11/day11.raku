my @matrix = $*ARGFILES.lines».comb».Array;

# silly
sub rotate-matrix(@matrix) {
    my @rotated;
    for ^@matrix[0].elems -> $i {
        my @row;
        for @matrix.reverse -> @col {
            push @row, @col[$i];
        }
        push @rotated, @row;
    }
    return @rotated;
}

sub duplicate-rows(@matrix) {
    my @matches;
    for @matrix -> @row {
        if any(@row) eq "#" {
            @matches.push(@row);
        } else {
            # @matches.push(@row);
            # @matches.push(@row);

            # Part 2
            # code efficiency? nah just bruteforce
            for 0..1000000 {
                @matches.push(@row);
            }
        }
    }
    return @matches
}

# Basically duplicates the rows, rotates and duplicates again to handle columns too
my @expanded_matrix = duplicate-rows(rotate-matrix(duplicate-rows(@matrix)));

my @matches = @expanded_matrix.keys X @expanded_matrix[0].keys;
my @galaxies = grep { @expanded_matrix[$_[0]][$_[1]] eq "#" }, @matches;

my $sum = 0;
# Manhattan ftw
for 0..@galaxies.elems-1 -> $i {
    for $i+1..@galaxies.elems-1 -> $j {
        my ($x1, $y1) = @galaxies[$i];
        my ($x2, $y2) = @galaxies[$j];
        $sum += ($x2 - $x1).abs + ($y2 - $y1).abs;
    }
}

$sum.say;
