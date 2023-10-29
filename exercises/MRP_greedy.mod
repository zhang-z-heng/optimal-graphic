#------------------------------------------------------
# Auxiliary data for the greedy algorithm
#------------------------------------------------------

# Set of vertices in the solution
set C within N;


# Set of edges with at least an endpoint in C
set F := setof{(i,j) in E: i in C or j in C} (i,j);

# Set of uncovered edges
set U := E diff F;

# set of uncovered edges incident in each node
set IS {i in N} := (setof {j in N: (i,j) in U} (i,j)) 
		union (setof {j in N: (j,i) in U} (j,i));

# Number of uncovered edges covered by  each vertex
param degree {i in N} := card(IS[i]);
