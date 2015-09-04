(* ::Package:: *)

BeginPackage["Interpolation`"]
	
	lagrangePolynomial::usage="LagrangePoylynomial[data, x] takes in a list of 
		data points and creates the Lagrange Polynomial that passes 
		through each point in data."
	
	cubicSpline::usage="cubicSpline[data, variable] takes in a list of data 
		points and creates a cubic spline that passes throuch each data point."

	Begin["Private`"]
		lagrangePolynomial[data_, variable_] := Module[{
			x,
			y,
			Numerator,
			Denominator,
			PolynomialTerm
		},
			x[i_]:=data[[i,1]];
			y[i_]:=data[[i,2]];
			Numerator[i_]:=Times@@(variable - Drop[x[;;],{i}]);
			Denominator[i_]:=Times@@(x[i] - Drop[x[;;],{i}]);
			PolynomialTerm[i_]:=Numerator[i]/Denominator[i] * y[i];
			Expand[Sum[PolynomialTerm[i],{i,1,Length[data]}]]
		]
		
		cubicSpline[data_,variable_] := Module[{
			(* function to get x values based on index *)
			x,
			(* function to get y values based on index *)
			y,
			(* length of data *)
			n,
			(* stores matrix for calculating cubic spline *)
			matrix,
			(* stores vector in adjacency matrix *)
			b,
			(* stores solution vector *)
			solution,
			(* polynomials being pieced together *)
			g
		},
			x[i_]:=data[[i, 1]];
			y[i_]:=data[[i, 2]];
			n = Length[data];

			(* create equations to match starting points of polynomials *)
			matrix = Table[
				PadRight[PadLeft[{x[i]^3,x[i]^2,x[i],1},4i],4(n-1)],
				{i,1,n-1}];
			b = Table[y[i],{i,1,n-1}];

			matrix = Join[matrix,Table[
				PadRight[PadLeft[{x[i]^3,x[i]^2,x[i],1},4(i-1)],4(n-1)],
				{i,2,n}]];
			b = Join[b, Table[y[i],{i,2,n}]];
	
			(* rest of b is zero *)
			b = PadRight[b,4(n-1)];
			
			(* first derivatives equal *)
			matrix = Join[matrix,Table[
				PadRight[PadLeft[{3x[i]^2,2x[i],1,0,-3x[i]^2,-2x[i],-1,0},4i],4(n-1)],
				{i,2,n-1}]];

			(* second derivatives equal *)
			matrix = Join[matrix,Table[
				PadRight[PadLeft[{6x[i],2,0,0,-6x[i],-2,0,0},4i],4(n-1)],
				{i,2,n-1}]];

			(* clamp the endpoints - curvature equals zero at x[1] and x[n] *)
			AppendTo[matrix, PadRight[{6x[1],2},4(n-1)]];
			AppendTo[matrix, PadLeft[{6x[n],2,0,0},4(n-1)]];

			solution = Inverse[matrix].b;
			Subscript[g, i_][x_]:= solution[[4(i-1)+1;;4i]].{x^3,x^2,x,1};
			Table[Subscript[g, i][variable],{i,1,n-1}]
		]
	End[]
EndPackage[]
