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


make_str <- function(s, lbl, n){
  # Makes nice structure plot

  s <- as.data.frame(s)
  k <- ncol(s)
  lbl <- as.data.frame(lbl)
  rownames(s) <- lbl[,1]
  sClust <- hclust(dist(s))
  sOrd <- s[sClust$order,]
  colnames(sOrd) <- paste(1:k)
  sOrd$PI <- rownames(sOrd)
  sGathered <- gather(sOrd, pop, value, -PI)
  sGathered$PI <- factor(sGathered$PI, levels=rownames(sOrd))
  sGathered$pop <- factor(sGathered$pop, levels=paste(1:k))
  # Create group annotations
  sGrp <- as.data.frame(cutree(sClust, k=k))[sClust$order,,F]
  sGrp <- cbind(sGrp, data.frame(pos=1:nrow(sGrp)))
  colnames(sGrp)[1] <- "grp"
  grp_mrk <- data.frame()
  grp_txt <- data.frame()
  for(i in unique(sGrp[,1])){
    tmp <- filter(sGrp, grp == i)
    x <- min(tmp$pos)
    xend <- x
    mid <- mean(c(min(tmp$pos), max(tmp$po)))
    grp_txt <- rbind(grp_txt, data.frame(x=mid, y=-0.033, label=paste(i)))
    grp_mrk <- rbind(grp_mrk, data.frame(x=x, xend=xend, y=0.033, yend=-0.033))
  }
  # Final plot
  plt <- ggplot(sGathered) +
	       geom_bar(aes(x=PI, y=value, fill=pop), stat="identity", width=1) +
               geom_segment(aes(x=x,xend=xend,y=y,yend=yend),
		            data=grp_mrk, size=2) +
               geom_text(aes(x=x, y=y, label=label),
		            data=grp_txt, fontface="bold",
		            size=4) +
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
  str.plt <- grid.arrange(plt,
                          left=textGrob(n,
					rot=90,
					gp=gpar(fontsize=18,
						fontface="italic",
						fontface="bold")))
  sGrp$PI <- rownames(sGrp)
  return(list(str.plt, sGrp, sOrd))
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

pepoStr <- read_delim("data/03_geno/data/admix/cpepo/cpepo_admix_nocult.6.Q",
                      col_names=F)
pepoLbl <- read_delim("data/03_geno/data/filtered/cpepo_admix_nocult.fam",
                      col_names=F)

mosStr <- read_delim("data/03_geno/data/admix/cmoschata/cmoschata_admix_nocult.6.Q",
                      col_names=F)
mosLbl <- read_delim("data/03_geno/data/filtered/cmoschata_admix_nocult.fam",
                      col_names=F)

maxStr <- read_delim("data/03_geno/data/admix/cmaxima/cmaxima_admix_nocult.3.Q",
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
                          top=textGrob("b.", x=0.1, gp=gpar(fontsize=20, fontface="bold")),
                          left=textGrob("PC2", rot=90, gp=gpar(fontsize=18, fontface="bold")),
                          bottom=textGrob("PC1", x=0.35, gp=gpar(fontsize=18,fontface="bold")))

# Makes stucture figure
pepoStr <- make_str(pepoStr, pepoLbl, "C. pepo")
mosStr <- make_str(mosStr, mosLbl, "C. moschata")
maxStr <- make_str(maxStr, maxLbl, "C. maxima")
finStr.plt <- grid.arrange(pepoStr[[1]], mosStr[[1]], maxStr[[1]],
			   layout_matrix=rbind(c(1,1,1),
			                       c(2,2,2),
					       c(3,3,3)),
                           top=textGrob("a.", x=0.05, 
					gp=gpar(fontsize=20, fontface="bold")))

# Make final figure
finFig <- grid.arrange(finStr.plt, finPCA.plt,
		       layout_matrix=rbind(c(1,1,1,1,1,1,1,NA,
					     2,2,2,2,2,2,2,2,2,
					     2)))
ggsave("figures/02_fig.png", finFig, "png", width=13, height=9) 

# Format pop assignment file
pepoMeta <-  merge(pepoMeta, pepoStr[[3]], by.x="accession_id", by.y="PI", all.x=T,sort=F)
pepoMeta <- merge(pepoMeta, pepoStr[[2]], by.x="accession_id", by.y="PI", all.x=T, sort=F)

mosMeta <-  merge(mosMeta, mosStr[[3]], by.x="accession_id", by.y="PI", all.x=T,sort=F)
mosMeta <- merge(mosMeta, mosStr[[2]], by.x="accession_id", by.y="PI", all.x=T, sort=F)

maxMeta <-  merge(maxMeta, maxStr[[3]], by.x="accession_id", by.y="PI", all.x=T,sort=F)
maxMeta <- merge(maxMeta, maxStr[[2]], by.x="accession_id", by.y="PI", all.x=T, sort=F)

# Write out final file
write_delim(pepoMeta, file="supplemental/pepo_meta.tsv", delim="\t")
write_delim(mosMeta, file="supplemental/moschata_meta.tsv", delim="\t")
write_delim(maxMeta, file="supplemental/maxima_meta.tsv", delim="\t")




