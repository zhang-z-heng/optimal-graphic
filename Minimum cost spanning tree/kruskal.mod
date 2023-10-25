# Representation of directed graphs G=(N,E)

param n > 0;              # Number of nodes
set N := 1..n;            # Set of nodes
set E within N cross N;   # Set of directed arcs


# Example of arc cost vector
param c {E} default 1;

# Set of edges in the spanning tree
set T within E default {};

# Set of edges that could be in the spanning tree
set F within E default E;

# Connected components that span the edges in T
# If cc[i]=0, vertex i is not spanned by the edges in T
# If cc[i]>0, cc[i] is the label associated with the connected component that contains vertex i 
param cc {N} default 0;	

# Set of edges with minimum cost
set MinCostEdges within E;