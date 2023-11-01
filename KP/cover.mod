# Set of items
param n > 0;
set I := 1..n;

# Profit
param p{I} >= 0;

# Weigths
param w{I} >= 0;

# Knapsack capacity
param B >= 0;

# Current total number of cover inequalities
param nc default 0;
# Set of indices for the cover inequalities
set C := 1..nc;
# Set of items composing each cover
set CI{C} within I;

#--------------------------------------------------
#                 Knapsack problem
#--------------------------------------------------

# Relaxed binary Knapsack variables
var x{I} >= 0, <= 1;

# Objective function: maximize profit
maximize Profit:
	sum {i in I} p[i]*x[i];

# Capacity constraints 
subject to Capacity:
	sum {i in I} w[i]*x[i] <= B;

# Constraints for each cover inequality
subject to Cover {c in C}:
	sum {i in CI[c]} x[i] <= card(CI[c])-1;

#--------------------------------------------------
#                 Separation problem
#--------------------------------------------------

# The separation problem looks for a cover inequality
# violated by the current LP solution

# Fractional solution of current LP
param x_star{I} >= 0, <= 1;

# Binary variable for item in the cover
var u{I} binary;

# Objective function: Find the most violated cover inequality
minimize Violation: 
	sum {i in I} (1 - x_star[i])*u[i];

# Cover condition constraint
subject to CoverCondition:
	sum {i in I} w[i]*u[i] >= B+1;
