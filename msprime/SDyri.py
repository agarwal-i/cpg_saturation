import msprime
import math
import random
import numpy as np
import IPython # So that we can show plots
import matplotlib.pyplot as plt
import seaborn as sns
import sys
import tskit

Ne = [41100,41100,18543,18543,13957,13957,13579,13579,13998,13998,14790,14790,15927,15927,17473,17473,19524,19524,22146,22146,25269,25269,28538,28538,31332,31332,33012,33012,33256,32900,32311,31233,28248,24560,24560,20871,20871,17828,17828,15152,15152,13476,13476,12864,12639,12501,13031,13547,13981,14279,14356,13292,10733,11856, 1000000]
T= [107690, 87454,75618,67220,60705,55383,50883,46984,43546,40470,37688,35148,32811,30648,28633,26749,24980,23311,21733,20235,18811,17453,16155,14913,13721,12576,11474,10412,9388, 8398, 7441, 6514, 5274, 4917, 4578, 4256, 3949, 3655, 3374, 3104, 2845, 2596, 2356, 2124, 1900, 1684, 1474, 1271, 1073, 882, 696, 515, 339, 167, 50]

yri_schiffels_durbin_initial = [
        msprime.PopulationConfiguration(
            sample_size=1, initial_size=10000000, growth_rate=0)
    ]

yri_schiffels_durbin = [
    #msprime.PopulationParametersChange(time=T[56], initial_size=Ne[56], growth_rate=0, population_id=0),
    #msprime.PopulationParametersChange(time=T[56], initial_size=0, growth_rate=0, population_id=1),
    #msprime.PopulationParametersChange(time=T[56], initial_size=Ne[56], growth_rate=0),
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

dd = msprime.DemographyDebugger(
    population_configurations=yri_schiffels_durbin_initial,
    demographic_events=yri_schiffels_durbin)
#dd.print_history()
