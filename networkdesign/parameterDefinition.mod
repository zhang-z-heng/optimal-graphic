# Number of nodes
param n; 
set N := 1..n;
set A within N cross N;

param lambda default 1;

param c {A};              # Arc cost


# Number and set of demands 
param n_d; 
set K := 1..n_d;

param S {K} within N; # Source
param D {K} within N; # Destination
param F {K}; # Flow demand


