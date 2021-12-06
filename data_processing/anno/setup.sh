#!/bin/bash
#cat ../regions/gnomad.exome.20xcov.bed ../regions/ukb.regions.hg19.bed | awk '{print $1"\t"$2-2"\t"$3+2}' | \
#	sort -k 1,1 -k2,2n | \
#	bedtools merge -i stdin | \
#	bedtools intersect -a stdin -b ../regions/gnomad.wgs.regions.hg19.bed | \
#	bedtools intersect -a stdin -b ../regions/gencode.hg19.exons.bed | \
#	awk '{for(i=$2+1;i<=$3;i++) print $1"\t"i-2"\t"i+1}' | \
#	bedtools getfasta -fi ../ref/hg19.fa -bed stdin -bedOut | awk '{print $1"\t"$2+1"\t"$3-1"\t"$4 > "bed/tmp."$1".bed"}'
#wait

#for chr in {1..22} X; do split -d -n l/40 bed/tmp.chr$chr.bed bed/tmp.chr$chr.bed.; done
#wait

for chr in {1..22} X
	do
	for p in {00..39}
		do
		Rscript makevcf.R bed/tmp.chr$chr.bed.$p vep_in/tmp.chr$chr.n$p.vcf
		wait
		bgzip -f vep_in/tmp.chr$chr.n$p.vcf
		wait
		tabix vep_in/tmp.chr$chr.n$p.vcf.gz
		wait
		qsub -l mem=60G,time=12:00:00 -N job_chr${chr}_$p -cwd annotate_vep.sh $chr $p
#		#qsub -w depend=afterok:job_chr$chr_$p -l mem=20G,time=2:00:00 -cwd process_anno.sh $chr
		done
	done
