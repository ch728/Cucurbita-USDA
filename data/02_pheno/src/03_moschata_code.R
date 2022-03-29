library(tidyverse)
library(stringr)
library(MASS)

# Functions

# Read in file
mos <- read_delim("data/cmoschata_clean_pheno.tsv", delim="\t")

# Code phenotypes

mos$oblate_fruit <- mos$fruit_shape
mos$oblate_fruit[grepl(";", mos$oblate_fruit)] <- NA
mos$oblate_fruit[grepl("OBLATE", mos$oblate_fruit)] <- "1"
mos$oblate_fruit[which(mos$oblate_fruit != "1")] <- "0"
mos$oblate_fruit <- as.numeric(mos$oblate_fruit)

mos$fruit_len <- as.numeric(mos$len)

mos$fruit_diam <- as.numeric(mos$diam)

mos$maturity[grepl(";", mos$maturity)] <- NA
mos$maturity[grepl("1", mos$maturity)] <- "1"
mos$maturity[grepl("5", mos$maturity)] <- "0"
mos$maturity[grepl("8", mos$maturity)] <- "0"
mos$maturity <- as.numeric(mos$maturity)

mos$or_fruit <- mos$fruit_color
mos$or_fruit[grepl(";", mos$or_fruit)] <- NA
mos$or_fruit[grepl("ORANGE", mos$or_fruit)] <- "1"
mos$or_fruit[which(mos$or_fruit != "1")] <- "0"
mos$or_fruit <- as.numeric(mos$or_fruit)


