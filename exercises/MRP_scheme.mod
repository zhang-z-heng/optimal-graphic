#--------------------------------------------------
# Representation of the undirected graph
#--------------------------------------------------
param n > 0;              # Number of nodes
set N := 1..n;            # Set of nodes

# Set of active (undirected) links
set E within N cross N;

# Node cost vector
param c{N} default 1;