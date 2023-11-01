#--------------------------------------------------
# Representation of the undirected graph
#--------------------------------------------------
param n > 0;              # Number of nodes
set N := 1..n;            # Set of nodes

# Set of active (undirected) links
set E within N cross N;

# Node cost vector
param c {N} default 1;

#------------------------------------------------------
# Auxiliary data for the LP-based randomized algorithm
#------------------------------------------------------

# Set of vertices in the cover
set C within N;

# Set of vertices with 0 < x^* < 1
set P within N ordered;

# Set of edges with at least an endpoint in C
set F := setof{(i,j) in E: i in C or j in C} (i,j);

# Set of uncovered edges
set U := E diff F;


#----------------------------------------
# Linear Programming formulation
# of the Min Node Cover problem
#----------------------------------------
var x {N} >= 0, <= 1;
#var x {N} binary;

minimize WeightedCover:
	sum {i in N} c[i]*x[i];

s.t. EdgeCover {(i,j) in U}:
	x[i] + x[j] >= 1;


#----------------------------------------
# VLSN
# of the Min Node Cover problem
#----------------------------------------

# current solution, represented by the vertex whose variables are equal to 1
set SOL within {N} default {};
# maximum allowed number of changes
param k_size default card(N)/10;



#var x{N} >= 0, <= 1;
var x_LS{N} binary;

minimize WeightedCover_LS:
	sum {i in N} c[i]*x_LS[i];

s.t. EdgeCover_LS{(i,j) in E}:
	x_LS[i] + x_LS[j] >= 1;

s.t. VLSN_size:
	sum{i in N diff SOL} x_LS[i] + sum{i in SOL}(1-x_LS[i]) <= k_size;


