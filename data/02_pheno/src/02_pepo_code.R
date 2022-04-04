library(tidyverse)
library(stringr)
library(MASS)

# Functions
fmt_seedCnt <- function(df){
  cnt1 <- str_split(df$`100wt`, ";")
  cnt2 <- str_split(df$`100wt2`,";")
  new <- c()
  for(i in 1:length(cnt1)){
    mu <- mean(unique(as.numeric(c(cnt1[[i]], cnt2[[i]]))), na.rm=T)
    new <- c(new,mu)
  }
  return(new)
}
	
# Read in file
pepo <- read_delim("data/cpepo_clean_pheno.tsv", delim="\t")
pepo2 <- read_delim("data/raw/cpepo_vine_habit.csv", delim=",")

# Recode cpepo genotypes
pepo$seed_wt <- fmt_seedCnt(pepo)

pepo$or_flesh <- pepo$flesh_color
pepo$or_flesh[grepl(";", pepo$or_flesh)] <- NA 
pepo$or_flesh[grepl("ORANGE", pepo$or_flesh)] <- 1 
pepo$or_flesh[which(pepo$or_flesh != 1)] <- 0 

pepo$yl_flesh <- pepo$flesh_color
pepo$yl_flesh[grepl(";", pepo$yl_flesh)] <- NA 
pepo$yl_flesh[grepl("YELLOW", pepo$yl_flesh)] <- 1 
pepo$yl_flesh[which(pepo$yl_flesh != 1)] <- 0 

pepo$globe_fruit <- pepo$fruit_shape
pepo$globe_fruit[grepl(";", pepo$globe_fruit)] <- NA
pepo$globe_fruit[grepl("GLOBE", pepo$globe_fruit)] <- 1
pepo$globe_fruit[which(pepo$globe_fruit != 1)] <- 0

pepo$oblong_fruit <- pepo$fruit_shape
pepo$oblong_fruit[grepl(";", pepo$oblong_fruit)] <- NA
pepo$oblong_fruit[grepl("OBLONG", pepo$oblong_fruit)] <- 1
pepo$oblong_fruit[which(pepo$oblong_fruit != 1)] <- 0

pepo$smooth_fruit <- pepo$fruit_txt
pepo$smooth_fruit[grepl(";", pepo$smooth_fruit)] <- NA
pepo$smooth_fruit[which(pepo$smooth_fruit != 1)] <- 0

pepo$rib_fruit <- pepo$fruit_txt
pepo$rib_fruit[grepl(";", pepo$rib_fruit)] <- NA
pepo$rib_fruit[grepl("RIBBED", pepo$rib_fruit)] <- 1
pepo$rib_fruit[which(pepo$rib_fruit != 1)] <- 0

pepo$solid_fruit <- pepo$fruit_pat
pepo$solid_fruit[grepl(";", pepo$solid_fruit)] <- NA
pepo$solid_fruit[grepl("SOLID COLOR", pepo$solid_fruit)] <- 1
pepo$solid_fruit[which(pepo$solid_fruit != 1)] <- 0

pepo$mot_fruit <- pepo$fruit_pat
pepo$mot_fruit[grepl(";", pepo$mot_fruit)] <- NA
pepo$mot_fruit[grepl("MOTTLED", pepo$mot_fruit)] <- 1
pepo$mot_fruit[which(pepo$mot_fruit != 1)] <- 0

pepo$spec_fruit <- pepo$fruit_pat
pepo$spec_fruit[grepl(";", pepo$spec_fruit)] <- NA
pepo$spec_fruit[grepl("SPECKLED", pepo$spec_fruit)] <- 1
pepo$spec_fruit[which(pepo$spec_fruit != 1)] <- 0

pepo$yl_fruit <- pepo$fruit_color
pepo$yl_fruit[grepl(";", pepo$yl_fruit)] <- NA
pepo$yl_fruit[grepl("YELLOW", pepo$yl_fruit)] <- 1
pepo$yl_fruit[which(pepo$yl_fruit != 1)] <- 0

pepo$tan_fruit <- pepo$fruit_color
pepo$tan_fruit[grepl(";", pepo$tan_fruit)] <- NA
pepo$tan_fruit[grepl("TAN", pepo$tan_fruit)] <- 1
pepo$tan_fruit[which(pepo$tan_fruit != 1)] <- 0

pepo$gn_fruit <- pepo$fruit_color
pepo$gn_fruit[grepl(";", pepo$gn_fruit)] <- NA
pepo$gn_fruit[grepl("GREEN", pepo$gn_fruit)] <- 1
pepo$gn_fruit[which(pepo$gn_fruit != 1)] <- 0

pepo$min_vig[grepl("1", pepo$min_vig)] <- 1
pepo$min_vig[grepl("2", pepo$min_vig)] <- 2 
pepo$min_vig[grepl("3", pepo$min_vig)] <- 3
pepo$min_vig[grepl("4", pepo$min_vig)] <- 4
pepo$min_vig[grepl("5", pepo$min_vig)] <- 5
pepo$min_vig <- as.numeric(pepo$min_vig)

lm.nymph <- lm(sqush_nymph ~ 1, data=pepo)
bc.nymph <- boxcox(lm.nymph)
l.nymph <- bc.nymph$x[which.max(bc.nymph$y)]
pepo$sb_nymph <- (pepo$sqush_nymph^l.nymph-1)/l.nymph

pepo$cuc_inj[grepl("0", pepo$cuc_inj)] <- 0
pepo$cuc_inj[grepl("1", pepo$cuc_inj)] <- 1
pepo$cuc_inj[grepl("2", pepo$cuc_inj)] <- 2
pepo$cuc_inj[grepl("3", pepo$cuc_inj)] <- 3
pepo$cuc_inj[grepl("4", pepo$cuc_inj)] <- 4
pepo$cuc_inj <- as.numeric(pepo$cuc_inj)

lm.adult <- lm(squash_adult ~ 1, data=pepo)
bc.adult <- boxcox(lm.adult)
l.adult <- bc.adult$x[which.max(bc.adult$y)]
pepo$sb_adult <- (pepo$squash_adult^l.adult-1)/l.adult

pepo$max_vig[grepl("1", pepo$max_vig)] <- 1
pepo$max_vig[grepl("2", pepo$max_vig)] <- 2 
pepo$max_vig[grepl("3", pepo$max_vig)] <- 3
pepo$max_vig[grepl("4", pepo$max_vig)] <- 4
pepo$max_vig[grepl("5", pepo$max_vig)] <- 5
pepo$max_vig <- as.numeric(pepo$max_vig)

pepo$plant_type[grepl(";", pepo$plant_type)] <- NA
pepo$plant_type[grepl("SEMI-BUSH", pepo$plant_type)] <- 1
pepo$plant_type[grepl("BUSH", pepo$plant_type)] <- 0 
pepo$plant_type[grepl("VINE", pepo$plant_type)] <- 1 
pepo$plant_type <- as.numeric(pepo$plant_type)

colnames(pepo2) <- c("accession_id", "plant_type2")
pepo2$plant_type2 <- gsub("V", 1, pepo2$plant_type2)
pepo2$plant_type2 <- gsub("B", 0, pepo2$plant_type2)
pepo2$plant_type2 <- gsub("S", 1, pepo2$plant_type2)
pepo2$plant_type2 <- as.numeric(pepo2$plant_type2)

# Format final string and outputs
pepo <- merge(pepo, pepo2, by="accession_id", all.x=T, sort=F)
pepo <- pepo[,c("accession_id", "seed_wt", "plant_type",
                "plant_type2", "max_vig", "min_vig",
                "max_width", "width_min", "len_max", "len_min",
                "flesh_max", "flesh_min", "sb_nymph",
                "sb_adult", "cuc_inj", "or_flesh", 
                "yl_flesh", "yl_fruit", "tan_fruit", "gn_fruit",
                "globe_fruit", "oblong_fruit", "smooth_fruit",
                "rib_fruit", "spec_fruit", "mot_fruit", "solid_fruit")]
write_delim(pepo, "data/cpepo_coded.csv", delim=",")


