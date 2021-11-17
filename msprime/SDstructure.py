import msprime
import math
import random
import numpy as np
import IPython # So that we can show plots
import matplotlib.pyplot as plt
import seaborn as sns
import sys
import tskit

Ne_afr = [13579,13579,13998,13998,14790,14790,15927,15927,17473,17473,19524,19524,22146,22146,25269,25269,28538,28538,31332,31332,33012,33012,33256,32900,32311,31233,28248,24560,24560,20871,20871,17828,17828,15152,15152,13476,13476,12864,12639,12501,13031,13547,13981,14279,14356,13292,10733,11856, 1000000]
Ne_eur = [14068,14068,14464,14464,15208,15208,16256,16256,17618,17618,19347,19347,21534,21534,24236,24236,27367,27367,30416,30416,32060,32060,31284,29404,26686,23261,18990,12958,12958,9827,9827,7477,7477,5791,5791,4670,3841,3841,3372,3287,3359,3570,4095,4713,7540,11375,14310,14522,613285]
T_eur = [51395,47457,43984,40877,38067,35501,33141,30956,28922,27018,25231,23545,21951,20439,19000,17628,16318,15063,13859,12702,11590,10517,9482,8483,7516,6580,5672,4817,4500,4203,3922,3656,3404,3165,2936,2509,2308,2116,1930,1579,1413,1252,1096,945,656,517,383,124,50]
T_afr = [51395,47457,43984,40877,38067,35501,33141,30956,28922,27018,25231,23545,21951,20439,19000,17628,16318,15063,13859,12702,11590,10517,9482,8483,7516,6580,5672,4817,4500,4203,3922,3656,3404,3165,2936,2509,2308,2116,1930,1579,1413,1252,1096,945,656,517,383,124,50]

#T_afr= [50883,46984,43546,40470,37688,35148,32811,30648,28633,26749,24980,23311,21733,20235,18811,17453,16155,14913,13721,12576,11474,10412,9388, 8398,7441,6514,5274,4917,4578,4256,3949,3655,3374,3104,2845,2596,2356,2124,1900,1684,1474,1271,1073,882,696,515,339,167,50]

#Ne_afr = [13957,13579,13579,13998,13998,14790,14790,15927,15927,17473,17473,19524,19524,22146,22146,25269,25269,28538,28538,31332,31332,33012,33012,33256,32900,32311,31233,28248,24560,24560,20871,20871,17828,17828,15152,15152,13476,13476,12864,12639,12501,13031,13547,13981,14279,14356,13292,10733,11856, 1000000]
#T_afr= [55383,50883,46984,43546,40470,37688,35148,32811,30648,28633,26749,24980,23311,21733,20235,18811,17453,16155,14913,13721,12576,11474,10412,9388, 8398, 7441, 6514, 5274, 4917, 4578, 4256, 3949, 3655, 3374, 3104, 2845, 2596, 2356, 2124, 1900, 1684, 1474, 1271, 1073, 882, 696, 515, 339, 167, 50]

Ne = [41100,41100,18543,18543,13957,14448]
T = [107690, 87454,75618,67220,60705,55940]

#str_schiffels_durbin_initial = [
#        msprime.PopulationConfiguration(
#            sample_size=int(n/2), initial_size=10000000, growth_rate=0),
#        msprime.PopulationConfiguration(
#            sample_size=int(n/2), initial_size=10000000, growth_rate=0)
#    ]


str_schiffels_durbin = [

    msprime.PopulationParametersChange(time=T_eur[48], initial_size=Ne_eur[48], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[48], initial_size=Ne_afr[48], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[47], initial_size=Ne_eur[47], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[47], initial_size=Ne_afr[47], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[46], initial_size=Ne_eur[46], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[46], initial_size=Ne_afr[46], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[45], initial_size=Ne_eur[45], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[45], initial_size=Ne_afr[45], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[44], initial_size=Ne_eur[44], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[44], initial_size=Ne_afr[44], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[43], initial_size=Ne_eur[43], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[43], initial_size=Ne_afr[43], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[42], initial_size=Ne_eur[42], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[42], initial_size=Ne_afr[42], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[41], initial_size=Ne_eur[41], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[41], initial_size=Ne_afr[41], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[40], initial_size=Ne_eur[40], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[40], initial_size=Ne_afr[40], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[39], initial_size=Ne_eur[39], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[39], initial_size=Ne_afr[39], growth_rate=0, population_id=0),
    msprime.PopulationParametersChange(time=T_eur[38], initial_size=Ne_eur[38], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[38], initial_size=Ne_afr[38], growth_rate=0, population_id=0),
    msprime.MassMigration(time=T_afr[37], source=1, destination=0, proportion=1.0),

    #msprime.PopulationParametersChange(time=T_eur[37], initial_size=Ne_eur[37], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[37], initial_size=Ne_afr[37], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[36], initial_size=Ne_eur[36], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[36], initial_size=Ne_afr[36], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[35], initial_size=Ne_eur[35], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[35], initial_size=Ne_afr[35], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[34], initial_size=Ne_eur[34], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[34], initial_size=Ne_afr[34], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[33], initial_size=Ne_eur[33], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[33], initial_size=Ne_afr[33], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[32], initial_size=Ne_eur[32], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[32], initial_size=Ne_afr[32], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[31], initial_size=Ne_eur[31], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[31], initial_size=Ne_afr[31], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[30], initial_size=Ne_eur[30], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[30], initial_size=Ne_afr[30], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[29], initial_size=Ne_eur[29], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[29], initial_size=Ne_afr[29], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[28], initial_size=Ne_eur[28], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[28], initial_size=Ne_afr[28], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[27], initial_size=Ne_eur[27], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[27], initial_size=Ne_afr[27], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[26], initial_size=Ne_eur[26], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[26], initial_size=Ne_afr[26], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[25], initial_size=Ne_eur[25], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[25], initial_size=Ne_afr[25], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[24], initial_size=Ne_eur[24], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[24], initial_size=Ne_afr[24], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[23], initial_size=Ne_eur[23], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[23], initial_size=Ne_afr[23], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[22], initial_size=Ne_eur[22], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[22], initial_size=Ne_afr[22], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[21], initial_size=Ne_eur[21], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[21], initial_size=Ne_afr[21], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[20], initial_size=Ne_eur[20], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[20], initial_size=Ne_afr[20], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[19], initial_size=Ne_eur[19], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[19], initial_size=Ne_afr[19], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[18], initial_size=Ne_eur[18], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[18], initial_size=Ne_afr[18], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[17], initial_size=Ne_eur[17], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[17], initial_size=Ne_afr[17], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[16], initial_size=Ne_eur[16], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[16], initial_size=Ne_afr[16], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[15], initial_size=Ne_eur[15], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[15], initial_size=Ne_afr[15], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[14], initial_size=Ne_eur[14], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[14], initial_size=Ne_afr[14], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[13], initial_size=Ne_eur[13], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[13], initial_size=Ne_afr[13], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[12], initial_size=Ne_eur[12], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[12], initial_size=Ne_afr[12], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[11], initial_size=Ne_eur[11], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[11], initial_size=Ne_afr[11], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[10], initial_size=Ne_eur[10], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[10], initial_size=Ne_afr[10], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[9], initial_size=Ne_eur[9], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[9], initial_size=Ne_afr[9], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[8], initial_size=Ne_eur[8], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[8], initial_size=Ne_afr[8], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[7], initial_size=Ne_eur[7], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[7], initial_size=Ne_afr[7], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[6], initial_size=Ne_eur[6], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[6], initial_size=Ne_afr[6], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[5], initial_size=Ne_eur[5], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[5], initial_size=Ne_afr[5], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[4], initial_size=Ne_eur[4], growth_rate=0, population_id=1),    
    msprime.PopulationParametersChange(time=T_afr[4], initial_size=Ne_afr[4], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[3], initial_size=Ne_eur[3], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[3], initial_size=Ne_afr[3], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[2], initial_size=Ne_eur[2], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[2], initial_size=Ne_afr[2], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[1], initial_size=Ne_eur[1], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[1], initial_size=Ne_afr[1], growth_rate=0),
    #msprime.PopulationParametersChange(time=T_eur[0], initial_size=Ne_eur[0], growth_rate=0, population_id=1),
    msprime.PopulationParametersChange(time=T_afr[0], initial_size=Ne_afr[0], growth_rate=0),

    msprime.PopulationParametersChange(time=T[5], initial_size=Ne[5], growth_rate=0),
    msprime.PopulationParametersChange(time=T[4], initial_size=Ne[4], growth_rate=0),
    msprime.PopulationParametersChange(time=T[3], initial_size=Ne[3], growth_rate=0),
    msprime.PopulationParametersChange(time=T[2], initial_size=Ne[2], growth_rate=0),
    msprime.PopulationParametersChange(time=T[1], initial_size=Ne[1], growth_rate=0),
    msprime.PopulationParametersChange(time=T[0], initial_size=Ne[0], growth_rate=0)
]



##dd = msprime.DemographyDebugger(
##     population_configurations=str_schiffels_durbin_initial,
##     demographic_events=str_schiffels_durbin)
##dd.print_history()
