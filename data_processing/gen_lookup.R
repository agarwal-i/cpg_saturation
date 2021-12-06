library(data.table)

chr.list = c(seq(1,22,1))
exon=vector('list')
for (i in 1:length(chr.list)){
    exon[[i]] = fread(paste0("out/var.chr",chr.list[i],".out"), header=T)
}
df=rbindlist(exon)
df$csq = ifelse(df$csq %in% c("stop_gained","splice_acceptor_variant", "start_lost","splice_donor_variant"), "other_LOF", df$csq)
df$csq = ifelse(df$csq %in% c("splice_region_variant","upstream_gene_variant","downstream_gene_variant","5_prime_UTR_variant","3_prime_UTR_variant"), "regulatory", df$csq)
df$csq = ifelse(df$csq %in% c("stop_lost" ,"stop_retained_variant","incomplete_terminal_codon_variant","coding_sequence_variant","intron_variant"), NA, df$csq)
df = df[!is.na(csq)]
df = df[, lapply(.SD, sum, na.rm=TRUE), by=list(mcat, csq), .SDcols=c(grep("count",colnames(df)))]
df = df[,c("mcat","csq","count.dnm.decode","count")]
df$rate = df$count.dnm.decode/df$count
norm = df[mcat=="meCpgti"]
norm$mcat=NULL
df = df[!is.na(mcat)]
df = merge(df, norm, by=c("csq"))
df$k = floor(df$rate.y/df$rate.x,0)
df = df[!is.na(k)][!k==Inf]
df = df[,c("mcat","csq","k")]

k_lookup = df
write.table(k_lookup, file="out/k_lookup.txt", col.names=T, row.names=F, quote=F, sep="\t")

