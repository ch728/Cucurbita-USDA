library(tidyverse)
library(viridis)
library(grid)
library(gridExtra)

pepoPC <- read.csv("../03_geno/data/pca/pepo_pca_gwas.csv", stringsAsFactors=F)
pepoPheno <- read.csv("../02_pheno/data/cpepo_coded.csv",
		      stringsAsFactors=F)
colnames(pepoPheno)[1] <- "gid"

pepoComb <- merge(pepoPC, pepoPheno, by="gid", sort=F, all.x=T)

pepoSeed <- ggplot(pepoComb, aes(x=PC1, y=PC2, color=seed_wt)) +
	         geom_point()+
		 scale_color_viridis("100 Seed Wt (g)") +
		 ggtitle("a.") +
		 theme_bw(base_size=18) +
		 theme(panel.background=element_blank(),
		       panel.grid=element_blank(),
		       axis.text=element_blank(),
		       axis.ticks=element_blank(),
		       plot.title=element_text(hjust=0, face="bold")) 

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
		 ggtitle("b.") +
		 theme_bw(base_size=18) +
		 theme(panel.background=element_blank(),
		       panel.grid=element_blank(),
		       axis.text=element_blank(),
		       axis.ticks=element_blank(),
		       plot.title=element_text(hjust=0, face="bold")) 

maxPC <- read.csv("../03_geno/data/pca/maxima_pca_gwas.csv", stringsAsFactors=F)
maxPheno <- read.csv("../02_pheno/data/cmaxima_coded.csv",
		      stringsAsFactors=F)
colnames(maxPheno)[1] <- "gid"
maxComb <- merge(maxPC, maxPheno, by="gid", sort=F, all.x=T)
maxComb$plant_habit <- ifelse(maxComb$plant_habit == 0, "Bush", "Vine")
maxComb$plant_habit[is.na(maxComb$plant_habit)] <- "Missing"
maxComb$plant_habit <- factor(maxComb$plant_habit, labels=c("Bush", "Vine", "Missing"))
maxMat <- ggplot(maxComb, aes(x=PC1, y=PC2, color=plant_habit)) +
	         geom_point()+
		 scale_color_manual("Plant Habit", values=c("#7FC97f", "#fdc086", "#ececec")) +
		 theme_bw(base_size=18) +
		 ggtitle("c.") +
		 theme(panel.background=element_blank(),
		       panel.grid=element_blank(),
		       axis.text=element_blank(),
		       axis.ticks=element_blank(),
		       plot.title=element_text(hjust=0, face="bold")) 
final <- grid.arrange(pepoSeed, mosMat, maxMat,
		      layout_matrix=rbind(c(1,1,1,1,1,2,2,2,2),
					  c(3,3,3,3,NA,NA, NA,NA,NA)))
ggsave("../../final_figures/07_fig.jpeg", final, "jpeg", width=11)
