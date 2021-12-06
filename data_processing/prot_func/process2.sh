library(data.table)
df = fread("prot_prelim.bed", header=F)
colnames(df)=c("chr","start","end","protein_ID","prot_start","gene","domain","note")
df=df[order(chr, start, end),]
df = df[, domain_list:=toString(unique(domain)),by = list(chr, end)]
df = df[, note_list:=toString(unique(note)),by = list(chr, end)]
set.seed(10)
df=df[df[ , .I[sample(.N,1)] , by = list(chr,end)]$V1]

df=df[,c("chr","end","protein_ID","prot_start","gene","domain","domain_list","note_list")]
write.table(df, file="prot_final.bed",col.names=F, row.names=F, quote=F,sep="\t")
