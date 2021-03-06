(* ::Package:: *)

BeginPackage["GeneticAlgorithm`"]

    geneticAlgorithm::usage = "GeneticAlgorithm[f, nGenes, chrPerGen, numGen, mutationRate] 
            finds the maximum of the function f via a gentic algorithm using 
            chrPerGen chromosomes per generation and numGen generations with a mutation rate specified by mutationRate"

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

        geneticAlgorithm[f_, nGenes_, chrPerGen_, numGen_, mutationRate_]:= Module[{
            (* store maximum fitness found so far *)
            maxFitness,

            (* store chromosome achieving maxFitness *)
            maxChr,

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
            (* Initialize variables to store answer *)
            maxFitness;
            maxChr;

            (* Create the initial generation randomly *)
            (* chrPerGen rows and nGenes columns *)
            currentGeneration = RandomInteger[{0,1},{chrPerGen, nGenes}];

            (* Create next generation *)
            For[generation = 1, generation <= numGen, generation++,
                (* Find the fitness of current generation *)
                (* maps currentGeneration to fitness function *)
                (* Creates list of fitness values *)
                currentGenerationFitness = f[#]&/@currentGeneration;
                currentMaxFitness = Max[currentGenerationFitness];
                currentMaxChr = currentGeneration[[Ordering[currentGenerationFitness,-1][[1]]]];

                (* update max fitness if necessary *)
                If[currentMaxFitness > maxFitness || generation == 1,
                    maxFitness = currentMaxFitness;
                    maxChr = currentMaxChr;
                ];

                (* print current status *)
                If[Mod[generation, 10] == 0,
                   Print["Generation: "<>ToString[generation]<>" Max Value: "<>
                        ToString[currentMaxFitness]<>" at "<>
                        ToString[currentMaxChr]
                    ];
                ];

                (* values from 0 to 1 giving ranges proportional to fitness of each chromosome *)
                currentGenerationFitnessDistribution = Accumulate[currentGenerationFitness]/Total[currentGenerationFitness];

                (* Create mating pool *)
                matingPool = currentGeneration[[
                    selectChromosome[#,currentGenerationFitnessDistribution]&/@RandomReal[{0,1},chrPerGen]]];

                (* Create Next Generation *)
                nextGeneration = Table[crossover[matingPool[[RandomInteger[{1,chrPerGen}]]],
                    matingPool[[RandomInteger[{1,chrPerGen}]]],RandomInteger[nGenes]],{i,1,chrPerGen}];

                (* Mutation *)
                nextGeneration = mutate[#, mutationRate]&/@nextGeneration;
                currentGeneration = nextGeneration;
            ]
            Return[{maxChr, maxFitness}];
        ]
    End[]
EndPackage[]
