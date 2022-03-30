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

maxima$mosaic[grepl("1", maxima$or_flesh)] <- "1"
maxima$mosaic[grepl("2", maxima$or_flesh)] <- "2"
maxima$mosaic[grepl("3", maxima$or_flesh)] <- "3"
maxima$mosaic[grepl("4", maxima$or_flesh)] <- "4"

