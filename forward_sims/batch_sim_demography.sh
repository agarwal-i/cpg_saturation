#!/bin/bash

nsim=$1
mutationrate=$2
ufactor=$3
u_sd=$4
dom=$5
arrayid=$6
dirlabel=$7
type=$8 #fixed_sel prior neutral

mkdir -p out/constant_${type}_${dirlabel}
mkdir -p out/mod_sd_${type}_${dirlabel}
mkdir -p out/sd_${type}_${dirlabel}
mkdir -p out/tenn_${type}_${dirlabel}

Rscript get_${type}_params.R $mutationrate $dom $nsim $arrayid $ufactor $u_sd
wait
while read i ; do ./simulator_sd $i ; done < $type.params.$arrayid.txt > out/sd_${type}_${dirlabel}/$arrayid.txt
#while read i ; do ./simulator_mod_sd $i ; done < $type.params.$arrayid.txt > out/mod_sd_${type}_${dirlabel}/$arrayid.txt
#while read i ; do ./simulator_constant $i ; done < $type.params.$arrayid.txt > out/constant_${type}_${dirlabel}/$arrayid.txt
while read i ; do ./simulator_tenn $i ; done < $type.params.$arrayid.txt > out/tenn_${type}_${dirlabel}/$arrayid.txt
