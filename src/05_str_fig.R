library(tidyverse)
library(ggpubr)
library(grid)
library(gridExtra)


# Functions
make_pca <- function(pca, v){
  # Function to make  individual pca plots
  pca$region <- factor(pca$region, levels=c("Africa", "Arab States",
					    "Asia", "Europe",
					    "North America",
					    "South/Latin America"))
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

make_str <- function(s, lbl){
  # Makes nice structure plot
  s <- as.data.frame(s)
  lbl <- as.data.frame(lbl)
  rownames(s) <- lbl[,1]
  sClust <- hclust(dist(s))
  sOrd <- s[sClust$order,]
  colnames(sOrd) <- paste(1:ncol(sOrd))
  sOrd$PI <- rownames(sOrd)
  sGathered <- gather(sOrd, pop, value, -PI)
  sGathered$PI <- factor(sGathered$PI, levels=rownames(sOrd))
  sGathered$pop <- factor(sGathered$pop, levels=paste(1:ncol(sOrd)))
  str.plt <- ggplot(sGathered) +
	       geom_bar(aes(x=PI, y=value, fill=pop), stat="identity", width=1) +
	       coord_cartesian(xlim=c(-3, nrow(sOrd) + 3)) +
	       scale_fill_brewer(palette="Set3") +
	       theme_bw(base_size=18) +
	       theme(panel.grid=element_blank(),
		     panel.border=element_blank(),
		     axis.text=element_blank(),
		     axis.title=element_blank(),
		     axis.ticks=element_blank(),
		     legend.position="none",
		     plot.margin=unit(c(0,0,0,0), "cm"))
  return(str.plt)
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

pepoStr <- read_delim("data/03_geno/data/admix/cpepo/cpepo_admix_nocult.5.Q",
                      col_names=F)
pepoLbl <- read_delim("data/03_geno/data/filtered/cpepo_admix_nocult.fam",
                      col_names=F)

mosStr <- read_delim("data/03_geno/data/admix/cmoschata/cmoschata_admix_nocult.5.Q",
                      col_names=F)
mosLbl <- read_delim("data/03_geno/data/filtered/cmoschata_admix_nocult.fam",
                      col_names=F)

maxStr <- read_delim("data/03_geno/data/admix/cmaxima/cmaxima_admix_nocult.5.Q",
                   col_names=F)
maxLbl <- read_delim("data/03_geno/data/filtered/cmaxima_admix_nocult.fam",
                      col_names=F)

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
pepoStr <- make_str(pepoStr, pepoLbl)
mosStr <- make_str(mosStr, mosLbl)
maxStr <- make_str(maxStr, maxLbl)
finStr.plt <- grid.arrange(pepoStr, mosStr, maxStr,
			   layout_matrix=rbind(c(1,1,1),
			                       c(2,2,2),
					       c(3,3,3)),
                           top=textGrob("A.", x=0.05, 
					gp=gpar(fontsize=18, fontface="bold")))

# Make final figure
finFig <- grid.arrange(finStr.plt, finPCA.plt,
		       layout_matrix=rbind(c(1,1,1,1,1,1,1,NA,
					     2,2,2,2,2,2,2,2,2,
					     2)))

