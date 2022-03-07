library(ASRgenomics)
library(data.table)


# Read in data files
pepo.dos <- as.matrix(data.frame(fread("data/cpepo.dos"), row.names=1))
moschata.dos <- as.matrix(data.frame(fread("data/cmoschata.dos"), row.names=1))
maxima.dos <- as.matrix(data.frame(fread("data/cmaxima.dos"), row.names=1))

# Make some qc stats
pepo.qc <- qc.filtering(pepo.dos, ind.callrate=0.3, maf=0.05, marker.callrate=0.2)
moschata.qc <- qc.filtering(moschata.dos, ind.callrate=0.3, maf=0.05, marker.callrate=0.2)
maxima.qc <- qc.filtering(maxima.dos, ind.callrate=0.3, maf=0.05, marker.callrate=0.2)

# Write out clean matrix for genocore
write.csv(t(pepo.qc$M.clean), "data/Genocore/cpepo.csv", quote=F)
write.csv(t(moschata.qc$M.clean), "data/Genocore/cmoschata.csv", quote=F)
write.csv(t(maxima.qc$M.clean), "data/Genocore/cmaxima.csv", quote=F)

# Get G mats
pepo.G  <- G.matrix(pepo.qc$M.clean)$G
moschata.G  <- G.matrix(moschata.qc$M.clean)$G
maxima.G  <- G.matrix(maxima.qc$M.clean)$G

# Run PCA
pepo.pc <- kinship.pca(pepo.G)
moschata.pc <- kinship.pca(moschata.G)
maxima.pc <- kinship.pca(maxima.G)

# Write results 
write.csv(pepo.pc$pca.scores, "data/pca/cpepo_scores.csv", quote=F)
write.csv(pepo.pc$eigenvalues, "data/pca/cpepo_eigen.csv", quote=F)

write.csv(moschata.pc$pca.scores, "data/pca/cmoschata_scores.csv", quote=F)
write.csv(moschata.pc$eigenvalues, "data/pca/cmoschata_eigen.csv", quote=F)

write.csv(maxima.pc$pca.scores, "data/pca/cmaxima_scores.csv", quote=F)
write.csv(maxima.pc$eigenvalues, "data/pca/cmaxima_eigen.csv", quote=F)

