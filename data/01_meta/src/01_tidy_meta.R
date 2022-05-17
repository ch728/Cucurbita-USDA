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
countryDat <- rbind(countryDat, data.frame(country="Afghanistan", region="Asia"))
countryDat <- rbind(countryDat, data.frame(country="Democratic Republic of the Congo", region="Africa"))
countryDat <- rbind(countryDat, data.frame(country="Africa", region="Africa"))
countryDat[countryDat$country=="Australia",2] <- "Australia"
countryDat <- rbind(countryDat, data.frame(country="Reunion", region="Europe"))
countryDat <- rbind(countryDat, data.frame(country="Eswatini", region="Africa"))

# Read in files
pepo <- read_excel("data/raw/C_pepo_GBS_accession.xlsx")
moschata <- read_excel("data/raw/C_moschata_GBS_accession.xlsx")
maxima <- read_excel("data/raw/C_maxima_GBS_accession.xlsx")

pepoEx <- scan("data/pepo_remove.txt", what="character")
maximaEx <- scan("data/maxima_remove.txt", what="character")

# Rename columns
colnames(pepo) <- c("accession_id", "accession_name", "taxonomy", "country", "narrative", "cultivar_class", "improvement_status")

colnames(moschata) <- c("accession_id", "accession_name", "taxonomy", "country", "narrative", "cultivar_class", "improvement_status")

colnames(maxima) <- c("accession_id", "accession_name", "taxonomy", "country","improvement_status", "cultivar_class",
"narrative")

# Fix some country names
pepo$country <- gsub("Russian Federation", "Russia", pepo$country)
pepo$country <- gsub("Korea", "South Korea", pepo$country)

moschata$country <- gsub("Russian Federation", "Russia", moschata$country)
moschata$country <- gsub("Korea", "South Korea", moschata$country)

maxima$country <- gsub("Russian Federation", "Russia", maxima$country)
maxima$country <- gsub("Korea", "South Korea", maxima$country)
maxima$country <- gsub("North Macedonia", "Macedonia", maxima$country)

pepo <- merge(pepo, countryDat, by="country", sort=F, all.x=T)
moschata <- merge(moschata, countryDat, by="country", sort=F, all.x=T)
maxima <- merge(maxima, countryDat, by="country", sort=F, all.x=T)

# Write out new manifest files as tab-delimited
write_delim(pepo, "data/cpepo_manifest.tsv", delim="\t")
write_delim(moschata, "data/cmoschata_manifest.tsv", delim="\t")
write_delim(maxima, "data/cmaxima_manifest.tsv", delim="\t")

# Write out cultivar files
pepoCult <- pepo %>% 
                filter(improvement_status == "Breeding material" |
                       improvement_status == "Cultivar",
                        !(accession_id %in% pepoEx)) %>%
                select(accession_id)
pepoCult$copy <- pepoCult$accession_id

moschataCult <- moschata %>% 
                filter(improvement_status == "Breeding material" |
                       improvement_status == "Cultivar") %>%
                select(accession_id)
moschataCult$copy <- moschataCult$accession_id

maximaCult <- maxima %>% 
                filter(improvement_status == "Breeding" |
                       improvement_status == "Cultivar",
                       !(accession_id %in% maximaEx)) %>%
                select(accession_id)
maximaCult$copy <- maximaCult$accession_id

write_delim(pepoCult, "data/cpepo_cultivars.txt", col_names=F)
write_delim(moschataCult, "data/cmoschata_cultivars.txt", col_names=F)
write_delim(maximaCult, "data/cmaxima_cultivars.txt",  col_names=F)

# Write out cultivar classification files
pepoClass <- pepo %>% 
                  filter(!is.na(cultivar_class)) %>%
		  select(accession_id, cultivar_class) %>%
		  rename(name=accession_id,
			 class=cultivar_class)

mosClass <- moschata %>%
	            filter(!is.na(cultivar_class)) %>%
		    select(accession_id, cultivar_class)%>%
		    rename(name=accession_id,
			   class=cultivar_class)

maxClass <- maxima %>%
	            filter(!is.na(cultivar_class)) %>%
		    select(accession_id, cultivar_class) %>%
		    rename(name=accession_id,
			   class=cultivar_class)

write.csv(pepoClass, "data/cpepo_classifications.csv",
	  row.names=F, quote=F)

write.csv(mosClass, "data/cmoschata_classifications.csv",
	  row.names=F, quote=F)

write.csv(maxClass, "data/cmaxima_classifications.csv",
	  row.names=F, quote=F)

