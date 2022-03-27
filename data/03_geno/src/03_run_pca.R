library(SNPRelate)
library(SeqArray)

# Run PCA
pepoGeno <- snpgdsOpen("data/filtered/cpepo_ld_filt.gds")
pepoPCA <- snpgdsPCA(pepoGeno, num.thread=12)
snpgdsClose(pepoGeno)


# Output PCA results 



