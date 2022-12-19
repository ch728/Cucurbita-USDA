library(tidyverse)
library(viridis)

pepoPC <- read.csv("../03_geno/data/pca/pepo_pca_gwas.csv", stringsAsFactors=F)
pepoPheno <- read.csv("../02_pheno/data/cpepo_coded.csv",
		      stringsAsFactors=F)
colnames(pepoPheno)[1] <- "gid"

pepoComb <- merge(pepoPC, pepoPheno, by="gid", sort=F, all.x=T)

pepoSeed <- ggplot(pepoComb, aes(x=PC1, y=PC2, color=seed_wt)) +
	         geom_point()+
		 scale_color_viridis("100 Seed Wt. (g)") +
		 theme_bw(base_size=18) +
		 theme(panel.background=element_blank(),
		       panel.grid=element_blank(),
		       axis.text=element_blank(),
		       axis.ticks=element_blank()) 

mosPC <- read.csv("../03_geno/data/pca/moschata_pca_gwas.csv", stringsAsFactors=F)
mosPheno <- read.csv("../02_pheno/data/cmoschata_coded.csv",
		      stringsAsFactors=F)
colnames(mosPheno)[1] <- "gid"
mosComb <- merge(mosPC, mosPheno, by="gid", sort=F, all.x=T)
mosComb$maturity <- ifelse(mosComb$maturity == 0, "Late", "Early")
mosComb$maturity[is.na(mosComb$maturity)] <- "Missing"

mosMat <- ggplot(mosComb, aes(x=PC1, y=PC2, color=as.factor(maturity))) +
	         geom_point()+
		 scale_color_manual("Maturity", values=c("#7FC97f", "#fdc086", "#ececec")) +
		 theme_bw(base_size=18) +
		 theme(panel.background=element_blank(),
		       panel.grid=element_blank(),
		       axis.text=element_blank(),
		       axis.ticks=element_blank()) 

