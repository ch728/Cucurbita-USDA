library(GENESIS)
library(SNPRelate)
library(GWASTools)

# Functions
run_gwas <- function(genoDf, K,  quant, logistic){
  res <- list() 
  for(trait in quant){
     nullMod <- fitNullModel(genoDf, outcome=trait,
                             covars=c("PC1", "PC2"),
                             cov.mat=K,
                             family=gaussian)
     genoIterator <- GenotypeBlockIterator(genoDf)
     assoc <- assocTestSingle(genoIterator, null.model=nullMod)
     assoc$chr[which(assoc$chr == "U")] <- 0
     res[[length(res) + 1]] <- assoc
  }

  for(trait in logistic){
    nullMod <- fitNullModel(genoDf, outcome=trait,
                            covars=c("PC1", "PC2"),
                            cov.mat=K,
                            family=binomial)
    genoIterator <- GenotypeBlockIterator(genoDf)
    assoc <- assocTestSingle(genoIterator, null.model=nullMod)
    assoc$chr[which(assoc$chr == "U")] <- 0
    res[[length(res) + 1]] <- assoc
  }
  return(res)
} 

# Read in pheno and geno
pepoPheno <- read.csv("../02_pheno/data/cpepo_coded.csv",
		      stringsAsFactors=F)
mosPheno <- read.csv("../02_pheno/data/cmoschata_coded.csv",
		     stringsAsFactors=F)
maxPheno <- read.csv("../02_pheno/data/cmaxima_coded.csv",
		     stringsAsFactors=F) 

# Read in kinship matrices
pepoK <- read.csv("../03_geno/data/kinship/pepoK.mat", row.names=1)
mosK <- read.csv("../03_geno/data/kinship/mosK.mat", row.names=1)
maxK <- read.csv("../03_geno/data/kinship/maxK.mat", row.names=1)

# Read in pcs
pepoPC <- read.csv("../03_geno/data/pca/pepo_pca_gwas.csv")
colnames(pepoPC)[1] <- "scanID"
mosPC <- read.csv("../03_geno/data/pca/moschata_pca_gwas.csv")
colnames(mosPC)[1] <- "scanID"
maxPC <- read.csv("../03_geno/data/pca/maxima_pca_gwas.csv")
colnames(maxPC)[1] <- "scanID"

# Create Geno Objects
pepoGds <- GdsGenotypeReader("../03_geno/data/filtered/cpepo_filt_imp.gds") 

mosGds <- GdsGenotypeReader("../03_geno/data/filtered/cmoschata_filt_imp.gds") 

maxGds <- GdsGenotypeReader("../03_geno/data/filtered/cmaxima_filt_imp.gds") 

# Get annotation dataframes
colnames(pepoPheno)[1] <- "scanID"
pepoAnno <- merge(pepoPC, pepoPheno,all.x=T, by="scanID", sort=F) 
pepoAnno <- pepoAnno[match(getScanID(pepoGds), pepoAnno$scanID),]
pepoAnno <- ScanAnnotationDataFrame(pepoAnno)

colnames(mosPheno)[1] <- "scanID"
mosAnno <- merge(mosPC, mosPheno, all.x=T,  by="scanID", sort=F) 
mosAnno <- mosAnno[match(getScanID(mosGds), mosAnno$scanID),]
mosAnno <- ScanAnnotationDataFrame(mosAnno)

colnames(maxPheno)[1] <- "scanID"
maxAnno <- merge(maxPC, maxPheno, all.x=T, by="scanID", sort=F) 
maxAnno <- maxAnno[match(getScanID(maxGds), maxAnno$scanID),]
maxAnno <- ScanAnnotationDataFrame(maxAnno)

# Create GenotypeData object
pepoGenoDat <- GenotypeData(pepoGds,scanAnnot=pepoAnno)
mosGenoDat <- GenotypeData(mosGds,scanAnnot=mosAnno)
maxGenoDat <- GenotypeData(maxGds,scanAnnot=maxAnno)

# Lists of quant and logistic traits for each species
pepoQ <- c("seed_wt", "max_vig", "min_vig", "max_width",
           "width_min", "len_max", "len_min", "flesh_max",
            "flesh_min", "sb_nymph", "sb_adult", "cuc_inj")
pepoL <- c("or_flesh", "yl_flesh", "yl_fruit", "tan_fruit",
           "gn_fruit", "globe_fruit", "oblong_fruit", 
           "smooth_fruit", "rib_fruit", "spec_fruit", 
           "mot_fruit", "solid_fruit", "plant_type", "plant_type2")

mosQ <- c("fruit_len", "fruit_diam")

mosL <- c("maturity", "or_fruit", "smooth_fruit")

maxQ <- c("len", "set", "diam", "watermelon_mosaic",
          "cuc_mosaic", "maturity", "unif", "pm","vig",
           "rib", "fruit_spot")
maxL <- c("plant_habit", "or_flesh", 
          "gray_fruit", "or_fruit", "gn_fruit")

# Run Gwas for each species
pepoK <- as.matrix(pepoK[getScanID(pepoGds), getScanID(pepoGds)])
pepoGwas <- run_gwas(pepoGenoDat, pepoK, quant=pepoQ, logistic=pepoL)
#names(pepoGwas) <- c(pepoQ, pepoL)

mosK <- as.matrix(mosK[getScanID(mosGds), getScanID(mosGds)])
mosGwas <- run_gwas(mosGenoDat, mosK, quant=mosQ, logistic=mosL)
#names(mosGwas) <- c(mosQ, mosL)

maxK <- as.matrix(maxK[getScanID(maxGds), getScanID(maxGds)])
maxGwas <- run_gwas(maxGenoDat, maxK, quant=maxQ, logistic=maxL)
#names(maxGwas) <- c(maxQ, maxL)

# Save Gwas results as R objects
#saveRDS(pepoGwas, "data/pepoGwas.Rdata")
#saveRDS(mosGwas, "data/mosGwas.Rdata")
#saveRDS(maxGwas, "data/maxGwas.Rdata") 


