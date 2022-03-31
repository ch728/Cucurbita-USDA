library(tidyverse)
library(SNPRelate)
library(asreml)
library(ASRgenomics)


# Set asreml options
asreml.options(maxit=50)

# Read in phenotype data files
pepoPheno <- read_delim("../02_pheno/data/cpepo_coded.csv", delim=",")
mosPheno <- read_delim("../02_pheno/data/cmoschata_coded.csv", delim=",")
maxPheno <- read_delim("../02_pheno/data/cmaxima_coded.csv", delim=",")

# Read in genotype data files 
pepoGeno <- snpgdsOpen("../03_geno/data/filtered/cpepo_filt_imp.gds")
pepoNum <- snpgdsGetGeno(pepoGeno, with.id=T)
pepoDos <- as.matrix(pepoNum$genotype)
rownames(pepoDos) <- pepoNum$sample.id
colnames(pepoDos) <- pepoNum$snp.id
snpgdsClose(pepoGeno)

mosGeno <- snpgdsOpen("../03_geno/data/filtered/cmoschata_filt_imp.gds")
mosNum <- snpgdsGetGeno(mosGeno, with.id=T)
mosDos <- as.matrix(mosNum$genotype)
rownames(mosDos) <- mosNum$sample.id
colnames(mosDos) <- mosNum$snp.id
snpgdsClose(mosGeno)

maxGeno <- snpgdsOpen("../03_geno/data/filtered/cmaxima_filt_imp.gds")
maxNum <- snpgdsGetGeno(maxGeno, with.id=T)
maxDos <- as.matrix(maxNum$genotype)
rownames(maxDos) <- maxNum$sample.id
colnames(maxDos) <- maxNum$snp.id
snpgdsClose(maxGeno)

# Make grms
pepoG <- G.inverse(G=G.matrix(pepoDos)$G, blend=T, sparseform=T)
mosG <- G.inverse(G=G.matrix(mosDos)$G, blend=T, sparseform=T)
maxG <- G.inverse(G=G.matrix(maxDos)$G, blend=T, sparseform=T)

# Model continuous traits
pepoRes <- data.frame()
pepoQuant <- pepoPheno[, c("accession_id","seed_wt")]
pepoQuant$accession_id <- as.factor(pepoQuant$accession_id)

# Model binary traits


# Model ordinal traits
