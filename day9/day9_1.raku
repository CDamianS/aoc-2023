sub p { return @_ ?? @_[*-1] + p(@_[1..*] Z- @_) !! 0;}
lines().map(*.words).map(&p).sum.say;
