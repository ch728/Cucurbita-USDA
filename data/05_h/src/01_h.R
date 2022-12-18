library(rrBLUP)

calc_h <- function(m,pheno,traits){
  h2_res <- c()
  for(t in traits){
    mod <- kin.blup(data=pheno, geno="accession_id", pheno=t, K=m) 
    h2 <- round(mod$Vg/(mod$Vg + mod$Ve), 3) 
    h2_res <- c(h2_res, h2)
  }
  return(h2_res)
}

# Read in pheno and geno
pepoPheno <- read.csv("../02_pheno/data/cpepo_coded.csv",
		      stringsAsFactors=F)
mosPheno <- read.csv("../02_pheno/data/cmoschata_coded.csv",
		     stringsAsFactors=F)
maxPheno <- read.csv("../02_pheno/data/cmaxima_coded.csv",
		     stringsAsFactors=F) 

# Read in kinship matrices
pepoK <- as.matrix(read.csv("../03_geno/data/kinship/pepoK.mat", row.names=1))
mosK <- as.matrix(read.csv("../03_geno/data/kinship/mosK.mat", row.names=1))
maxK <- as.matrix(read.csv("../03_geno/data/kinship/maxK.mat", row.names=1))

# Lists of quant and logistic traits for each species
pepoQ <- c("seed_wt", "max_vig", "min_vig", "max_width",
           "width_min", "len_max", "len_min", "flesh_max",
            "flesh_min", "sb_nymph", "sb_adult", "cuc_inj")
mosQ <- c("fruit_len", "fruit_diam")


maxQ <- c("len", "set", "diam", "watermelon_mosaic",
          "cuc_mosaic", "maturity", "unif", "pm","vig",
           "rib", "fruit_spot")

# Subset phenotype files
pepoSub <- pepoPheno[, c("accession_id", pepoQ)]
pepoSub <- pepoPheno[pepoPheno$accession_id %in% rownames(pepoK),]

mosSub <- mosPheno[, c("accession_id", mosQ)]
mosSub <- mosPheno[mosPheno$accession_id %in% rownames(mosK),]

maxSub <- maxPheno[, c("accession_id", maxQ)]
maxSub <- maxPheno[maxPheno$accession_id %in% rownames(maxK),]


