sub p2 { return @_ ?? @_[0] - p2(@_[1..*] Z- @_) !! 0;}
lines().map(*.words).map(&p2).sum.say;
