# Get simulators from Fuller et al 2019

# compile simulators
## standard Shiffels Durbin for EUR
# g++ -O3 -std=c++11 BRand.cpp population.cpp main_sd.cpp -o simulator_sd
## standard Shiffels Durbin for EUR with 10 million for last 50 gen (mod)
# g++ -O3 -std=c++11 BRand.cpp population.cpp main_sd_mod.cpp -o simulator_mod_sd
## tennessen EUR model from https://github.com/molpopgen/TennessenEAonly
# g++ -O3 -std=c++11 BRand.cpp population.cpp main_tenn.cpp -o simulator_tenn
## constant pop size
# g++ -O3 -std=c++11 BRand.cpp population.cpp main_constant.cpp -o simulator_constant

# run simulations
# for i in {1..100}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-7 0.04 0 0.5 $i cpgti_10mil_fixedu abc; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-7 0.04 0 1 $i cpgti_10mil_fixedu sel; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-7 0.04 0 0.5 $i cpgti_10mil_fixedu neutral; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-9 1 0 0.5 $i ta_10mil_fixedu neutral; done
# for i in {1..500}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-9 1 0 0.5 $i ta_10mil_fixedu abc; done
# for i in {1..200}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.2e-8 0.1 0 0.5 $i oth_10mil_fixedu abc; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 1.6e-8 0.1 0 0.5 $i mid_10mil_fixedu neutral; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim.sh 50000 5e-9 24 0 0.5 $i xpg_10mil_fixedu neutral; done
# for i in {1..20}; do qsub -l mem=2G,time=1:00:00 -cwd batch_sim_demography.sh 50000 1.2e-7 0.04 0 1 $i cpgti_10mil_fixedu abc; done

##output
# cat out/XX/*txt > out/XX.txt | gzip
