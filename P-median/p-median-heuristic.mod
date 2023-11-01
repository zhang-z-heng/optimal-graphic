#--------------------------------------------------
# Sets and parameters
#--------------------------------------------------

# Set of potential locations
param n > 0 default 7;
set I := 1..n;

# Set of customers
param m > 0 default 21;
set J := 1..m;

# Distance matrix 
param g {I,J} default 1;

# Number of facilities to open
param p default int(n/3);

# k-opt size
param k default int(p/2);

# current solution in terms of facilities
set SOL within I default {};
# current solution in terms of customer-facility assignments
set PAIRSOL within I cross J;



#--------------------------------------------------
# ILP model and k-opt
#--------------------------------------------------

# Assign customer j at facility installed at location i
var x {I,J} binary;

# Installed a facility at location j
var y {I}  binary;

# Minimize the cost of transportation from the opened facilities to the customer
minimize Cost:
	sum {i in I, j in J} g[i,j]*x[i,j];

# Assign each customer to a single facility
s.t. Assign {j in J}:
	sum {i in I} x[i,j] == 1;

# Open p facilities
s.t. Pconstraint:
	sum {i in I} y[i] == p;

# Link the assignment with the facility variables
s.t. Link {i in I, j in J}:
	x[i,j] <= y[i];

# k-opt constraint
s.t. size: sum{i in I diff SOL} y[i] + sum{i in SOL}(1-y[i]) +
 sum{(i,j) in PAIRSOL} (1-x[i,j]) + sum{(i,j) in I cross J diff PAIRSOL} x[i,j] <= k;



#--------------------------------------------------
# Auxiliary sets and parameters
#--------------------------------------------------

# Set of opened facilities 
set PI within I default {};
	
# Set of customer-facility assignments
set PJ within {I,J} default {};
 
set CI within I default I;

param si;
param a_ij;
param best_cost default 0;


