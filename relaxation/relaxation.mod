
### Sets and parameters of the knapsack problem

# number and set of items
param n > 0;
set I := 1..n;

# profit of each item
param p{I} default 1;

# size of each item
param w{I} default 1; #weight
param q{I} default 1; #volume
param c{I} default 1; #cost

# overall maximum size
param B1 default card(I); #weight
param B2 default card(I); #volume
param B3 default card(I); #budget



### Parameters of the relaxations

# Lagrangian relaxation multipliers 
param u1 default 0;
param u2 default 0;
param u3 default 0;

param u1_old default 1;
param u2_old default 1;
param u3_old default 1;


# surrogate relaxation multipliers
param m1 default 0;
param m2 default 0;
param m3 default 0;

param m1_old default 1;
param m2_old default 1;
param m3_old default 1;

# step for updating multipliers
param t default 1;



### Sets and parameters of the k-opt neighborhood heuristic

# current feasible solution
set selectedItems within I default {};

# size of the neighbourhood
param k default 0;


#----------------------------------------------------------
# Integer Linear Programming model for the Knapsack problem
#----------------------------------------------------------

var x{I} binary;

maximize OverallProfit:
	sum {i in I} p[i]*x[i];

subject to Capacity:
	sum {i in I} w[i]*x[i] <= B1;

subject to Volume:
	sum {i in I} q[i]*x[i] <= B2;

subject to Budget:
	sum {i in I} c[i]*x[i] <= B3;


#-----------------------------------------------------------
# Lagrangian Relaxation
#-----------------------------------------------------------

maximize LR_objective:
	sum {i in I} p[i]*x[i] + 
	u1*(B1 - sum {i in I} w[i]*x[i]) + u2*(B2 - sum {i in I} q[i]*x[i]) + u3*(B3 - sum {i in I} c[i]*x[i]);


#----------------------------------------------------------
# Surrogate Relaxation
#----------------------------------------------------------

subject to SurrogateCapacity:
	sum {i in I} m1*w[i]*x[i] + sum {i in I} m2*q[i]*x[i] + sum {i in I} m3*c[i]*x[i] <= m1*B1 + m2*B2 + m3*B3;


#----------------------------------------------------------
# k-opt Neighborhood Heuristic
#----------------------------------------------------------

subject to NeighbourhoodSize:
	sum{i in selectedItems} (1-x[i]) + sum{i in I diff selectedItems}x[i] <= k; 