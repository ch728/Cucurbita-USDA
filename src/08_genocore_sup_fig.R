library(tidyverse)
library(gridExtra)

# Read in genocore coverage files and pca files
cpepo <- read.csv("data/03_geno/data/genocore/cpepo_core_Coverage.csv")
cmos <- read.csv("data/03_geno/data/genocore/cmoschata_core_Coverage.csv")
cmax <- read.csv("data/03_geno/data/genocore/cmaxima_core_Coverage.csv")

pepoPCA <- read.csv("data/03_geno/data/pca/pepo_pca.csv")
mosPCA <- read.csv("data/03_geno/data/pca/moschata_pca.csv")
maxPCA <- read.csv("data/03_geno/data/pca/maxima_pca.csv")

# Format and combine
cpepo$Iteration <- cpepo$Iteration/829
cpepo$species <- rep("C. pepo", nrow(cpepo))

cmos$Iteration <- cmos$Iteration/314
cmos$species <- rep("C. moschata", nrow(cmos))

cmax$Iteration <- cmax$Iteration/372
cmax$species <- rep("C. maxima", nrow(cmax))
allCov <- rbind(cpepo, cmos, cmax)

# Make coverage figures
cov.plt <- ggplot(allCov, aes(x=Iteration, y=Coverage,
			   group=species, color=species)) +
                  geom_line(size=1) +
		  xlab("Proportion of Panel") +
		  ggtitle("b.") +
		  theme_bw(base_size=18) +
		  theme(panel.grid=element_blank(),
			legend.title=element_blank(),
			legend.text=element_text(face="italic"),
		        plot.title=element_text(face="bold"))

# Make pca coverage figure
pepoPCA$include <- pepoPCA$gid %in% cpepo$Sample_name
pepoPCA$species <- rep("C. pepo", nrow(pepoPCA))

mosPCA$include <- mosPCA$gid %in% cmos$Sample_name
mosPCA$species <- rep("C. moschata", nrow(mosPCA))

maxPCA$include <- maxPCA$gid %in% cmax$Sample_name
maxPCA$species <- rep("C. maxima", nrow(maxPCA))

allPCA <- rbind(maxPCA, mosPCA, pepoPCA)
allPCA$include <- as.factor(allPCA$include)

pc.plt <- ggplot(allPCA, aes(x=PC1, y=PC2, color=include)) +
              geom_point(alpha=0.8) +
      	ggtitle("a.") +
      	facet_wrap(~species, nrow=1, scale="free") +
      	scale_color_manual(values=c("lightgray", "black")) +
      	theme_bw(base_size=18) +
      	theme(panel.grid=element_blank(),
      	      legend.position="none",
      	      axis.text=element_blank(),
      	      axis.ticks=element_blank(),
      	      strip.text=element_text(face="italic"),
	      plot.title=element_text(face="bold"))

core.plt <- grid.arrange(pc.plt, cov.plt,
			layout_matrix=rbind(c(1,1,1,1),
					    c(2,2,2,NA)))
ggsave("supplemental/03_supfig.png", core.plt, "png", height=6, width=7)
