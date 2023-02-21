library(xtable)

bold <-function(x){
paste0('{\\bfseries ',x,'}')
}

create_table <- function(tbl, traits){
 snp.dat <- data.frame()
 for(t in traits){
  sort.tbl <- data.frame(
  trait=rep(t, nrow(tbl[[t]])),
  chr=tbl[[t]][["chr"]],
  pos=tbl[[t]][["pos"]],
  pval=tbl[[t]][["Score.pval"]],
  pve=round(tbl[[t]][["PVE"]],3)
  )
 sort.tbl <- sort.tbl[order(sort.tbl$pval)[1:5],]
 snp.dat <- rbind(snp.dat, sort.tbl) 
 }
 return(snp.dat)
}

# Read in marker info
pepoMrk <- read.csv("data/03_geno/data/cpepo_gwas_mrkinfo.tsv")
mosMrk <- read.csv("data/03_geno/data/cmos_gwas_mrkinfo.tsv")
maxMrk <- read.csv("data/03_geno/data/cmax_gwas_mrkinfo.tsv")

# Read in gwas results
pepoRes <- readRDS("data/04_assoc/data/pepoGwas.Rdata")
mosRes <- readRDS("data/04_assoc/data/mosGwas.Rdata")
maxRes <- readRDS("data/04_assoc/data/maxGwas.Rdata")


# Get SNP tables
pepo.traits <- c("plant_type", "plant_type2","gn_fruit", "or_flesh",
		 "flesh_max")
pepo.tbl <- create_table(pepoRes, pepo.traits)
pepo.tbl$species <- rep("C. pepo", nrow(pepo.tbl))
pepo.tbl <- merge(pepo.tbl, pepoMrk, by=c("chr", "pos"), all.x=T, sort=F)

mos.traits <- c("fruit_len")
mos.tbl <- create_table(mosRes, mos.traits)
mos.tbl$species <- rep("C. moschata", nrow(mos.tbl)) 
mos.tbl <- merge(mos.tbl, mosMrk, by=c("chr", "pos"), all.x=T, sort=F)

max.traits <-c("rib", "gn_fruit")
max.tbl  <- create_table(maxRes, max.traits)
max.tbl$species <- rep("C. maxima", nrow(max.tbl))
max.tbl <- merge(max.tbl, maxMrk, by=c("chr", "pos"), all.x=T, sort=F)

# Combine all
all.tbl <- rbind(pepo.tbl, mos.tbl, max.tbl)
all.tbl <- all.tbl[,c("trait", "species", "chr", "pos", "allele")]
colnames(all.tbl) <- c("Trait", "Species", "Chrom", "Pos", "Alleles")
print(xtable(all.tbl), sanitize.colnames.function= bold, type="latex", file="supplemental/snp_table.tex",
      include.rownames=F)

