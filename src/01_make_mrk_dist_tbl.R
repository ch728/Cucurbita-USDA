library(tidyverse)
library(stringr)

# Format pepo table
pepo_filt <- read.csv("data/03_geno/data/maps/cpepo_filt.map", stringsAsFactors=F, header=F)
pepo_raw <- read.csv("data/03_geno/data/maps/cpepo_raw.map", stringsAsFactors=F, header=F)
pepo_filt_gp <- pepo_filt %>% group_by(V2) %>% summarize(Filtered=n())
pepo_raw_gp <- pepo_raw %>% group_by(V2) %>% summarize(Raw=n())
pepo_raw_gp$V2 <- as.numeric(str_extract(pepo_raw_gp$V2, "[0-9][0-9]$"))
pepo_comb <- merge(pepo_raw_gp, pepo_filt_gp, by="V2")
pepo_comb <- rbind(pepo_comb, data.frame(V2="Total",
					 Raw=sum(pepo_raw_gp$Raw),
					 Filtered=sum(pepo_filt_gp$Filtered)))

# Format moschata table
moschata_filt <- read.csv("data/03_geno/data/maps/cmoschata_filt.map", stringsAsFactors=F, header=F)
moschata_raw <- read.csv("data/03_geno/data/maps/cmoschata_raw.map", stringsAsFactors=F, header=F)
moschata_filt_gp <- moschata_filt %>% group_by(V2) %>% summarize(Filtered=n())
moschata_raw_gp <- moschata_raw %>% group_by(V2) %>% summarize(Raw=n())
moschata_raw_gp$V2 <- as.numeric(str_extract(moschata_raw_gp$V2, "[0-9][0-9]$"))
moschata_comb <- merge(moschata_raw_gp, moschata_filt_gp, by="V2")
moschata_comb <- rbind(moschata_comb, data.frame(V2="Total",
					 Raw=sum(moschata_raw_gp$Raw),
					 Filtered=sum(moschata_filt_gp$Filtered)))

# Fromat maxima table
maxima_filt <- read.csv("data/03_geno/data/maps/cmaxima_filt.map", stringsAsFactors=T, header=F)
maxima_raw <- read.csv("data/03_geno/data/maps/cmaxima_raw.map", stringsAsFactors=T, header=F)
maxima_filt_gp <- maxima_filt %>% group_by(V2) %>% summarize(Filtered=n())
maxima_raw_gp <- maxima_raw %>% group_by(V2) %>% summarize(Raw=n())
maxima_raw_gp$V2 <- as.numeric(str_extract(maxima_raw_gp$V2, "[0-9][0-9]$"))
maxima_comb <- merge(maxima_raw_gp, maxima_filt_gp, by="V2")
maxima_comb <- rbind(maxima_comb, data.frame(V2="Total",
					 Raw=sum(maxima_raw_gp$Raw),
					 Filtered=sum(maxima_filt_gp$Filtered)))

all <- merge(pepo_comb, moschata_comb, by="V2", sort=F)
all <- merge(all, maxima_comb, by="V2", sort=F)
all <- rbind(data.frame(V2="Chromosome",
		        Raw.x="Raw",
		        Filtered.x="Filtered",
		        Raw.y="Raw",
		        Filtered.y="Filtered",
		        Raw="Raw",
		        Filtered="Filtered"), all)
tbl <- knitr::kable(all, col.names=c("","C. pepo", "", "C. moschata", "","C. maxima", " "))
con=file("tables/01_tbl.md")
writeLines(tbl, con)
close(con)




