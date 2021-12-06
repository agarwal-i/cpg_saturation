library(data.table)
args = commandArgs(trailingOnly=TRUE)
u = as.numeric(args[1])
h = args[2]
nsim = as.numeric(args[3])
array = args[4]
ufactor = args[5]
u_sd = as.numeric(args[6])

### from KScorrect implementation of loguniform
rlunif <- function(n, min, max, base=exp(1)) {
  if (mode(n) != "numeric")
    stop("'n' must be a non-empty numeric vector")
  if (any(missing(min), missing(max)))
    stop("'min' and 'max' not provided, without default.\n")
  ifelse(base == exp(1),
         return(exp(runif(n, log(min, base), log(max, base)))),
         return(base ^ (runif(n, log(min, base), log(max, base)))))
}

df = setDT(as.data.frame(rep(0,nsim)))
colnames(df) = "s"
df$h = h
df$u = 10^rnorm(nsim, log10(u)-(0.5*u_sd*u_sd*log(10)), u_sd)
df$run = 1
df$rand = rlunif(nsim, 1, 100000, base=10)
df$ufactor = ufactor
df$var_u = u_sd

df = df[,c("run","s","h","u","ufactor","var_u","rand")]
head(df)
write.table(df, file=paste0("neutral.params.",args[4],".txt"), quote=F, row.names=F, col.names=F, sep=" ")



#hist(log(prior, base=10), main="prior")
