import msprime
import math
import random
import numpy as np
import IPython # So that we can show plots
import matplotlib.pyplot as plt
import seaborn as sns
import sys
import tskit
from SDeur import eur_schiffels_durbin
from SDstructure import str_schiffels_durbin
from SDyri import yri_schiffels_durbin
from SDorig import eur_schiffels_durbin_orig
from expeur import eur_SD_exp

#############################################################################################################

def segregating_sites_count(n, u, num_replicates, pop, random_seed=None):
    t = np.zeros(num_replicates)
    S = np.zeros(num_replicates)
    F = np.zeros(num_replicates)
    t2 = np.zeros(num_replicates)
    replicates = msprime.simulate(
        random_seed=random_seed,
        #Ne=Ne,
        length = 1,
        #sample_size=n,
        mutation_rate=u,
        population_configurations = SD_initial,
        demographic_events= eval(pop),
        num_replicates=num_replicates)
    for j, tree_sequence in enumerate(replicates):
        S[j] = tree_sequence.num_sites
        tree = tree_sequence.first()
        t[j] = tree.total_branch_length
        if S[j]==1:
            F[j]=tree_sequence.allele_frequency_spectrum(polarised=True, span_normalise=False)[1]
        else:
            F[j]=0
        #F[j] = np.sum(tree_sequence.allele_frequency_spectrum(polarised=True, span_normalise=False))
    #print(S)
    #print(F)
    mean_length = np.nanmean(t)
    sd_length = np.nanstd(t)
    frac_seg = np.count_nonzero(S)/len(S)
    print(pop, current_ne, n,frac_seg, mean_length, sd_length, u, sep="\t")
    #singleton=np.count_nonzero(F)/len(F)
    #print(n,out, singleton, sep="\t")
    #print(np.mean(S))
    ##print(np.sum(1 / np.arange(1, n)) * 4*(Ne)*u) #this should match prev line under const pop size model
    #print(4*(Ne)*u)
    #print(np.sum(1 / np.arange(1, n)))

#############################################################################################################

def segregating_sites_count_str(n, u, num_replicates, pop, random_seed=None):
    t = np.zeros(num_replicates)
    S = np.zeros(num_replicates)
    F = np.zeros(num_replicates)
    t2 = np.zeros(num_replicates)
    replicates = msprime.simulate(
        random_seed=random_seed,
        #Ne=Ne,
        length = 1,
        #sample_size=n,
        mutation_rate=u,
        population_configurations = SD_initial_str,
        demographic_events= eval(pop),
        num_replicates=num_replicates)
    for j, tree_sequence in enumerate(replicates):
        S[j] = tree_sequence.num_sites
        tree = tree_sequence.first()
        t[j] = tree.total_branch_length
        if S[j]==1:
            F[j]=tree_sequence.allele_frequency_spectrum(polarised=True, span_normalise=False)[1]
        else:
            F[j]=0
        #F[j] = np.sum(tree_sequence.allele_frequency_spectrum(polarised=True, span_normalise=False))
    #print(S)
    #print(F)
    mean_length = np.nanmean(t)
    sd_length = np.nanstd(t)
    frac_seg = np.count_nonzero(S)/len(S)
    print(pop, current_ne, n,frac_seg, mean_length, sd_length, u, sep="\t")
    #singleton=np.count_nonzero(F)/len(F)
    #print(n,out, singleton, sep="\t")
    #print(np.mean(S))
    ##print(np.sum(1 / np.arange(1, n)) * 4*(Ne)*u) #this should match prev line under const pop size model
    #print(4*(Ne)*u)
    #print(np.sum(1 / np.arange(1, n)))

#############################################################################################################



n = int(sys.argv[2])
num_replicates = int(sys.argv[3])
u=float(sys.argv[4])
pop=str(sys.argv[5])
final_growth_rate=float(sys.argv[7])
current_ne = (int(sys.argv[1])/math.exp(-float(sys.argv[7])*float(sys.argv[6])))
Ne=10000 # for const pop size tests only

SD_initial_str = [
        msprime.PopulationConfiguration(
            sample_size=int(n/2), initial_size=current_ne, growth_rate=0),
        msprime.PopulationConfiguration(
            sample_size=int(n/2), initial_size=current_ne, growth_rate=0)
    ]

SD_initial = [
        msprime.PopulationConfiguration(
            sample_size=int(n), initial_size=current_ne, growth_rate=final_growth_rate)
    ]

if pop=="str_schiffels_durbin":
    segregating_sites_count_str(n, u, num_replicates, pop, random_seed=12)
else:
    segregating_sites_count(n, u, num_replicates, pop, random_seed=12)
