#!/bin/bash
chr=$1

# wget -nd biobank.ndph.ox.ac.uk/ukb/ukb/auxdata/UKBexomeOQFEbim.zip
# unzip UKBexomeOQFEbim.zip
# wget https://biobank.ndph.ox.ac.uk/ukb/ukb/auxdata/xgen_plus_spikein.GRCh38.bed

./gfetch 23155 -c$chr
./gfetch 23155 -c$chr -m
