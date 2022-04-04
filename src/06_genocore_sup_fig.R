library(tidyverse)
library(gridExtra)

# Functions


# Read in genocore coverage files
cpepo <- read.csv("data/03_geno/data/genocore/cpepo_core_Coverage.csv")
cmos <- read.csv("data/03_geno/data/genocore/cmoschata_core_Coverage.csv")
cmax <- read.csv("data/03_geno/data/genocore/cmaxima_core_Coverage.csv")

# Format and combine
cpepo$Iteration <- cpepo$Iteration/828
cpepo$species <- rep("C. pepo", nrow(cpepo))

cmos$Iteration <- cmos$Iteration/828
cmos$species <- rep("C. moschata", nrow(cmos))

cmax$Iteration <- cmax$Iteration/828
cmax$species <- rep("C. maxima", nrow(cmax))
all <- rbind(cpepo, cmos, cmax)

cpepo <- 
