# Lagrangian relaxation with multipliers computed with a subgradient procedure
# First problem: p-median

# Set of potential locations
param n > 0 default 7;
set I := 1..n;

# Set of customers
param m > 0 default 21;
set J := 1..m;

# Distance matrix 
param g {I,J} default 1;

# Number of facilities to open
param p default 3;

# ILP model

# Assign customer j at facility installed at location i
var x {I,J} binary;

# Installed a facility at location j
var y {I} binary;

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

#--------------------------------------------------
# Lagrangian relaxation
#--------------------------------------------------

# Current solution
param x_bar {I,J} default 0;

# Lagrangian multipliers
param u0 {J} default 0;
param uk {J} default 0;

param lambda0 {I,J} default 0;
param lambda {I,J} default 0;

# Update step size
param t default 3;

# Modified costs
param c {I} default 0;
	
# Set of opened facilities
set P within I;
set C within I default I;
set B within I ordered;
param v := first(B);

#
minimize Dual1:
	sum {i in I, j in J} g[i,j]*x[i,j] + sum{j in J} uk[j] - sum{j in J, i in I} uk[j]*x[i,j];

minimize Dual2:
	sum {i in I, j in J} g[i,j]*x[i,j] + sum{i in I, j in J} lambda[i,j]*(x[i,j]-y[i]);
