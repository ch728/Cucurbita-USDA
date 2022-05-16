library(SNPRelate)
library(rrBLUP)
library(matrixcalc)


# Functions
fmt_pca <- function(pca){
  # Format pca object into dataframe 
  df <- data.frame(gid=pca$sample.id,
                   PC1=pca$eigenvect[,1],
                   PC2=pca$eigenvect[,2],
                   PC3=pca$eigenvect[,3],
                   PC4=pca$eigenvect[,4])
  pcaVar <- round(pca$varprop *100,3)[1:4]
  return(list(df, pcaVar))
}


fmt_dos <- function(dos){
  # Format dosage format for genocore
  tdos <- t(dos$genotype)
  colnames(tdos) <- dos$sample.id 
  return(tdos)
}

getKin <- function(dos){
  dosMat <- as.matrix(dos$genotype) - 1
  rownames(dosMat) <- dos$sample.id
  k <- A.mat(dosMat)
  return(k)
}

# Run PCA
pepoGeno <- snpgdsOpen("data/filtered/cpepo_ld_filt.gds")
pepoPCA <- snpgdsPCA(pepoGeno, num.thread=12)
pepoDos <- snpgdsGetGeno(pepoGeno, with.id=T)
snpgdsClose(pepoGeno)

mosGeno <- snpgdsOpen("data/filtered/cmoschata_ld_filt.gds")
mosPCA <- snpgdsPCA(mosGeno, num.thread=12)
mosDos <- snpgdsGetGeno(mosGeno, with.id=T)
snpgdsClose(mosGeno)

maxGeno <- snpgdsOpen("data/filtered/cmaxima_ld_filt.gds")
maxPCA <- snpgdsPCA(maxGeno, num.thread=12)
maxDos <- snpgdsGetGeno(maxGeno, with.id=T)
snpgdsClose(maxGeno)

# Output PCA results 
pepoRes <- fmt_pca(pepoPCA)
write.csv(pepoRes[[1]], "data/pca/pepo_pca.csv", row.names=F, quote=F)
write.csv(pepoRes[[2]], "data/pca/pepo_var.csv", row.names=F, quote=F)

mosRes <- fmt_pca(mosPCA)
write.csv(mosRes[[1]], "data/pca/moschata_pca.csv", row.names=F, quote=F)
write.csv(mosRes[[2]], "data/pca/moschata_var.csv", row.names=F, quote=F)

maxRes <- fmt_pca(maxPCA)
write.csv(maxRes[[1]], "data/pca/maxima_pca.csv", row.names=F, quote=F)
write.csv(maxRes[[2]], "data/pca/maxima_var.csv", row.names=F, quote=F)

# Ouput kinship matrices
pepoK <- getKin(pepoDos)
mosK <- getKin(mosDos)
maxK <- getKin(maxDos) 

# Bend matrix slightly to make positive definite 
diag(pepoK) <- diag(pepoK) + 0.000001
diag(mosK) <- diag(mosK) + 0.000001
diag(maxK) <- diag(maxK) + 0.000001

# Write out kinship mats
write.csv(pepoK,"data/kinship/pepoK.mat", quote=F)
write.csv(mosK, "data/kinship/mosK.mat", quote=F)
write.csv(maxK, "data/kinship/maxK.mat", quote=F)

# Output files for genocore
pepoCore <- fmt_dos(pepoDos)
write.csv(pepoCore, "data/genocore/pepo.csv", row.names=T, quote=F)

mosCore <- fmt_dos(mosDos)
write.csv(mosCore, "data/genocore/moschata.csv", row.names=T, quote=F)

maxCore <- fmt_dos(maxDos)
write.csv(maxCore, "data/genocore/maxima.csv", row.names=T, quote=F)

