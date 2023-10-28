#PARAMETERS

#number of items
param N; 

#number of clusters
param S default N; 

#item weight
param w{1..N};

#bin capacity
param B;

#cluster composition
param a{1..N,1..S} default 0;

#item profit for the pricing problem
#calculated as the optimal value of the dual variables of
#the current master problem
param pi{1..N} >=0 default 0;



		#####################
		#	MASTER PROBLEM	#
		#####################

#VARIABLES
#cluster selection
var l{1..S} >=0;

#OBJECTIVE
#minimize number of used bins 
minimize bin_CG: 
	sum{i in 1..S} l[i];
	
#CONSTRAINTS	
#assign each item to a bin
subject to cover{i in 1..N}: 
	sum{j in 1..S} a[i,j]*l[j] >= 1;



		#####################
		#  PRICING PROBLEM	#
		#####################	

#VARIABLES
#composition of candidate new cluster
var u{1..N}, binary;

#OBJECTIVE
#maximize profit of candidate new cluster
maximize profit:
	sum{i in 1..N} pi[i]*u[i];
		
#CONSTRAINTS		
#candidate new cluster must fit a bin
subject to capacity_pricing:
	sum{i in 1..N} w[i]*u[i] <= B;




#PROBLEM DEFINITION

problem master: l, bin_CG, cover; 

problem pricing: u, profit, capacity_pricing;

