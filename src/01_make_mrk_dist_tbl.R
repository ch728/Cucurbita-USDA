library(tidyverse)

pepo_filt <- read.csv("genotype/data/cpepo_filt.map", stringsAsFactors=F, header=F)
pepo_raw <- read.csv("genotype/data/cpepo_raw.map", stringsAsFactors=F, header=F)
pepo_filt_gp <- pepo_filt %>% group_by(V2) %>% summarize(Filtered=n())
pepo_raw_gp <- pepo_raw %>% group_by(V2) %>% summarize(Raw=n())
pepo_comb <- merge(pepo_raw_gp, pepo_filt_gp, by="V2")
colnames(pepo_comb)[1] <- c("Chromosome") 
pepo_comb <- rbind(pepo_comb, data.frame(Chromosome="Total",
					 Raw=sum(pepo_raw_gp$Raw),
					 Filtered=sum(pepo_filt_gp$Filtered)))


moschata_filt <- read.csv("genotype/data/cmoschata_filt.map", stringsAsFactors=F, header=F)
moschata_raw <- read.csv("genotype/data/cmoschata_raw.map", stringsAsFactors=F, header=F)
moschata_filt_gp <- moschata_filt %>% group_by(V2) %>% summarize(Filtered=n())
moschata_raw_gp <- moschata_raw %>% group_by(V2) %>% summarize(Raw=n())
moschata_comb <- merge(moschata_raw_gp, moschata_filt_gp, by="V2")
colnames(moschata_comb)[1] <- c("Chromosome") 
moschata_comb <- rbind(moschata_comb, data.frame(Chromosome="Total",
					 Raw=sum(moschata_raw_gp$Raw),
					 Filtered=sum(moschata_filt_gp$Filtered)))



maxima_filt <- read.csv("genotype/data/cmaxima_filt.map", stringsAsFactors=T, header=F)
maxima_raw <- read.csv("genotype/data/cmaxima_raw.map", stringsAsFactors=T, header=F)
maxima_filt_gp <- maxima_filt %>% group_by(V2) %>% summarize(Filtered=n())
maxima_raw_gp <- maxima_raw %>% group_by(V2) %>% summarize(Raw=n())
maxima_comb <- merge(maxima_raw_gp, maxima_filt_gp, by="V2")
colnames(maxima_comb)[1] <- c("Chromosome") 
maxima_comb <- rbind(maxima_comb, data.frame(Chromosome="Total",
					 Raw=sum(maxima_raw_gp$Raw),
					 Filtered=sum(maxima_filt_gp$Filtered)))

all <- cbind(pepo_comb, moschata_comb, maxima_comb)
tbl <- knitr::kable(all)
con=file("figures/mrk_tbl.md")
writeLines(tbl, con)
close(con)




