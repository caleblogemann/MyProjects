(* ::Package:: *)

BeginPackage["SIR`"]
	SIR::usage="";
	SEIR::usage="";
	SimulateDistribution::usage="";
	dosageByRegion::usage="";
	dosageZero::usage="";
	dosageByRegionPopulation::usage="";
	dosageByNewCasesThisWeek::usage="";
	dosageByNewCasesNextWeek::usage="";
	dosageByExistingCasesThisWeek::usage="";
	dosageByExistingCasesNextWeek::usage="";
	dosageByTotalInfectedProjection::usage="";
	dosageByThirdHighest::usage="";
	dosageByThirdLowest::usage="";
	dosageByInfectedPopulation::usage="";
	Begin["Private`"]
		SIR[\[Beta]_, \[Gamma]_, population_, initialInfected_,medicineProvided_]:=Module[{
			(* stores list of # of susceptible people on each day *)
			s,
			(* stores list of # of infected people on each day *)
			i,
			(* stores list of # of recovered people on each day *)
			r,
			(* time step *)
			\[CapitalDelta]t,
			(* current day in model *)
			t,
			(* function for change in s *)
			\[CapitalDelta]s,
			(* function for change in i *)
			\[CapitalDelta]i,
			(* function for change in r *)
			\[CapitalDelta]r,
			numberCured,
			newCases,
			totalInfected,
			iPerWeek,
			newCasesPerWeek
		},
			s = {population};
			i = {initialInfected};
			r = {0};
			newCases = {initialInfected};
			totalInfected = initialInfected;

			(* use a time step of one day *)
			\[CapitalDelta]t = 1;
			(* start at day one *)
			t = 1;

			(* number cured each day with medicine *)
			numberCured = medicineProvided/7;

			(* change in states *)
			\[CapitalDelta]s[n_]:= (-\[Beta] s[[n]] i[[n]])/population \[CapitalDelta]t;
			\[CapitalDelta]i[n_]:= ((\[Beta] s[[n]] i[[n]])/population-\[Gamma] i[[n]])\[CapitalDelta]t - numberCured;
			\[CapitalDelta]r[n_]:= \[Gamma] i[[n]]\[CapitalDelta]t + numberCured;

			While[Last[i]>=1,
				(* add new state *)
				AppendTo[newCases,-\[CapitalDelta]s[t]];
				totalInfected += -\[CapitalDelta]s[t];
				AppendTo[s,s[[t]]+\[CapitalDelta]s[t]];
				AppendTo[i,i[[t]]+\[CapitalDelta]i[t]];
				AppendTo[r,r[[t]]+\[CapitalDelta]r[t]];

				(* update t *)
				t+=\[CapitalDelta]t;
			];
			(* change data into weeks *)
			newCasesPerWeek = Table[Sum[newCases[[j]],{j,7(k-1)+2,Min[7k + 1,Length[newCases]]}],
				{k,1,Ceiling[Length[newCases]/7]}];
			iPerWeek = Table[i[[Min[7j,Length[newCases]]]],{j,1,Ceiling[Length[newCases]/7]}];

			(* return values *)
			{totalInfected,iPerWeek,newCasesPerWeek}
		];

		SEIR[\[Beta]0_,k_,offset_,\[Gamma]_,\[Sigma]_,initialSusceptible_,initialExposed_,initialInfected_,initialRemoved_,totalDoses_]:=
		Module[{
			(* stores list of # of susceptible people on each day *)
			s,
			(* stores list of # of susceptible people on each day *)
			e,
			(* stores list of # of infected people on each day *)
			i,
			(* stores list of # of recovered people on each day *)
			r,
			(* store total population *)
			population,
			(* time step *)
			\[CapitalDelta]t,
			(* current day in model *)
			t,
			(* function for changing values of reproduction *)
			\[Beta],
			(* function for change in s *)
			\[CapitalDelta]s,
			(* function for change in e *)
			\[CapitalDelta]e,
			(* function for change in i *)
			\[CapitalDelta]i,
			(* function for change in r *)
			\[CapitalDelta]r,
			numberDosesPerDay,
			(* data *)
			newCases,
			newCasesPerWeek,
			sWeek,
			eWeek,
			iWeek,
			rWeek,
			(* variables to store new state *)
			newS,
			newE,
			newI,
			newR
		},
			s = {initialSusceptible};
			e = {initialExposed};
			i = {initialInfected};
			r = {initialRemoved};
			
			population = initialSusceptible + initialExposed + initialInfected + initialRemoved;

			(* use a time step of one day *)
			\[CapitalDelta]t = 1;
			(* start at day one *)
			t = 1;
			
			(* set up function for changing \[Beta] value *)			
			\[Beta][t_]:=\[Beta]0 E^(-k(t+offset));
			numberDosesPerDay = totalDoses/7;
			(* change in states *)
			\[CapitalDelta]s := (-\[Beta][t] Last[s]Last[i]/population)\[CapitalDelta]t;
			\[CapitalDelta]e := (\[Beta][t] Last[s]Last[i]/population - \[Sigma] Last[e])\[CapitalDelta]t;
			\[CapitalDelta]i := (\[Sigma] Last[e]-\[Gamma] Last[i] - numberDosesPerDay)\[CapitalDelta]t;
			\[CapitalDelta]r := (\[Gamma] Last[i]+numberDosesPerDay)\[CapitalDelta]t;
			
			(* data to collect *)
			newCases = {initialInfected};
			
			While[Last[e]>=1||Last[i]>=1,
				(*
				Print[t];
				Print[s];
				Print[e];
				Print[i];
				Print[r];*)

				(* find new state *)
				newS = Last[s]+\[CapitalDelta]s;
				newE = Max[0,Last[e]+\[CapitalDelta]e];
				newI = Max[0,Last[i]+\[CapitalDelta]i];
				newR = Last[r]+\[CapitalDelta]r;
				
				AppendTo[newCases,\[Sigma] Last[e]];

				(* add new state *)
				AppendTo[s,newS];
				AppendTo[e,newE];
				AppendTo[i,newI];
				AppendTo[r,newR];

				(* update t *)
				t=t+\[CapitalDelta]t;
			];

			(* change data into weeks *)
			(* remove initial day *)
			s = Drop[s,1];
			e = Drop[e,1];
			i = Drop[i,1];
			r = Drop[r,1];
			newCases = Drop[newCases,1];
			(* sum new cases, take every seventh day *)
			newCasesPerWeek = Table[Sum[newCases[[j]],{j,7(l-1)+1,Min[7l + 1,Length[newCases]]}],
				{l,1,Ceiling[Length[newCases]/7]}];
			(*AppendTo[newCasesPerWeek,0];*)
			sWeek = Table[s[[Min[7j,Length[s]]]],{j,1,Ceiling[Length[s]/7]}];
			eWeek = Table[e[[Min[7j,Length[e]]]],{j,1,Ceiling[Length[e]/7]}];
			iWeek = Table[i[[Min[7j,Length[i]]]],{j,1,Ceiling[Length[i]/7]}];
			rWeek = Table[r[[Min[7j,Length[r]]]],{j,1,Ceiling[Length[r]/7]}];

			{sWeek, eWeek, iWeek, rWeek,newCasesPerWeek,Total[newCasesPerWeek]+initialInfected}
		]

		SimulateDistribution[dosageFunction_,projectionFunction_,populations_,initialInfected_,initialExposed_,
			weekInfected_,dosesPerWeek_,manufacturingPeriod_,\[Beta]_,k_,\[Gamma]_,\[Sigma]_]:=Module[{
				numRegions,
				totalInfected,
				newCasesPerRegion,
				infectedPerRegion,
				activeRegions,
				totalInfectedPerRegion,
				w,
				i,
				j,
				activateRegions,
				projections,
				InitialProjection,
				activateRegion,
				newCases,
				newInfected,
				projectNextWeek,
				numS,
				numE,
				numI,
				numR,
				dosage
			},
			(* initial infected number of people initially infected
				weekInfected is week initial infection break out *)

			numRegions = Length[populations];
			
			(* list of all regions True if active False if inactive *)
			activeRegions = Table[weekInfected[[i]]==1,{i,1,numRegions}];

			(* Data to return *)
			(* double arrays *)
			infectedPerRegion = Table[{If[activeRegions[[i]],initialInfected[[i]],0]},{i,1,numRegions}];
			newCasesPerRegion = infectedPerRegion;
			(* single array *)
			totalInfectedPerRegion = Flatten[infectedPerRegion,2];
			(* number *)
			totalInfected = Total[totalInfectedPerRegion];

			projections = ConstantArray[0,numRegions];

			(* projectionFunction[\[Beta], k, offset, \[Gamma], \[Sigma], susceptible, exposed, infected, removed, doses] *)
			(* projectionFunction returns {iPerWeek,newCasesPerWeek,s,e,i,r,newCases} *)

			(* function to do intial projection of region *)
			InitialProjection[n_]:=projectionFunction[\[Beta],k,0,\[Gamma],\[Sigma],populations[[n]],initialExposed[[n]],initialInfected[[n]],0,0];

			(* function to check if region should have first infection or should become activated *)
			activateRegion[n_]:=If[weekInfected[[i]] == w+1,
				(* If region should have first infection next week*)
				newCases = initialInfected[[i]];
				totalInfected+=newCases;
				totalInfectedPerRegion[[i]]=newCases;
				AppendTo[newCasesPerRegion[[i]],newCases];
				AppendTo[infectedPerRegion[[i]],newCases];
			,
				If[weekInfected[[i]]==w,
					(* if region just became active, just had first case *)
					projections[[i]] = InitialProjection[i];

					newInfected = projections[[i,3,1]];
					newCases = projections[[i,5,1]];

					totalInfected+=newCases;
					totalInfectedPerRegion[[i]]+=newCases;
					AppendTo[newCasesPerRegion[[i]],newCases];
					AppendTo[infectedPerRegion[[i]],newInfected];

					activeRegions[[i]]=True;
				,
					(* else if week is inactive add zeroes where necessary *)
					AppendTo[newCasesPerRegion[[i]],0];
					AppendTo[infectedPerRegion[[i]],0];
				]
			];

			(* function to project to next week *)
			projectNextWeek[dosages_]:=For[i = 1, i<=numRegions,i++,
				(* create new projection *)
				If[activeRegions[[i]],
					(* get data from this week *)
					numS = projections[[i,1,1]];
					numE = projections[[i,2,1]];
					numI = projections[[i,3,1]];
					numR = projections[[i,4,1]];

					If[numE >= 1 || numI >= 1,
						(* If still active *)
						(* create new projection for next week *)
						projections[[i]] = projectionFunction[\[Beta],k,7(w-weekInfected[[i]]),\[Gamma],\[Sigma],numS,numE,numI,numR,dosages[[i]]];

						(* update data *)
						newInfected = projections[[i,3,1]];
						newCases = projections[[i,5,1]];

						totalInfected+=newCases;
						totalInfectedPerRegion[[i]]+=newCases;
						AppendTo[newCasesPerRegion[[i]],newCases];
						AppendTo[infectedPerRegion[[i]],newInfected];
					,
						(* If not active anymore *)
						activeRegions[[i]] = False;
						AppendTo[newCasesPerRegion[[i]],0];
						AppendTo[infectedPerRegion[[i]],0];
					];
				,
					activateRegion[i];
				];
			];
		
			(* week number *)
			w = 1;

			(* Simulate from week 1 to week 2*)
			For[i = 1, i <= numRegions,i++,
				activateRegion[i];
			];

			(* now on week 2 *)
			w = 2;
			
			(* Simulate time while medicine is being manufactured *)
			For[j=1,j <= manufacturingPeriod-1,j++,
				projectNextWeek[ConstantArray[0,numRegions]];
				w++;
			];
			While[AnyTrue[activeRegions,TrueQ],
				(* determine dosage for each region *)
				(* TODO fill in dosageFunction parameters *)
				dosage = dosageFunction[populations,dosesPerWeek,activeRegions,projections];
				projectNextWeek[dosage];
				w++;
			];

			{totalInfected, totalInfectedPerRegion,infectedPerRegion, newCasesPerRegion}
		];

		dosageByRegion[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			totalActiveRegions,
			dosage,
			i,
			j
		},
			dosage = {};
			totalActiveRegions = 0;
			For[j=1, j<=Length[activeRegions], j++,
				If[activeRegions[[j]], 
					totalActiveRegions += 1;
				];
			];
			For[i = 1, i <= Length[activeRegions], i++,
				If[activeRegions[[i]],
					AppendTo[dosage,(totalDoses/totalActiveRegions)];,
					AppendTo[dosage,0]
				];
			];
			dosage
		];

		dosageZero[populations_,totalDoses_,activeRegions_,projections_]:=ConstantArray[0,Length[activeRegions]];

		(* population per region / total population *)
		dosageByRegionPopulation[populations_, totalDoses_, activeRegions_, projections_] :=Module[{
			dosage,
			totalPopulation,
			j
		},
			dosage = {};
			totalPopulation=0;
			For[j=1, j<=Length[activeRegions], j++,
				If[activeRegions[[j]], 
					totalPopulation  += populations[[j]];
				];
			];
			For[j=1, j<= Length[activeRegions], j++, 
				If[activeRegions[[j]], 									
					AppendTo[dosage, ((populations[[j]]*totalDoses)/totalPopulation)];,
					AppendTo[dosage, 0];
				];
			];
			dosage
		];

		(*this week:# new cases/total new cases*)
		dosageByNewCasesThisWeek[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			i
		},
			dosage = {};
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]],
					AppendTo[dosage,projections[[i,5,1]]];
				,
					AppendTo[dosage,0];
				];
			];
			If[Total[dosage]!=0,
				dosage=(dosage/Total[dosage]) * totalDoses;
			];
			dosage
		];

		(*next week:# new cases/total new cases*)
		dosageByNewCasesNextWeek[populations_, totalDoses_, activeRegions_, projections_]:=Module[{
			dosage,
			i
		},
			dosage = {};
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]] && Length[projections[[i,5]]]>=2,
					AppendTo[dosage,projections[[i,5,2]]],
					AppendTo[dosage,0]
				];
			];
			If[Total[dosage]!=0,
				dosage=((dosage*totalDoses)/Total[dosage]);
			];
			dosage
		];

		(*this week:# existing cases/total # existing cases*)
		dosageByExistingCasesThisWeek[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			i
		},
			dosage = {};
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]] && Length[projections[[i,3]]]>=1,
					AppendTo[dosage,projections[[i,3,1]]];
				,
					AppendTo[dosage,0];
				];
			];
			If[Total[dosage]!=0,
				dosage=(dosage/Total[dosage]) * totalDoses;
			];
			dosage
		];

		(*next week:# existing cases/total # existing cases*)
		dosageByExistingCasesNextWeek[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			i
		},
			dosage = {};
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]] && Length[projections[[i,3]]]>=2,
					AppendTo[dosage,projections[[i,3,2]]];
				,
					AppendTo[dosage,0];
				];
			];
			If[Total[dosage]!=0,
				dosage=(dosage/Total[dosage]) * totalDoses;
			];
			dosage
		];

		(* total infected projection / sum of total infected projections *)
		dosageByTotalInfectedProjection[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			i
		},
			dosage = {};
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]],
					AppendTo[dosage,projections[[i,6]]];,
					AppendTo[dosage,0];
				];
			];
			If[Total[dosage]!=0,
				dosage=(dosage/Total[dosage]) * totalDoses;
			];
			dosage
		];

		(* dosage divided evenly between regions with three highest regions *)
		dosageByThirdHighest[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			cases,
			ordering,
			thirdOfRegions,
			numSent,
			i
		},
			dosage = ConstantArray[0,Length[activeRegions]];
			cases = {};
			thirdOfRegions = Ceiling[Length[activeRegions]/3];
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]],
					AppendTo[cases,projections[[i,3,1]]];,
					AppendTo[cases,0];
				];
			];
			ordering= Ordering[cases];
			numSent = 0;
			i =1;

			While[numSent < thirdOfRegions && i <= Length[activeRegions],
				If[cases[[ordering[[-i]]]]!=0 && Length[projections[[ordering[[-i]],3]]]>=2,
					numSent++;
					dosage[[ordering[[-i]]]]=projections[[ordering[[-i]],3,2]]
				];
				i++
			];
			If[Total[dosage]!=0,
				dosage = (dosage * totalDoses)/Total[dosage];
			];
			dosage
		];

		(* doseage divided evenly between regions with three lowest regions *)
		dosageByThirdLowest[populations_, totalDoses_, activeRegions_, projections_]:= Module[{
			dosage,
			cases,
			ordering,
			thirdOfRegions,
			numSent,
			i
		},
			cases = {};
			dosage = ConstantArray[0,Length[activeRegions]];
			thirdOfRegions = Ceiling[Length[activeRegions]/3];
			For[ i = 1, i<= Length[activeRegions], i++,
				If[activeRegions[[i]],
					AppendTo[cases,projections[[i,3,1]]];,
					AppendTo[cases,0];
				];
			];
			ordering= Ordering[cases];
			numSent = 0;
			i =1;
			While[numSent < thirdOfRegions && i <= Length[activeRegions],
				If[cases[[ordering[[i]]]]!=0 && Length[projections[[ordering[[i]],3]]]>=2,
					numSent++;
					dosage[[ordering[[i]]]]=projections[[ordering[[i]],3,2]]
				];
				i++
			];
			If[Total[dosage]!=0,
				dosage = dosage * totalDoses/Total[dosage];
			];
			dosage
		];

		(* dosage divided between Regions by people infected and populations*)
		dosageByInfectedPopulation[populations_, totalDoses_, activeRegions_, projections_] := Module[{
			dosage,
			totalPopulation,
			totalInfected,
			j
		},
			dosage = {};

			For[j=1, j<= Length[activeRegions], j++, 
				If[activeRegions[[j]], 									
					AppendTo[dosage, (projections[[j,3,1]]/populations[[j]])],
					AppendTo[dosage, 0];
				];
			];
			If[Total[dosage]!=0,
				dosage = dosage * totalDoses / Total[dosage];
			];
			dosage
		];
	End[]
EndPackage[]
(*SimulateDistribution[determineDosageEqual,...];*)
(*data=SIR[.1,1/20,1000000,1,0];
data\[LeftDoubleBracket]1\[RightDoubleBracket]
ListLinePlot[data\[LeftDoubleBracket]2\[RightDoubleBracket],PlotRange\[Rule]All]
ListLinePlot[data\[LeftDoubleBracket]3\[RightDoubleBracket],PlotRange\[Rule]All]*)
(*data = SEIR[.45,0.0097,0,.2,.2,350000,1,2,0,0];*)
(*Total[data\[LeftDoubleBracket]2\[RightDoubleBracket]]
ListLinePlot[data\[LeftDoubleBracket]1\[RightDoubleBracket]]
ListLinePlot[data\[LeftDoubleBracket]2\[RightDoubleBracket]]*)
(* dosageFunction, projectionFunction, populations, initialInfected, initialExposed, weekInfected *)
(* {totalInfected, totalInfectedPerRegion,infectedPerRegion, newCasesPerRegion} *)
(*SimulateDistribution[dosageByRegion,SEIR,{200000,700000,5000000},{1,2,1},{2,3,2},{1,3,4}]*)
(*\[Beta] = .38;
k = 0.0097;
\[Gamma] = 1/5.61;
\[Sigma] = 1/5.3;
populations={772873, 453746, 358190, 497948, 408390, 260910, 463668, 335401, 174249, 228392, 347197, 265758, 270462};
initialInfected={1,2,3,1,1,4,1,2,1,2,1,1,1};
initialExposed={1,1,4,1,1,3,1,3,1,1,3,5,6};
weekInfected={5,3,1,3,7,10,5,11,9,11,12,20,17};
(* SimulateDistribution[dosageFunction, projectionFunction, populations, initialInfected, initialExposed, weekInfected] *)
(* return {totalInfected, totalInfectedPerRegion, infectedPerRegionPerWeek, newCasesPerRegionPerWeek} *)
data = SimulateDistribution[dosageByTotalInfectedProjection,SEIR,populations,initialInfected,initialExposed,weekInfected,60,5,\[Beta],k,\[Gamma],\[Sigma]];
data[[1]]*)


3728/8600//N
