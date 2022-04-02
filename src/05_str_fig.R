library(tidyverse)
library(ggpubr)
library(grid)
library(gridExtra)


# Functions
make_pca <- function(pca, v){
  # Function to make pca plot
  pca.plt <- ggplot(filter(pca, !is.na(region)), aes(x=PC1, y=PC2, color=region)) +
	              geom_point() +
		      xlab(paste0(round(v[1,1], 1),"%")) +
		      ylab(paste0(round(v[2,1], 1),"%")) +
		      theme_bw(base_size=18) +
		      theme_bw(base_size=18) +
		      scale_color_brewer(palette="Accent") +
		      theme(panel.background=element_blank(),
		            panel.grid=element_blank(),
		            axis.text=element_blank(),
		            axis.ticks=element_blank())
  return(pca.plt)
}


# Read in files
pepoPCA <- read_delim("data/03_geno/data/pca/pepo_pca.csv", delim=",")
pepoVar <- read_delim("data/03_geno/data/pca/pepo_var.csv", delim=",")

mosPCA <- read_delim("data/03_geno/data/pca/moschata_pca.csv", delim=",")
mosVar <- read_delim("data/03_geno/data/pca/moschata_var.csv", delim=",")

maxPCA <- read_delim("data/03_geno/data/pca/maxima_pca.csv", delim=",")
maxVar <- read_delim("data/03_geno/data/pca/maxima_var.csv", delim=",")

pepoMeta <- read_delim("data/01_meta/data/cpepo_manifest.tsv", delim="\t")
mosMeta <- read_delim("data/01_meta/data/cmoschata_manifest.tsv", delim="\t")
maxMeta <- read_delim("data/01_meta/data/cmaxima_manifest.tsv", delim="\t")

# Add region data to pca
pepoPCA <- merge(pepoPCA, pepoMeta, by.x="gid", by.y="accession_id", sort=F, all.x=T)
mosPCA <- merge(mosPCA, mosMeta, by.x="gid", by.y="accession_id", sort=F, all.x=T)
maxPCA <- merge(maxPCA, maxMeta, by.x="gid", by.y="accession_id", sort=F, all.x=T)

# Make pca figure
pcaLeg <- get_legend(make_pca(pepoPCA, pepoVar) + labs(color="Region"))
pepoPCA.plt <- make_pca(pepoPCA, pepoVar) + theme(legend.position="none")
mosPCA.plt <- make_pca(mosPCA, mosVar) + theme(legend.position="none")
maxPCA.plt <- make_pca(maxPCA, maxVar) + theme(legend.position="none")
finPCA.plt <- grid.arrange(pepoPCA.plt, mosPCA.plt, maxPCA.plt, pcaLeg,
			  layout_matrix=rbind(c(1,1,NA),
					      c(1,1,NA),
					      c(2,2,4),
                                              c(2,2,NA),
					      c(3,3,NA),
					      c(3,3,NA)),
                          top=textGrob("B.", x=0.1, gp=gpar(fontsize=18, fontface="bold")),
                          left=textGrob("PC2", rot=90, gp=gpar(fontsize=18, fontface="bold")),
                          bottom=textGrob("PC1", x=0.35, gp=gpar(fontsize=18,fontface="bold")))

# Makes stucture figure


# Make final figure

