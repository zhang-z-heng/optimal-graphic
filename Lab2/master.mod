#-----------------
# MASTER PROBLEM
#-----------------
# Number of nodes
param n; 
set N := 1..n;
set A within N cross N;

param c{A};              # Arc cost
param u{A} ;  # Arc capacitiy

# Number and set of demands 
param n_d; 
set K := 1..n_d;

param s {K} within N; # Source
param t {K} within N; # Destination
param d {K}; # Flow demand

# Number and set of paths
param n_p; 
set P := 1..n_p;
set Path {P} within N cross N;


param or  {P} within N;  # Origin
param dest  {P} within N;  # Destination
param cp {P};  # Cost


var x {P} >= 0;

minimize PathCost:
	sum {p in P} cp[p]*x[p];

s.t. PathBalance {k in K}: 
	sum {p in P: or[p] = s[k] and dest[p] = t[k]} x[p] = d[k];
	
s.t. PathCapacity {(i,j) in A}: 
     sum {p in P: (i,j) in Path[p]} x[p] <= u[i,j];