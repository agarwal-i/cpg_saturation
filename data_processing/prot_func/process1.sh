library(data.table)
df = fread("prot2hg_1938_112019.csv", header=T)
df = df[type=="Site"]

df$note=gsub("propagated.*","\\1",df$note)
df$note=gsub("\\{EC.*","\\1",df$note)
df$note=gsub(" ","_",df$note)

df$secondary=sub(".*\\[([^][]+)].*|.*", "\\1", df$note)
df$secondary=ifelse(df$secondary=="","other", df$secondary)

df$feature_name = gsub(" ","_", df$feature_name)
df$domain=ifelse(df$feature_name=="nitrosylation","unknown", df$feature_name) ## this is an issue with this database, but does not impact downstream
df$domain=ifelse(df$domain=="unknown",df$secondary,df$domain)


df=df[,c("chrom","chr_start","chr_end","protein_ID","prot_start","gene","domain","note")]
write.table(df, file="prot_clean.bed",col.names=F, row.names=F, quote=F,sep="\t")
