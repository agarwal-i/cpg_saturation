#!/bin/bash
chr=$1

#bedtools intersect -a bed/tmp.chr$chr.bed -b ../meth/ovary.bed -wb | awk '{print $1"\t"$3"\t"$8}' > int/tmp.chr$chr.ovary.bed
#bedtools intersect -a bed/tmp.chr$chr.bed -b ../meth/sperm.bed -wb | awk '{print $1"\t"$3"\t"$8}' > int/tmp.chr$chr.sperm.bed
#bedtools intersect -a bed/tmp.chr$chr.bed -b ../bmap_mcvicker/bmap_hg19/chr$chr.hg19.bmap -wb | awk '{print $1"\t"$3"\t"$8}' > int/tmp.chr$chr.bstat.bed
#bedtools intersect -a bed/tmp.chr$chr.bed -b ../regions/gnomad.exome.20xcov.bed | awk '{print $1"\t"$3"\t1"}' > int/tmp.chr$chr.gnden.bed
#bedtools intersect -a bed/tmp.chr$chr.bed -b ../regions/ukb.regions.hg19.bed | awk '{print $1"\t"$3"\t1"}' > int/tmp.chr$chr.ukbden.bed
#wait

for filen in {00..39}
do
	infile=vep_out/tmp.chr$chr.n$filen.anno.gz

	bcftools view $infile|\
	bcftools +split-vep -f %CHROM"\t"%POS"\t"%REF"\t"%ALT"\t"%BIOTYPE"\t"%Feature"\t"%SYMBOL"\t"%CANONICAL"\t"%LoF"\t"%ID"\t"%CADD_RAW"\t"%CADD_PHRED"\t"%EXON"\t"%Protein_position"\t"%Consequence'\n' -d -a CSQ |\
	awk '{if ($5=="protein_coding") print}' > int/tmp.chr${chr}_$filen.anno
	bgzip -f int/tmp.chr${chr}_$filen.anno
	wait

	Rscript clean_anno.R $chr $filen
done

wait

for filen in {00..39}
do
	cat int/tmp.chr${chr}_$filen.out >> out/chr${chr}.anno.txt
done
wait
bgzip -f out/chr${chr}.anno.txt
