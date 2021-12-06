library(data.table)

gnomad=fread("gene.list", header=F)
colnames(gnomad)=c("SYMBOL","Feature","mu_lof","chromosome")

chr.list = c(seq(1,22,1),"X")
file.list=vector('list')
for (i in 1:length(chr.list)){
  file.list[[i]] = fread(paste0("freq.chr",chr.list[i],".txt.gz"), header=FALSE)
}
freq = rbindlist(file.list)
colnames(freq) = c("chromosome","POS","REF","ALT","BIOTYPE","Feature","SYMBOL","CANONICAL","LoF","AC_nfe","AF_nfe","AN_nfe","AF","AN","AC","controls_AC_nfe","controls_AN_nfe","controls_AF_nfe","Consequence")
freq$REF = toupper(freq$REF); freq$ALT = toupper(freq$ALT)
freq$mut=paste0(freq$REF,">",freq$ALT)
freq$mut = ifelse(nchar(freq$mut)>3 | !freq$REF %in% c("A","C","T","G") | !freq$ALT %in% c("A","C","T","G"), "indel",freq$mut)
freq$AN_nfe=as.numeric(freq$AN_nfe);freq$AF_nfe=as.numeric(freq$AF_nfe);freq$controls_AF_nfe=as.numeric(freq$controls_AF_nfe)

par=fread("../../../ref/par/par_lin.txt")
colnames(par)=c("chromosome","POS")
par$par=1
freq=merge(freq, par, by=c("chromosome","POS"), all.x=T)
freq$par[is.na(freq$par)]=0
freq$flag=ifelse(freq$chromosome=="X" & freq$par==0,"non-PAR X","autosomal/PAR")

# get mean AN per gene
df = freq[order(chromosome, POS, REF, ALT, SYMBOL,Feature),]
df = unique(df, by = c("chromosome", "POS", "REF", "ALT", "SYMBOL"))
df = df[!mut=="indel"]
df = df[, mean_AN:=mean(AN_nfe, na.rm=T),by=list(flag)]
df = df[, sd_AN:=sd(AN_nfe, na.rm=T),by=list(flag)]
df$AN_nfe[df$AN_nfe<df$mean_AN-2*df$sd_AN]=NA ##AN_nfe>59613
an = df[, .(AN_nfe= mean(AN_nfe, na.rm=T)), by=list(SYMBOL, chromosome)]
qual = unique(df[,c("mean_AN","sd_AN","flag")])

# get mean AF per gene
df = freq[order(chromosome, POS, REF, ALT, SYMBOL,Feature),]
df = merge(df, qual, by=c("flag"), all.x=TRUE)
df$AF_nfe[df$mut=="indel"]= NA
df$AF_nfe[df$AN_nfe<df$mean_AN-2*df$sd_AN]= NA
df$AF_nfe[!df$LoF=="HC"]= NA
df$AF_nfe_downsampled = rbinom(nrow(df), size=as.numeric(df$controls_AN_nfe),p=df$AF_nfe)/df$controls_AN_nfe
df$AF_nfe_downsampled[df$mut=="indel" | df$AN_nfe<df$mean_AN-2*df$sd_AN | !df$LoF=="HC"] = NA
df$controls_AF_nfe[df$mut=="indel" | df$AN_nfe<df$mean_AN-2*df$sd_AN | !df$LoF=="HC"] = NA

af = df[, .(AF_nfe= sum(AF_nfe, na.rm=T), AF_nfe_downsampled= sum(AF_nfe_downsampled, na.rm=T), controls_AF_nfe= sum(controls_AF_nfe, na.rm=T)),by=list(SYMBOL, Feature, chromosome)]
df=merge(an, af, by=c("SYMBOL", "chromosome"), all.x=TRUE)
df=merge(gnomad, df, all.x=TRUE, by=c("SYMBOL", "chromosome","Feature"))

#df$AF_nfe_downsampled=rbinom(nrow(df),size=as.numeric(df$controls_AN_nfe),p=df$AF_nfe)/df$controls_AN_nfe
#df$AF_nfe_downsampled[!df$LoF=="HC"]=0
#df$controls_AF_nfe[!df$LoF=="HC"]=0
#write.table(df, file="freq.provisional.txt",sep="\t",col.names = T, row.names = F,quote = F)
#df=merge(df, gnomad, by=c("SYMBOL"))

#df=df[, .(AN_nfe= mean(AN_nfe, na.rm=T),AF_nfe= sum(AF_nfe, na.rm=T),controls_AF_nfe= sum(controls_AF_nfe, na.rm=T),AF_nfe_downsampled= sum(AF_nfe_downsampled, na.rm=T)),by=list(SYMBOL, chromosome)]
#df=merge(gene.list,df, by="SYMBOL", all.x=T)
write.table(df, file="sim.provisional.txt",sep="\t",col.names = T, row.names = F,quote = F)
