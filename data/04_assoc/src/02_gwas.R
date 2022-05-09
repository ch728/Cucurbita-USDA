library(GENESIS)

# Functions

run_gwas <- function(geno, pheno, k, quant, logistic){

  res <- list()
} 
# Read in pheno and geno
pepoPheno <- read.csv("data/02_pheno/data/cpepo_coded.csv",
		      stringsAsFactors=F)
mosPheno <- read.csv("data/02_pheno/data/cmoschata_coded.csv",
		     stringsAsFactors=F)
maxPheno <- read.csv("data/02_pheno/data/cmaxima_coded.csv",
		     stringsAsFactors=F) 

pepoGeno <- GdsGenotypeReader("data/03_geno/filtered/")
mosGeno <- GdsGenotypeReader("data/03_geno/filtered/")
maxGeno <- GdsGenotypeReader("data/03_geno/filtered/")  

# Get pcas

# Get relationship matrices

# Create ScanAnnotationDataFrame Object

# Lists of quant and logistic traits for each species




