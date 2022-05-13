library(tidyverse)
library(MASS)

# Read in data
maxima <- read_delim("data/cmaxima_clean_pheno.tsv", delim="\t")


# Code phenotypes
maxima$or_flesh <- maxima$flesh_color
maxima$or_flesh[grepl(";", maxima$or_flesh)] <- NA
maxima$or_flesh[grepl("5", maxima$or_flesh)] <- "1"
maxima$or_flesh[which(maxima$or_flesh != "1")] <- "0"
maxima$or_flesh <- as.numeric(maxima$or_flesh)

maxima$watermelon_mosaic <- gsub("\\(.*\\)","", maxima$watermelon_mosaic)
maxima$watermelon_mosaic[grepl("1", maxima$watermelon_mosaic)] <- "1"
maxima$watermelon_mosaic[grepl("2", maxima$watermelon_mosaic)] <- "2"
maxima$watermelon_mosaic[grepl("3", maxima$watermelon_mosaic)] <- "3"
maxima$watermelon_mosaic[grepl("4", maxima$watermelon_mosaic)] <- "4"
maxima$watermelon_mosaic[grepl("5", maxima$watermelon_mosaic)] <- "5"
maxima$watermelon_mosaic[grepl("6", maxima$watermelon_mosaic)] <- "6"
maxima$watermelon_mosaic[grepl("7", maxima$watermelon_mosaic)] <- "7"
maxima$watermelon_mosaic[grepl("8", maxima$watermelon_mosaic)] <- "8"
maxima$watermelon_mosaic[grepl("9", maxima$watermelon_mosaic)] <- "9"
maxima$watermelon_mosaic <- as.numeric(maxima$watermelon_mosaic)


maxima$cuc_mosaic <- gsub("\\(.*\\)","", maxima$cuc_mosaic)
maxima$cuc_mosaic[grepl("1", maxima$cuc_mosaic)] <- "1"
maxima$cuc_mosaic[grepl("2", maxima$cuc_mosaic)] <- "2"
maxima$cuc_mosaic[grepl("3", maxima$cuc_mosaic)] <- "3"
maxima$cuc_mosaic[grepl("4", maxima$cuc_mosaic)] <- "4"
maxima$cuc_mosaic[grepl("5", maxima$cuc_mosaic)] <- "5"
maxima$cuc_mosaic[grepl("6", maxima$cuc_mosaic)] <- "6"
maxima$cuc_mosaic[grepl("7", maxima$cuc_mosaic)] <- "7"
maxima$cuc_mosaic[grepl("8", maxima$cuc_mosaic)] <- "8"
maxima$cuc_mosaic[grepl("9", maxima$cuc_mosaic)] <- "9"
maxima$cuc_mosaic <- as.numeric(maxima$cuc_mosaic)

maxima$maturity <- as.numeric(maxima$maturity)

maxima$flesh_depth <- as.numeric(maxima$flesh_depth)

maxima$diam <- as.numeric(maxima$diam)

maxima$len <- as.numeric(maxima$len)

maxima$set <- gsub("\\(.*\\)","", maxima$set)
maxima$set[grepl("1", maxima$set)] <- "1"
maxima$set[grepl("2", maxima$set)] <- "2"
maxima$set[grepl("3", maxima$set)] <- "3"
maxima$set[grepl("4", maxima$set)] <- "4"
maxima$set[grepl("5", maxima$set)] <- "5"
maxima$set[grepl("6", maxima$set)] <- "6"
maxima$set[grepl("7", maxima$set)] <- "7"
maxima$set[grepl("8", maxima$set)] <- "8"
maxima$set[grepl("9", maxima$set)] <- "9"
maxima$set <- as.numeric(maxima$set)

maxima$plant_habit[grepl("BUSH", maxima$plant_habit)] <- "0"
maxima$plant_habit[grepl("VINE", maxima$plant_habit)] <- "1"
maxima$plant_habit <- as.numeric(maxima$plant_habit)

maxima$pm <- maxima$PM 
maxima$pm <- gsub("\\(.*\\)","", maxima$pm)
maxima$pm[grepl("1", maxima$pm)] <- "1"
maxima$pm[grepl("2", maxima$pm)] <- "2"
maxima$pm[grepl("3", maxima$pm)] <- "3"
maxima$pm[grepl("4", maxima$pm)] <- "4"
maxima$pm[grepl("5", maxima$pm)] <- "5"
maxima$pm[grepl("6", maxima$pm)] <- "6"
maxima$pm[grepl("7", maxima$pm)] <- "7"
maxima$pm[grepl("8", maxima$pm)] <- "8"
maxima$pm[grepl("9", maxima$pm)] <- "9"
maxima$pm <- as.numeric(maxima$pm)

maxima$rib <- maxima$ribbing 
maxima$rib <- gsub("\\(.*\\)","", maxima$rib)
maxima$rib[grepl("1", maxima$rib)] <- "1"
maxima$rib[grepl("2", maxima$rib)] <- "2"
maxima$rib[grepl("3", maxima$rib)] <- "3"
maxima$rib[grepl("4", maxima$rib)] <- "4"
maxima$rib[grepl("5", maxima$rib)] <- "5"
maxima$rib[grepl("6", maxima$rib)] <- "6"
maxima$rib[grepl("7", maxima$rib)] <- "7"
maxima$rib[grepl("8", maxima$rib)] <- "8"
maxima$rib[grepl("9", maxima$rib)] <- "9"
maxima$rib <- as.numeric(maxima$rib)

maxima$unif <- maxima$uniformity 
maxima$unif <- gsub("\\(.*\\)","", maxima$unif)
maxima$unif[grepl("1", maxima$unif)] <- "1"
maxima$unif[grepl("2", maxima$unif)] <- "2"
maxima$unif[grepl("3", maxima$unif)] <- "3"
maxima$unif[grepl("4", maxima$unif)] <- "4"
maxima$unif[grepl("5", maxima$unif)] <- "5"
maxima$unif[grepl("6", maxima$unif)] <- "6"
maxima$unif[grepl("7", maxima$unif)] <- "7"
maxima$unif[grepl("8", maxima$unif)] <- "8"
maxima$unif[grepl("9", maxima$unif)] <- "9"
maxima$unif <- as.numeric(maxima$unif)

maxima$fruit_spot <- gsub("\\(.*\\)","", maxima$fruit_spot)
maxima$fruit_spot[grepl("1", maxima$fruit_spot)] <- "1"
maxima$fruit_spot[grepl("2", maxima$fruit_spot)] <- "2"
maxima$fruit_spot[grepl("3", maxima$fruit_spot)] <- "3"
maxima$fruit_spot[grepl("4", maxima$fruit_spot)] <- "4"
maxima$fruit_spot[grepl("5", maxima$fruit_spot)] <- "5"
maxima$fruit_spot[grepl("6", maxima$fruit_spot)] <- "6"
maxima$fruit_spot[grepl("7", maxima$fruit_spot)] <- "7"
maxima$fruit_spot[grepl("8", maxima$fruit_spot)] <- "8"
maxima$fruit_spot[grepl("9", maxima$fruit_spot)] <- "9"
maxima$fruit_spot <- as.numeric(maxima$fruit_spot)

maxima$vig <- gsub("\\(.*\\)","", maxima$vig)
maxima$vig[grepl("1", maxima$vig)] <- "1"
maxima$vig[grepl("2", maxima$vig)] <- "2"
maxima$vig[grepl("3", maxima$vig)] <- "3"
maxima$vig[grepl("4", maxima$vig)] <- "4"
maxima$vig[grepl("5", maxima$vig)] <- "5"
maxima$vig[grepl("6", maxima$vig)] <- "6"
maxima$vig[grepl("7", maxima$vig)] <- "7"
maxima$vig[grepl("8", maxima$vig)] <- "8"
maxima$vig[grepl("9", maxima$vig)] <- "9"
maxima$vig <- as.numeric(maxima$vig)

maxima$gray_fruit <- maxima$fruit_color
maxima$gray_fruit[grepl(";", maxima$gray_fruit)] <- NA
maxima$gray_fruit[grepl("1", maxima$gray_fruit)] <- "1"
maxima$gray_fruit[which(maxima$gray_fruit != "1")] <- "0"
maxima$gray_fruit <- as.numeric(maxima$gray_fruit)

maxima$or_fruit <- maxima$fruit_color
maxima$or_fruit[grepl(";", maxima$or_fruit)] <- NA
maxima$or_fruit[grepl("3", maxima$or_fruit)] <- "1"
maxima$or_fruit[which(maxima$or_fruit != "1")] <- "0"
maxima$or_fruit <- as.numeric(maxima$or_fruit)

maxima$gn_fruit <- maxima$fruit_color
maxima$gn_fruit[grepl(";", maxima$gn_fruit)] <- NA
maxima$gn_fruit[grepl("5", maxima$gn_fruit)] <- "1"
maxima$gn_fruit[which(maxima$gn_fruit != "1")] <- "0"
maxima$gn_fruit <- as.numeric(maxima$gn_fruit)

# Output final format
maxima <- maxima[, c("accession_id", "len", "set", "diam", "watermelon_mosaic", "cuc_mosaic", 
		     "maturity", "unif", "pm", "plant_habit",
		     "vig", "or_flesh", "rib", "fruit_spot",
		     "gray_fruit", "or_fruit", "gn_fruit")]

write_delim(maxima, "data/cmaxima_coded.csv", delim=",")






