(* ::Package:: *)

BeginPackage["GeneticAlgorithm`"]

	geneticAlgorithm::usage = "GeneticAlgorithm[f, minX, maxX, precision, chrPerGen, numGen, mutationRate] 
		finds the maximum of the function f over the interval [minX, maxX] via a gentic algorithm using 
		chrPerGen chromosome per generation and numGen generations with a mutation rate specified by mutationRate"

	Begin["Private`"]
		
		(* binary to decimal converter - return decimal number 
			** bin - binary number as list, numInt - number integer bits, numFrac - number fractional bin*)
		binToDec[bin_,numInt_,numFrac_]:=N[If[bin[[1]]==1,-1,1]*Drop[bin,1].Table[2^i,{i,numInt-1,-numFrac,-1}]];

		(* decimal to binary converter - returns binary number as list 
			** dec - decimal number, numInt - number integer bits, numFrac - number fractional bin*)
		decToBin[dec_, numInt_, numFrac_]:=Join[{If[dec<0,1,0]},
			Table[Mod[IntegerPart[Abs[dec]/(2^i)],2],{i,numInt-1,-numFrac,-1}]]

		(* select chromosome for mating pool based on specified probability distribution and *)
		selectChromosome[x_,probabilityDistribution_]:=Min[Position[probabilityDistribution, _?(#>x&)]];
		
		(* decide whether or not to mutate a chromosome *)
		mutate[chromosome_,mutationRate_]:=If[RandomReal[] <= mutationRate, 
			toggleBit[chromosome,RandomInteger[{1,Length[chromosome]}]], chromosome];

		(* toggle a specific gene of a chromosome *)
		toggleBit[chromosome_,index_]:=ReplacePart[chromosome, index -> Mod[chromosome[[index]] + 1,2]];
	
		(* Crossover/mate two chromosomes - joins at gene specified by crossoverGene*)
		crossover[chromosome1_,chromosome2_,crossoverGene_]:= Join[chromosome1[[1;;crossoverGene]],
			chromosome2[[crossoverGene+1;;]]]

		geneticAlgorithm[f_,minX_,maxX_,precision_,chrPerGen_,numGen_,mutationRate_, showHistogram_]:= Module[{
			(* number of digits *)
			numInt,

			(* number of digits to express decimal approximation *)
			numFrac,

			(* Total Number of Binary Digits *)
			numBinDigits,

			(* List of current generations chromosomes *)
			currentGeneration,

			(* generation index *)
			generation,

			(* List of fitness values for current generations chromosomes *)
			currentGenerationFitness,

			(* Sum of currentGenerationFitness *)
			currentGenerationFitnessSum,

			(* List of probability cutoffs based on sum of fitnesses *)
			currentGenerationFitnessDistribution,

			(* pool of chromosomes to create next generation *)
			matingPool,
	
			(* list of new chromosomes for next generation *)
			nextGeneration
		},
	
			(* genes for integer precision *)
			numInt = Floor[Log[2,Max[{Abs[minX],Abs[maxX]}]]+1];
			
			(* genes for fractional precision *)
			numFrac = Abs[Floor[Log[2,10^(-1 * precision)]]];
			
			(* add up total number genes *)
			numBinDigits = 1 + numInt + numFrac;
			
			(* Create the initial generation randomly *)
			currentGeneration = Table[Table[RandomInteger[],{i,1,numBinDigits}],{j,1,chrPerGen}];
			
			(* Create next generation *)
			(* Find the fitness of current generation *)
			For[generation = 1, generation <= numGen, generation++,
				currentGenerationFitness = f[binToDec[#,numInt,numFrac]]&/@currentGeneration;

				(* print current status *)
				If[Mod[generation, 10] == 0,
					Print["Generation: "<>ToString[generation]<>" Max Value: "<>
						ToString[Max[currentGenerationFitness]]<>" at "<>
						ToString[binToDec[currentGeneration[[
							Ordering[currentGenerationFitness,-1][[1]]]], numInt, numFrac]]];
					If[showHistogram,
						Print[Histogram[binToDec[#,numInt,numFrac]&/@currentGeneration]];
					];
				];

				
				currentGenerationFitnessDistribution = Accumulate[currentGenerationFitness]/Total[currentGenerationFitness];
			
				(* Create mating pool *)
				matingPool = currentGeneration[[
					selectChromosome[#,currentGenerationFitnessDistribution]&/@RandomReal[{0,1},chrPerGen]]];

				(* Create Next Generation *)
				nextGeneration = Table[crossover[matingPool[[RandomInteger[{1,chrPerGen}]]],
					matingPool[[RandomInteger[{1,chrPerGen}]]],RandomInteger[numBinDigits]],{i,1,chrPerGen}];

				(* Mutation *)
				nextGeneration = mutate[#, mutationRate]&/@nextGeneration;
				currentGeneration = nextGeneration;
			]
		]

	End[]
EndPackage[]



