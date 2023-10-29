# Lab 3: greedy for the p-median problem

# Set of potential locations
param n > 0;
set I := 1..n;

# Set of customers
param m > 0;
set J := 1..m;

# Assignment matrix 
param g {I,J} default 1;

# Number of facilities to open
param p default int(n/3);

# LP model

# Assign customer j at facility installed at location i
var x {I,J} <=1, >=0; # binary;

# Installed a facility at location j
var y {I} <=1, >=0;# binary;

# Minimize the cost of transportation from the opened facilities to the customer
minimize Cost:
	sum {i in I, j in J} g[i,j]*x[i,j];

# Assign each customer to a single facility
s.t. Assign {j in J}:
	sum {i in I} x[i,j] == 1;

# Open p facility
s.t. Pconstraint:
	sum {i in I} y[i] == p;

# Link the assignment with the facility variables
s.t. Link {i in I, j in J}:
	x[i,j] <= y[i];
	
problem pmedian: x, y, Cost, Assign, Pconstraint, Link;

#--------------------------------------------------
# Greedy Algorithm - Additional data structure
#--------------------------------------------------
	
# Set of opened facilities
set PJ within {I,J} default {}; #selected pairs client facility
set PI within I default {}; #selected facilities
set CI within I default I; # candidate sites not already selected
set CJ within J default J; #unassigned clients

param si;
param sj;
