args <- commandArgs(TRUE)
library(data.table)

#dnm data
df = fread("data/decode/decode.txt", header=F)
colnames(df) = c("Chr","Pos","ref","alt")
df$count = 1
df = df[, lapply(.SD, sum, na.rm=TRUE), by=list(Chr, Pos, ref, alt), .SDcols=c(match("count",colnames(df)))]
df = unique(df[,c("Chr","Pos","ref","alt","count")])
colnames(df) = c("CHROM","POS","ref","alt","count.dnm.decode")
df$POS = as.numeric(df$POS)
dnm = df

## all gnomad exomes 128k (filter=PASS)
gnomad = fread(paste0("data/gnomad_exome/chr",args[1],".txt"), header=F)
colnames(gnomad) = c("CHROM","POS","ref","alt","AN","AF","AN_nfe","AF_nfe")
gnomad$AN = as.numeric(gnomad$AN)
gnomad$AF = as.numeric(gnomad$AF)

## nfe gnomad exomes (filter=PASS)
gnomad$AN_nfe = as.numeric(gnomad$AN_nfe)
gnomad$AF_nfe = as.numeric(gnomad$AF_nfe)
gnomad$count.var.gnomad.all.exomes = ifelse(gnomad$AF > 0,1,0)
gnomad$count.var.gnomad.nfe.exomes = ifelse(gnomad$AF_nfe > 0,1,0)
#gnomad$flag.hq.gnomad.exomes = ifelse(gnomad$AN > mean(gnomad$AN, na.rm=TRUE) - 2*sd(gnomad$AN, na.rm=TRUE),1,0)
gnomad = gnomad[,c("CHROM","POS","ref","alt","count.var.gnomad.all.exomes","count.var.gnomad.nfe.exomes","AF","AN","AF_nfe","AN_nfe")]
gn_exomes = unique(gnomad)

## all gnomad genomes (filter=PASS)
gnomad = fread(paste0("data/gnomad_genome/chr",args[1],".txt"), header=F)
colnames(gnomad) = c("CHROM","POS","ref","alt","AN","AF","AN_nfe","AF_nfe")
gnomad$AF = as.numeric(gnomad$AF)
gnomad$AF_nfe = as.numeric(gnomad$AF_nfe)
gnomad$count.var.gnomad.all.genomes = ifelse(gnomad$AF>0,1,0)
gnomad$count.var.gnomad.nfe.genomes = ifelse(gnomad$AF_nfe>0,1,0)
#gnomad$flag.hq.gnomad.genomes = ifelse(gnomad$AN > mean(gnomad$AN, na.rm=TRUE) - 2*sd(gnomad$AN, na.rm=TRUE),1,0)
gnomad = gnomad[,c("CHROM","POS","ref","alt","count.var.gnomad.all.genomes", "count.var.gnomad.nfe.genomes")]
gn_genomes = unique(gnomad)

## UK Biobank
ukb = fread(paste0("data/ukb/chr",args[1],".txt"), header=F)
colnames(ukb) = c("CHROM","POS","ref","alt","AN_ukb","AF_ukb")
ukb$count.var.ukb = 1
ukb$AF_ukb = as.numeric(ukb$AF_ukb)
ukb$AN_ukb = as.numeric(ukb$AN_ukb)
#ukb$flag.hq.ukb.exomes = ifelse(ukb$AN_ukb > mean(ukb$AN_ukb,na.rm=TRUE) - 2*sd(ukb$AN_ukb, na.rm=TRUE),1,0)
ukb = ukb[,c("CHROM","POS","ref","alt","count.var.ukb","AN_ukb","AF_ukb")]
ukb = unique(ukb)

## other datasets
onekg = fread(paste0("data/1000g/chr",args[1],".txt"), header=F)[,c(1:4,6,7)]
colnames(onekg) = c("CHROM","POS","ref","alt","af_all","af_eur")
onekg = onekg[af_all>0]
onekg$count.var.1000g = 1
onekg$count.var.eur.1000g = ifelse(onekg$af_eur>0,1,0)

ghs = fread(paste0("data/ghs/chr",args[1],".txt"), header=F)
colnames(ghs) = c("CHROM","POS","ref","alt")
ghs$count.var.ghs = 1

## denom annotated
df=fread(paste0("anno/out/chr",args[1],".anno.txt.gz"), header=F)
colnames(df) = c("CHROM","POS","ref","alt","gene_id","SYMBOL","LoF","ref_context","EXON","protein_pos","CADD_phred","canonical_csq","csq_all","csq_worst","id","bval","cpg.meth.ovary","cpg.meth.sperm","flag.ukbden","flag.gnden","domain","mut","con5","con3","site")
df$context=paste0(df$con5,substr(df$mut,1,1), df$con3)
df=df[flag.gnden == 1 & flag.ukbden == 1]
df = unique(df)
head(df)

### collate

# add poly data
df = merge(df, gn_exomes, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.var.gnomad.all.exomes[is.na(df$count.var.gnomad.all.exomes)] = 0
df$count.var.gnomad.nfe.exomes[is.na(df$count.var.gnomad.nfe.exomes)] = 0

df = merge(df, gn_genomes, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.var.gnomad.all.genomes[is.na(df$count.var.gnomad.all.genomes)] = 0
df$count.var.gnomad.nfe.genomes[is.na(df$count.var.gnomad.nfe.genomes)] = 0

df = merge(df, ghs, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.var.ghs[is.na(df$count.var.ghs)] = 0

df = merge(df, ukb, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.var.ukb[is.na(df$count.var.ukb)] = 0

df = merge(df, onekg, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.var.1000g[is.na(df$count.var.1000g)] = 0
df$count.var.eur.1000g[is.na(df$count.var.eur.1000g)] = 0

# add DNM data
df = merge(df, dnm, by=c("CHROM","POS", "ref","alt"), all.x=TRUE)
df$count.dnm.decode[is.na(df$count.dnm.decode)] = 0
#df$count.dnm.decode.x[is.na(df$count.dnm.decode.x)] = 0
#df$count.dnm.ssc.case[is.na(df$count.dnm.ssc.case)] = 0
#df$count.dnm.ssc.control[is.na(df$count.dnm.ssc.control)] = 0
#df$count.dnm.ssc = ifelse(df$count.dnm.ssc.control + df$count.dnm.ssc.case == 0, 0, 1)

# all counts
df$count = 1 
df$count.var.all = ifelse(df$count.var.gnomad.all.exomes + df$count.var.gnomad.all.genomes + df$count.var.ghs + df$count.var.ukb == 0, 0, 1)
df$count.var.all.eur = ifelse(df$count.var.gnomad.nfe.exomes + df$count.var.gnomad.nfe.genomes + df$count.var.ghs + df$count.var.ukb == 0, 0, 1)
df$count.var.gnomad.ukb = ifelse(df$count.var.gnomad.nfe.exomes + df$count.var.gnomad.nfe.genomes + df$count.var.ukb == 0, 0, 1)
df$count.var.gnomad = ifelse(df$count.var.gnomad.all.exomes + df$count.var.gnomad.all.genomes == 0, 0, 1)
df$count.var.gnomad.genomes.nfe = ifelse(df$count.var.gnomad.nfe.genomes == 0, 0, 1)
df$count.var.gnomad.genomes.all = ifelse(df$count.var.gnomad.all.genomes == 0, 0, 1)
df$count.var.gnomad.exomes.nfe = ifelse(df$count.var.gnomad.nfe.exomes == 0, 0, 1)
df$count.var.gnomad.exomes.all = ifelse(df$count.var.gnomad.all.exomes == 0, 0, 1)

# test output for other project
df[duplicated(df[,c("CHROM","POS","ref","alt")])]

##################################################PENDING
# add var

df$cpg.meth.sperm = round(as.numeric(df$cpg.meth.sperm),1)
df$cpg.meth.ovary = round(as.numeric(df$cpg.meth.ovary),1)
df$flag_unknown_meth = ifelse(is.na(as.numeric(df$cpg.meth.sperm)) | is.na(as.numeric(df$cpg.meth.ovary)), 1,0)
df$mcat = ifelse(df$site=="CpG" & df$mut=="C>T" & df$cpg.meth.sperm >= 0.7 & df$cpg.meth.ovary >= 0.7, "meCpgti",
                         ifelse(df$site=="CpG" & df$mut=="C>T" & (df$cpg.meth.sperm < 0.7 | df$cpg.meth.ovary < 0.7), "otherCpGti", 
                                ifelse(df$site=="CpG" & df$mut=="C>T" & df$flag_unknown_meth==1, "otherCpGti",df$mut)))
df[duplicated(df[,c("CHROM","POS","mut")])]
        
# add var
df$csq = df$canonical_csq
df$csq = ifelse(df$LoF=="HC","LOF", df$csq)
df$csq2 = df$csq_worst
df$csq2[df$LoF=="HC"]="LOF"

df$csq = ifelse(df$csq %in% c("stop_gained","splice_acceptor_variant", "start_lost","splice_donor_variant"), "other_LOF", df$csq)
df$csq = ifelse(df$csq %in% c("splice_region_variant","upstream_gene_variant","downstream_gene_variant","5_prime_UTR_variant","3_prime_UTR_variant"), "regulatory", df$csq)
df$csq = ifelse(df$csq %in% c("stop_lost" ,"stop_retained_variant","incomplete_terminal_codon_variant","coding_sequence_variant","intron_variant"), NA, df$csq)
df = df[!is.na(csq)]

k_lookup=fread("out/k_lookup.txt", header=T)
df = merge(df, k_lookup, by=c("csq","mcat"), all.x=T)
df = df[!is.na(k)]
set.seed(10)
df = df[sample(.N,nrow(df))]
df = df[,mod:=.N%%k, by=list(csq, mcat)]
df = df[,quo:=.N%/%k, by=list(csq, mcat)]
df = df[,id := c(rep(1:(unique(quo)), each=unique(k)), rep(NA,times=unique(mod))), by=list(csq, mcat)]

## output files

out = df[, lapply(.SD, sum, na.rm=TRUE), by=list(mcat, csq, id), .SDcols=c(grep("count",colnames(df)))]
out$chr = paste0("chr",args[1])
write.table(out, file=paste0("out/var.unit.chr",args[1],".out"), quote = F, col.names = T, row.names = F, sep="\t")



