library(tidyverse)
library(readxl)
library(rworldmap)

# Get country mappings
data(countryExData)
countryDat <- countryExData[,c(2,4)]
colnames(countryDat) <- c("country", "region")

# Relabel regions for simplicity 
countryDat$region <- gsub("Central Asia", "Asia", countryDat$region)
countryDat$region <- gsub("Northeast Asia", "Asia", countryDat$region)
countryDat$region <- gsub("South Asia", "Asia", countryDat$region)
countryDat$region <- gsub("Eastern Europe", "Europe", countryDat$region)
countryDat$region <- gsub("Central Europe", "Europe", countryDat$region)
countryDat$region <- gsub("Western Europe", "Europe", countryDat$region)
countryDat$region <- gsub("Southern Africa", "Africa", countryDat$region)
countryDat$region <- gsub("Northern Africa", "Africa", countryDat$region)
countryDat$region <- gsub("Eastern Africa", "Africa", countryDat$region)
countryDat$region <- gsub("South America", "South/Latin America", countryDat$region)
countryDat$region <- gsub("Meso America", "South/Latin America", countryDat$region)
countryDat$region[grepl("Australia" , countryDat$region)] <- NA
countryDat$region <- gsub("Mashriq", "Arab States", countryDat$region)
countryDat$region <- gsub("Arabian Peninsula", "Arab States", countryDat$region)
countryDat$region <- gsub("Western Africa", "Africa", countryDat$region)
countryDat$region <- gsub("South East Asia", "Asia", countryDat$region)

# Read in files
pepo <- read_excel("data/raw/C_pepo_GBS_accession.xlsx")
moschata <- read_excel("data/raw/C_moschata_GBS_accession.xlsx")
maxima <- read_excel("data/raw/C_maxima_GBS_accession.xlsx")

# Rename columns
colnames(pepo) <- c("accession_id", "accession_name", "taxonomy", "country", "narrative", "improvement_status", "total_reads")

colnames(moschata) <- c("accession_id", "accession_name", "taxonomy", "country", "narrative", "improvement_status", "total_reads")

colnames(maxima) <- c("accession_id", "accession_name", "taxonomy", "country", "narrative", "improvement_status", "total_reads")

# Remove white space from accession Ids
pepo$accession_id <- gsub(" ", "_", pepo$accession_id)
moschata$accession_id <- gsub(" ", "_", moschata$accession_id)
maxima$accession_id <- gsub(" ", "_", maxima$accession_id)

# Fix some country names
pepo$country <- gsub("Russian Federation", "Russia", pepo$country)
pepo$country <- gsub("Korea", "South Korea", pepo$country)

moschata$country <- gsub("Russian Federation", "Russia", moschata$country)
moschata$country <- gsub("Korea", "South Korea", moschata$country)

maxima$country <- gsub("Russian Federation", "Russia", maxima$country)
maxima$country <- gsub("Korea", "South Korea", maxima$country)

pepo <- merge(pepo, countryDat, by="country", sort=F, all.x=T)
moschata <- merge(moschata, countryDat, by="country", sort=F, all.x=T)
maxima <- merge(maxima, countryDat, by="country", sort=F, all.x=T)

# Write out new files as tab-delimited
write_delim(pepo, "data/cpepo_manifest.tsv", delim="\t")
write_delim(moschata, "data/cmoschata_manifest.tsv", delim="\t")
write_delim(maxima, "data/cmaxima_manifest.tsv", delim="\t")





