library(SNPRelate)

# Write imputed and pop filtered vcfs to gds file for 
# use with SNPRelate and GENESIS

snpgdsVCF2GDS("data/filtered/cpepo_filt_imp.vcf", 
              "data/filtered/cpepo_filt_imp.gds",
              method="biallelic.only")

snpgdsVCF2GDS("data/filtered/cmoschata_filt_imp.vcf", 
              "data/filtered/cmoschata_filt_imp.gds",
              method="biallelic.only")

snpgdsVCF2GDS("data/filtered/cmaxima_filt_imp.vcf", 
              "data/filtered/cmaxima_filt_imp.gds",
              method="biallelic.only")

snpgdsVCF2GDS("data/filtered/cpepo_ld_filt.vcf", 
              "data/filtered/cpepo_ld_filt.gds",
              method="biallelic.only")

snpgdsVCF2GDS("data/filtered/cmoschata_ld_filt.vcf", 
              "data/filtered/cmoschata_ld_filt.gds",
              method="biallelic.only")

snpgdsVCF2GDS("data/filtered/cmaxima_ld_filt.vcf", 
              "data/filtered/cmaxima_ld_filt.gds",
              method="biallelic.only")
