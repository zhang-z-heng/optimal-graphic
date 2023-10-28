#-----------------
# PRICING PROBLEM
#-----------------
param source symbolic in N;
param target symbolic in N;

param b {i in N} := if i = target then 1 else ( if i = source then - 1 else 0 );

# Pricing subproblem cost vector
param g {A} default 1;
param sigma {K} default 0;

var z {A} binary;

minimize ShortestPath: 
	 sum {(i,j) in A} g[i,j] * z[i,j];

s.t. NodeBalance {i in N}: 
     sum {(j,i) in A} z[j,i] - sum {(i,j) in A} z[i,j] = b[i];