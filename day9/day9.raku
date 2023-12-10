my @data = lines("input.txt").map: { .words.map: *.Int };
sub p { $_ ?? $_[0] + p |[R-] @_ !! 0 };
sub p-t { $_ ?? @_[0] - p-t |[R-] @_[1..*] !! 0 }
say @data.map({p($_)}).sum ~ "\n" ~ @data.map({p-t($_)}).sum;
