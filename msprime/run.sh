
#!/bin/bash

### supp 1 demographic model we chose
# for n in 10000 100000 780000 1000000 10000000; do python3 exec.py 10000000 $n 20 1.2e-7 eur_schiffels_durbin 0 0 >> out.supp1.txt; done

### supp 2 structured population and alt demographies
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 10000000 $n 20 1.2e-7 eur_schiffels_durbin 0 0 >> out.supp2.txt; done
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 10000000 $n 20 1.2e-7 yri_schiffels_durbin 0 0 >> out.supp2.txt; done
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 10000000 $n 20 1.2e-7 str_schiffels_durbin 0 0 >> out.supp2.txt; done
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 100000000 $n 20 1.2e-7 eur_schiffels_durbin 0 0 >> out.supp2.txt; done
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 613285 $n 20 1.2e-7 eur_schiffels_durbin_orig 0 0 >> out.supp2.txt; done
# for n in 10000 100000 250000 500000 1000000 2500000; do python3 exec.py 15000 $n 20 1.2e-7 eur_SD_exp 196 0.045 >> out.supp2.txt; done
