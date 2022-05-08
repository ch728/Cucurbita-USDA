library(tidyverse)
library(gridExtra)


# Read in files
cpepo <- read.table("data/03_geno/data/admix/cpepo/cpepo_admix_cult.5.Q", sep=" ",
                    header=F)
cpepoLab <- read_delim("data/03_geno/data/admix/cpepo/cpepo_admix_cult.fam" , delim=" ",
                     col_names=F)[,1]
rownames(cpepo) <- cpepoLab[[1]]



