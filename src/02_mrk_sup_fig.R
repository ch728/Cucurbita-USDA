library(tidyverse)
library(CMplot)

pepo <- read.csv("data/03_geno/data/maps/cpepo_filt.map", header=F)
mos <- read.csv("data/03_geno/data/maps/cmoschata_filt.map", header=F)
max <- read.csv("data/03_geno/data/maps/cmaxima_filt.map", header=F)

pepo_stub <- read.csv("data/01_meta/data/cpepo_stubs.csv", header=F)
mos_stub <- read.csv("data/01_meta/data/cmoschata_stubs.csv", header=F)
max_stub <- read.csv("data/01_meta/data/cmaxima_stubs.csv", header=F)

pepo <- rbind(pepo, pepo_stub)
mos <- rbind(mos, mos_stub)
max <- rbind(max, max_stub)

png("supplemental/01_fig1a.png")
CMplot(pepo, type="p", plot.type="d", main="C. pepo", file.output=F)
dev.off()

png("supplemental/01_fig1b.png")
CMplot(mos, type="p", plot.type="d", main="C. moschata", file.output=F)
dev.off()

png("supplemental/01_fig1c.png")
CMplot(max, type="p", plot.type="d", main="C. maxima", file.output=F)
dev.off()
