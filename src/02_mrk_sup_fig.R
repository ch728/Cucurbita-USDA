library(CMplot)

# Read in files
pepo <- read.csv("data/03_geno/data/maps/cpepo_filt.map", header=F)
mos <- read.csv("data/03_geno/data/maps/cmoschata_filt.map", header=F)
max <- read.csv("data/03_geno/data/maps/cmaxima_filt.map", header=F)

pepo_stub <- read.csv("data/01_meta/data/cpepo_stubs.csv", header=F)
mos_stub <- read.csv("data/01_meta/data/cmoschata_stubs.csv", header=F)
max_stub <- read.csv("data/01_meta/data/cmaxima_stubs.csv", header=F)

pepo <- rbind(pepo, pepo_stub)
mos <- rbind(mos, mos_stub)
max <- rbind(max, max_stub)

# Make plot
png("supplemental/01_supfig.png")
par(mfrow=c(2,2))
CMplot(pepo, type="p", plot.type="d", main="C. pepo", file.output=F)
mtext("a.",3, cex=2, at=c(0,3), font=2, line=2) 
CMplot(mos, type="p", plot.type="d", main="C. moschata", file.output=F)
mtext("b.",3, cex=2, at=c(0,3), line=2, font=2) 
CMplot(max, type="p", plot.type="d", main="C. maxima", file.output=F)
mtext("c.",3, cex=2, at=c(0,3), line=2, font=2) 
dev.off()


