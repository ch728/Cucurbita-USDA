library(tidyverse)
library(grid)
library(gridExtra)
source("src/gwas_plotter_fct.R")

# Read in gwas results
pepoRes <- readRDS("data/04_assoc/data/pepoGwas.Rdata")
mosRes <- readRDS("data/04_assoc/data/mosGwas.Rdata")
maxRes <- readRDS("data/04_assoc/data/maxGwas.Rdata")

# Get plots pepo
pt <- genesis_man(pepoRes$plant_type, "plant_type")
pt2 <- genesis_man(pepoRes$plant_type2, "plant_type2")
gn <- genesis_man(pepoRes$gn_fruit, "gn_fruit")
or <- genesis_man(pepoRes$or_flesh, "or_flesh")
fmax <- genesis_man(pepoRes$flesh_max, "flesh_max")


# Get plots for moschata
flen <- genesis_man(mosRes$fruit_len, "fruit_len")

# Get plots for maxima
rib <- genesis_man(maxRes$rib, "rib")
gnm <- genesis_man(maxRes$gn_fruit, "gn_fruit")

# Create combined manhattens
combPepo <- grid.arrange(pt$man,pt2$man,fmax$man,gn$man,or$man,
			layout_matrix=rbind(c(1,4),
					    c(2,5),
					    c(3,NA)),
                        top=textGrob("a.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))

combMos <- grid.arrange(flen$man,
			layout_matrix=rbind(c(1),
					    c(NA),
					    c(NA)),
                        top=textGrob("b.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))
combMax <- grid.arrange(rib$man, gnm$man,
			layout_matrix=rbind(c(1),
					    c(2),
					    c(NA)),
                        top=textGrob("c.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))
allMan <- grid.arrange(combPepo, combMos, combMax,
		       layout_matrix=rbind(c(1,1,2,3),
					   c(1,1,NA,3),
		                           c(1,1,NA,NA)),
                       left=textGrob("-log10(p)",
				     rot=90,
				     gp=gpar(fontsize=20,
					  fontface="bold")),
		       bottom=textGrob("Chromosomes (0-20)",
				       gp=gpar(fontsize=20,
					    fontface="bold")))
ggsave("figures/04_fig.png", allMan, "png", height=8, width=10)

# Create combined qq

combPepo <- grid.arrange(pt$qq,pt2$qq,fmax$qq,gn$qq,or$qq,
			layout_matrix=rbind(c(1,4),
					    c(2,5),
					    c(3,NA)),
                        top=textGrob("a.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))

combMos <- grid.arrange(flen$qq,
			layout_matrix=rbind(c(1),
					    c(NA),
					    c(NA)),
                        top=textGrob("b.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))
combMax <- grid.arrange(rib$qq, gnm$qq,
			layout_matrix=rbind(c(1),
					    c(2),
					    c(NA)),
                        top=textGrob("c.", x=0.05,
			             gp=gpar(fontsize=20,fontface="bold")))
allqq <- grid.arrange(combPepo, combMos, combMax,
		       layout_matrix=rbind(c(1,1,2,3),
					   c(1,1,NA,3),
		                           c(1,1,NA,NA)),
                       bottom=textGrob("Expected -log10(p)",
				       gp=gpar(fontsize=20,
					       frontface="bold")),
		       left=textGrob("Actual -log10(p)",
				     rot=90,
				     gp=gpar(fontsize=20,
					     frontface="bold")))
#ggsave("supplemental/05_subfig.png", allqq, "png", height=8, width=10)

