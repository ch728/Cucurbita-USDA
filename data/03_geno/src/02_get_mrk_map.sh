#!/bin/bash

bcftools query -f '%ID,%CHROM,%POS\n' data/filtered/cmaxima_filt.bcf > data/maps/cmaxima_filt.map
bcftools query -f '%ID,%CHROM,%POS\n' data/filtered/cpepo_filt.bcf  > data/maps/cpepo_filt.map
bcftools query -f '%ID,%CHROM,%POS\n' data/filtered/cmoschata_filt.bcf  > data/maps/cmoschata_filt.map

bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cmaxima_raw_SNP.vcf.gz > data/maps/cmaxima_raw.map
bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cpepo_raw_SNP.vcf.gz  > data/maps/cpepo_raw.map
bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cmoschata_raw_SNP.vcf.gz  > data/maps/cmoschata_raw.map

