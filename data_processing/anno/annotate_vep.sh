#!/bin/bash
chr=$1
filen=$2

infile=vep_in/tmp.chr$chr.n$filen.vcf.gz
outfile=vep_out/tmp.chr$chr.n$filen.anno
vep_dir=/ifs/scratch/c2b2/mp_lab/ia2337/software/ensembl-vep
loftee_dir=/ifs/scratch/c2b2/mp_lab/ia2337/software/.vep/Plugins

perl $vep_dir/vep.pl -i $infile -o $outfile \
--force_overwrite --offline \
--cache --dir_cache=/ifs/scratch/c2b2/mp_lab/ia2337/software/.vep \
--dir_plugins=/ifs/scratch/c2b2/mp_lab/ia2337/software/.vep/Plugins \
--plugin LoF,loftee_path:$loftee_dir,human_ancestor_fa:$loftee_dir/human_ancestor.fa.gz,conservation_file:$loftee_dir/phylocsf_gerp.sql \
--plugin CADD,/ifs/scratch/c2b2/mp_lab/ia2337/software/.vep/Plugins/whole_genome_SNVs.tsv.gz \
--canonical \
--flag_pick_allele --pick_order rank \
--buffer_size=20000 \
--vcf

wait
bgzip -f $outfile
wait
tabix $outfile.gz
