library(tidyverse)
library(CMplot)

pepo <- read.csv("data/03_geno/data/maps/cpepo_filt.map")
mos <- read.csv("data/03_geno/data/maps/cmoschata_filt.map")
max <- read.csv("data/03_geno/data/maps/cmaxima_filt.map")

png("supplemental/01_fig1a.png")
CMplot(pepo, type="p", plot.type="d", main="C. pepo",file.output=F)
dev.off()

png("supplemental/01_fig1b.png")
CMplot(mos, type="p", plot.type="d", main="C. moschata",file.output=F)
dev.off()

png("supplemental/01_fig1c.png")
CMplot(max, type="p", plot.type="d", main="C. maxima",file.output=F)
dev.off()
