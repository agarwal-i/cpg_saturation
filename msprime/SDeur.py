import msprime
import math
import random
import numpy as np
import sys
import tskit

Ne = [14448,14068,14068,14464,14464,15208,15208,16256,16256,17618,17618,19347,19347,21534,21534,24236,24236,27367,27367,30416,30416,32060,32060,31284,29404,26686,23261,18990,16490,16490,12958,12958,9827,9827,7477,7477,5791,5791,4670,4670,3841,3841,3372,3372,3287,3359,3570,4095,4713,5661,7540,11375,14310,13292,14522,613285] #613285
T = [55940,51395,47457,43984,40877,38067,35501,33141,30956,28922,27018,25231,23545,21951,20439,19000,17628,16318,15063,13859,12702,11590,10517,9482,8483,7516,6580,5672,5520,5156,4817,4500,4203,3922,3656,3404,3165,2936,2718,2509,2308,2116,1930,1752,1579,1413,1252,1096,945,798,656,517,383,252,124,50]

eur_schiffels_durbin_initial = [
    msprime.PopulationConfiguration(sample_size=1,initial_size=10000000)]

eur_schiffels_durbin = [
    ###msprime.PopulationParametersChange(time=T[56], initial_size=Ne[56], growth_rate=0),
    msprime.PopulationParametersChange(time=T[55], initial_size=Ne[55], growth_rate=0),
    msprime.PopulationParametersChange(time=T[54], initial_size=Ne[54], growth_rate=0),
    msprime.PopulationParametersChange(time=T[53], initial_size=Ne[53], growth_rate=0),
    msprime.PopulationParametersChange(time=T[52], initial_size=Ne[52], growth_rate=0),
    msprime.PopulationParametersChange(time=T[51], initial_size=Ne[51], growth_rate=0),
    msprime.PopulationParametersChange(time=T[50], initial_size=Ne[50], growth_rate=0),
    msprime.PopulationParametersChange(time=T[49], initial_size=Ne[49], growth_rate=0),
    msprime.PopulationParametersChange(time=T[48], initial_size=Ne[48], growth_rate=0),
    msprime.PopulationParametersChange(time=T[47], initial_size=Ne[47], growth_rate=0),
    msprime.PopulationParametersChange(time=T[46], initial_size=Ne[46], growth_rate=0),
    msprime.PopulationParametersChange(time=T[45], initial_size=Ne[45], growth_rate=0),
    msprime.PopulationParametersChange(time=T[44], initial_size=Ne[44], growth_rate=0),
    msprime.PopulationParametersChange(time=T[43], initial_size=Ne[43], growth_rate=0),
    msprime.PopulationParametersChange(time=T[42], initial_size=Ne[42], growth_rate=0),
    msprime.PopulationParametersChange(time=T[41], initial_size=Ne[41], growth_rate=0),
    msprime.PopulationParametersChange(time=T[40], initial_size=Ne[40], growth_rate=0),
    msprime.PopulationParametersChange(time=T[39], initial_size=Ne[39], growth_rate=0),
    msprime.PopulationParametersChange(time=T[38], initial_size=Ne[38], growth_rate=0),
    msprime.PopulationParametersChange(time=T[37], initial_size=Ne[37], growth_rate=0),
    msprime.PopulationParametersChange(time=T[36], initial_size=Ne[36], growth_rate=0),
    msprime.PopulationParametersChange(time=T[35], initial_size=Ne[35], growth_rate=0),
    msprime.PopulationParametersChange(time=T[34], initial_size=Ne[34], growth_rate=0),
    msprime.PopulationParametersChange(time=T[33], initial_size=Ne[33], growth_rate=0),
    msprime.PopulationParametersChange(time=T[32], initial_size=Ne[32], growth_rate=0),
    msprime.PopulationParametersChange(time=T[31], initial_size=Ne[31], growth_rate=0),
    msprime.PopulationParametersChange(time=T[30], initial_size=Ne[30], growth_rate=0),
    msprime.PopulationParametersChange(time=T[29], initial_size=Ne[29], growth_rate=0),
    msprime.PopulationParametersChange(time=T[28], initial_size=Ne[28], growth_rate=0),
    msprime.PopulationParametersChange(time=T[27], initial_size=Ne[27], growth_rate=0),
    msprime.PopulationParametersChange(time=T[26], initial_size=Ne[26], growth_rate=0),
    msprime.PopulationParametersChange(time=T[25], initial_size=Ne[25], growth_rate=0),
    msprime.PopulationParametersChange(time=T[24], initial_size=Ne[24], growth_rate=0),
    msprime.PopulationParametersChange(time=T[23], initial_size=Ne[23], growth_rate=0),
    msprime.PopulationParametersChange(time=T[22], initial_size=Ne[22], growth_rate=0),
    msprime.PopulationParametersChange(time=T[21], initial_size=Ne[21], growth_rate=0),
    msprime.PopulationParametersChange(time=T[20], initial_size=Ne[20], growth_rate=0),
    msprime.PopulationParametersChange(time=T[19], initial_size=Ne[19], growth_rate=0),
    msprime.PopulationParametersChange(time=T[18], initial_size=Ne[18], growth_rate=0),
    msprime.PopulationParametersChange(time=T[17], initial_size=Ne[17], growth_rate=0),
    msprime.PopulationParametersChange(time=T[16], initial_size=Ne[16], growth_rate=0),
    msprime.PopulationParametersChange(time=T[15], initial_size=Ne[15], growth_rate=0),
    msprime.PopulationParametersChange(time=T[14], initial_size=Ne[14], growth_rate=0),
    msprime.PopulationParametersChange(time=T[13], initial_size=Ne[13], growth_rate=0),
    msprime.PopulationParametersChange(time=T[12], initial_size=Ne[12], growth_rate=0),
    msprime.PopulationParametersChange(time=T[11], initial_size=Ne[11], growth_rate=0),
    msprime.PopulationParametersChange(time=T[10], initial_size=Ne[10], growth_rate=0),
    msprime.PopulationParametersChange(time=T[9], initial_size=Ne[9], growth_rate=0),
    msprime.PopulationParametersChange(time=T[8], initial_size=Ne[8], growth_rate=0),
    msprime.PopulationParametersChange(time=T[7], initial_size=Ne[7], growth_rate=0),
    msprime.PopulationParametersChange(time=T[6], initial_size=Ne[6], growth_rate=0),
    msprime.PopulationParametersChange(time=T[5], initial_size=Ne[5], growth_rate=0),
    msprime.PopulationParametersChange(time=T[4], initial_size=Ne[4], growth_rate=0),
    msprime.PopulationParametersChange(time=T[3], initial_size=Ne[3], growth_rate=0),
    msprime.PopulationParametersChange(time=T[2], initial_size=Ne[2], growth_rate=0),
    msprime.PopulationParametersChange(time=T[1], initial_size=Ne[1], growth_rate=0),
    msprime.PopulationParametersChange(time=T[0], initial_size=Ne[0], growth_rate=0)
]

#Use the demography debugger to print out the demographic history that we have just described.
dd = msprime.DemographyDebugger(
	demographic_events=eur_schiffels_durbin, 
	population_configurations=eur_schiffels_durbin_initial)
#dd.print_history()

