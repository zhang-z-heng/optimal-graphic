# shortest paths tree model

param n > 0;              # Number of nodes
set N := 1..n;            # Set of nodes
set A within N cross N;   # Set of arcs

#arc cost
param cost{A} >= 0;

#source node
param s symbolic in N;

#post-processing parameter
param index;


var x{A} >= 0;


#objective
minimize SPTCost: sum{(i,j) in A} cost[i,j]*x[i,j];


#constraints
subject to balance{i in 1..n}:
	sum{(i,j) in A} x[i,j] - sum{ (k,i) in A} x[k,i] = (if i = s
				then n-1
				else -1);