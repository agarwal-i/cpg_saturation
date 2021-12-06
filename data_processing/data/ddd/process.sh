#!/bin/bash

Rscript makevcf.R raw/41586_2020_2832_MOESM3_ESM.txt

wait
source makebed.sh
