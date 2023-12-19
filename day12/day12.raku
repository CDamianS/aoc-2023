my %mem;

sub solve(@puzzle is copy, @groups is copy) {
    my $key = @puzzle.join ~ @groups.join(',');
    return %mem{$key} if %mem{$key}.defined; return 0 if +@puzzle == 0 and +@groups > 0;

    if +@groups == 0 {
        return @puzzle.grep('#') ?? 0 !! 1;
    }

    else { return 0 if @puzzle.all eq '.'; }
    my $ans = do given @puzzle[0] {
        when '.' {
            solve(@puzzle.tail(*-1), @groups)
        }
        when '?' {
            solve(@puzzle.tail(*-1), @groups) + solve(['#', |@puzzle.tail(*-1)], @groups)
        }
        when '#' {
            return 0 if @groups[0] > +@puzzle;
            if @puzzle[^@groups[0]].all eq <# ?>.any {
                return 0 if (@puzzle[@groups[0]] // '') eq '#';
                solve(@puzzle[@groups[0]+1..*], @groups.tail(*-1))
            }
        }
    }
    %mem{$key} = $ans;
    $ans
}
my ($sum1, $sum2);
for $*IN.lines».split(' ') {
    my @groups = +«.[1].comb(/\d+/);
    $sum1 += solve(.[0].comb, @groups);
    $sum2 += solve((.[0] xx 5).join('?').comb, (@groups xx 5).flat.Array);
}

put 'part 1: ', $sum1; put 'part 2: ', $sum2;
