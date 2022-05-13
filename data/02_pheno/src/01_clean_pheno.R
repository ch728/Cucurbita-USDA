library(tidyverse)

# Functions 
missing_filt <- function(x){
  if(sum(!is.na(x)) > 80){
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Get names
cpepo_names <- read_delim("../01_meta/data/cpepo_manifest.tsv", delim="\t")[,"accession_id",1]
cmoschata_names <- read_delim("../01_meta/data/cmoschata_manifest.tsv", delim="\t")[,"accession_id",1]
cmaxima_names <- read_delim("../01_meta/data/cmaxima_manifest.tsv", delim="\t")[,"accession_id",1]

# Clean data frames
cpepo_pheno <- read_delim("data/raw/cpepo.tsv", delim="\t")
cpepo_pheno$ACCESSION <- gsub(" ", "_", cpepo_pheno$ACCESSION)
cpepo_pheno <- cpepo_pheno[cpepo_pheno$ACCESSION %in% cpepo_names,]
keep <- as.vector(apply(cpepo_pheno, 2, missing_filt))
cpepo_pheno <- cpepo_pheno[, keep]
colnames(cpepo_pheno) <- c("accession_id", "100wt", "100wt2", "flesh_color",
			   "fruit_shape", "fruit_txt", "min_vig", "max_width", 
			   "sqush_nymph", "cuc_inj", "flesh_max",
			   "len_min", "width_min", "len_max",
			   "squash_adult", "fruit_pat", "fruit_color",
			   "plant_type", "max_vig", "flesh_min") 
			   
cmoschata_pheno <- read_delim("data/raw/cmoschata.tsv", delim="\t")
cmoschata_pheno$ACCESSION <- gsub(" ", "_", cmoschata_pheno$ACCESSION)
cmoschata_pheno <- cmoschata_pheno[cmoschata_pheno$ACCESSION %in% cmoschata_names,]
keep <- as.vector(apply(cmoschata_pheno, 2, missing_filt))
cmoschata_pheno <- cmoschata_pheno[, keep]
colnames(cmoschata_pheno) <- c("accession_id", "fruit_shape", "len",
			       "diam", "maturity", "fruit_color",
			       "fruit_surf")

cmaxima_pheno <- read_delim("data/raw/cmaxima.tsv", delim="\t")
cmaxima_pheno$ACCESSION <- gsub(" ", "_", cmaxima_pheno$ACCESSION)
cmaxima_pheno <- cmaxima_pheno[cmaxima_pheno$ACCESSION %in% cmaxima_names,]
keep <- as.vector(apply(cmaxima_pheno, 2, missing_filt))
cmaxima_pheno <- cmaxima_pheno[, keep]
colnames(cmaxima_pheno) <- c("accession_id", "flesh_color", 
			     "watermelon_mosaic", "maturity", "flesh_depth",
			     "diam", "len", "set", "plant_habit", "PM",
			     "ribbing", "uniformity", "fruit_spot",
		             "vig", "fruit_color", "cuc_mosaic") 
# Output cleaned pheno
write_delim(cpepo_pheno, "data/cpepo_clean_pheno.tsv", delim="\t")
write_delim(cmoschata_pheno, "data/cmoschata_clean_pheno.tsv", delim="\t")
write_delim(cmaxima_pheno, "data/cmaxima_clean_pheno.tsv", delim="\t")

