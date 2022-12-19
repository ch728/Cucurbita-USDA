library(tidyverse)
library(data.table)

set.seed(11000)

pepoLd <- data.table(fread("data/03_geno/data/ld/pepo.geno.ld"))
colnames(pepoLd) <- c("chr", "pos1", "pos2", "nidv", "r")
pepoLd <- pepoLd %>% filter(chr != 0)
pepoLdSub <- pepoLd[sample(nrow(pepoLd), 100000),]
pepoLdSub$diff <- abs(pepoLdSub$pos1 - pepoLdSub$pos2)
pepo <- cbind(pepoLdSub, species=rep("C. pepo", nrow(pepoLdSub)))

mosLd <- data.table(fread("data/03_geno/data/ld/moschata.geno.ld"))
colnames(mosLd) <- c("chr", "pos1", "pos2", "nidv", "r")
mosLd <- mosLd %>% filter(chr != 0)
mosLdSub <- mosLd[sample(nrow(mosLd), 100000),]
mosLdSub$diff <- abs(mosLdSub$pos1 - mosLdSub$pos2)
mos <- cbind(mosLdSub, species=rep("C. moschata", nrow(mosLdSub)))

maxLd <- data.table(fread("data/03_geno/data/ld/maxima.geno.ld"))
colnames(maxLd) <- c("chr", "pos1", "pos2", "nidv", "r")
maxLd <- maxLd %>% filter(chr != 0)
maxLdSub <- maxLd
maxLdSub$diff <- abs(maxLdSub$pos1 - maxLdSub$pos2)
maxima <- cbind(maxLdSub, species=rep("C. maxima", nrow(maxLdSub)))

all <- rbind(pepo, mos, maxima)
all$diff <- all$diff/1000000

p <- ggplot(all, aes(x=diff, y=r, color=species)) +
	geom_smooth(se=F, method="loess") +
	theme_bw(base_size=18) + 
	ylab(bquote(r^2)) +
	xlab("Pair-wise marker distance in Mb") +
	theme(panel.grid=element_blank(),
	      legend.text=element_text(face="italic"))
ggsave("figures/10_ld_fig.png", p, "png", height=6, width=7)


