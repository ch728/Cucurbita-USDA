library(tidyverse)
library(readxl)


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

# Write out new files as tab-delimited
write.table(pepo, "data/cpepo_manifest.tsv", sep="\t", row.names=F, quote=F)
write.table(moschata, "data/cmoschata_manifest.tsv", sep="\t", row.names=F, quote=F)
write.table(maxima, "data/cmaxima_manifest.tsv", sep="\t", row.names=F, quote=F)





