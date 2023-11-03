

#-----------------
# ARC BASED FORMULATION: continuous relaxation
#-----------------

var x{A,K} >=0, <=1;
var y{A},  >=0, <=1;

minimize ND_cost: sum{ (i,j) in A} c[i,j]*y[i,j];

subject to flow_balancing{i in N, k in K}:
	sum{ (i,j) in A} x[i,j,k] - sum{ (l,i) in A} x[l,i,k] = (if i = S[k]
				then 1
				else if  i = D[k] then -1
				else 0);
				
subject to arc_capacity{(i,j) in A}:
				sum{k in K} F[k]*x[i,j,k] <= lambda*y[i,j];
						
subject to enriched_1{i in N: (sum{k in K: i=S[k]} 1) >=1}: 
		sum{(i,j) in A} y[i,j] >= ceil((sum{k in K: i=S[k]} F[k])/lambda);
		
subject to enriched_2{i in N, l in N: ((sum{k in K: i=S[k]} 1) >=1) && ((sum{k in K: l=S[k]} 1) >=1)}: 
		sum{(i,j) in A: j<>l} y[i,j] + sum{(l,j) in A: j<>i} y[l,j] >= ceil((sum{k in K: i=S[k] and l<>D[k]} F[k] + sum{k in K: l=S[k] and i<>D[k]} F[k])/lambda);
		
		
#-----------------
# integer problem
#-------------------				

var x_I{A,K} binary;
var y_I{A},  binary;

minimize ND_cost_I: sum{ (i,j) in A} c[i,j]*y_I[i,j];

subject to flow_balancing_I{i in N, k in K}:
	sum{ (i,j) in A} x_I[i,j,k] - sum{ (l,i) in A} x_I[l,i,k] = (if i = S[k]
				then 1
				else if  i = D[k] then -1
				else 0);
				
subject to arc_capacity_I{(i,j) in A}:
				sum{k in K} F[k]*x_I[i,j,k] <= lambda*y_I[i,j];
				

				





