library(tidyverse)

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

# Add region data to pca dataframe 


# Make pca figures
pepoPCA.plt <- ggplot(filter(pepoPCA, !is.na(region)), aes(x=PC1, y=PC2, color=region)) +
	              geom_point() +
		      xlab(paste0("PC1 (",round(pepoVar[1,1], 1),"%)")) +
		      ylab(paste0("PC2 (",round(pepoVar[2,1], 1),"%)")) +
		      theme_bw(base_size=18) +
		      theme_bw(base_size=18) +
		      scale_color_brewer(palette="Accent") +
		      theme(panel.background=element_blank(),
		            panel.grid=element_blank(),
		            axis.text=element_blank(),
		            axis.ticks=element_blank())

mosPCA.plt <- ggplot(mosPCA, aes(x=PC1, y=PC2)) +
	              geom_point() +
		      xlab(paste0("PC1 (",round(mosVar[1,1], 1),"%)")) +
		      ylab(paste0("PC2 (",round(mosVar[2,1], 1),"%)")) +
		      theme_bw(base_size=18) +
		      theme_bw(base_size=18) +
		      theme(panel.background=element_blank(),
		            panel.grid=element_blank(),
		            axis.text=element_blank(),
		            axis.ticks=element_blank())
		      
maxPCA.plt <- ggplot(maxPCA, aes(x=PC1, y=PC2)) +
	              geom_point() +
		      xlab(paste0("PC1 (",round(maxVar[1,1], 1),"%)")) +
		      ylab(paste0("PC2 (",round(maxVar[2,1], 1),"%)")) +
		      theme_bw(base_size=18) +
		      theme_bw(base_size=18) +
		      theme(panel.background=element_blank(),
		            panel.grid=element_blank(),
		            axis.text=element_blank(),
		            axis.ticks=element_blank())
# Makes stucture figues


# Make final output figures

