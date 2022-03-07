#!/bin/bash

bcftools query -f '%ID,%CHROM,%POS\n' data/cmaxima_filt.bcf > data/cmaxima_filt.map
bcftools query -f '%ID,%CHROM,%POS\n' data/cpepo_filt.bcf  > data/cpepo_filt.map
bcftools query -f '%ID,%CHROM,%POS\n' data/cmoschata_filt.bcf  > data/cmoschata_filt.map

bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cmaxima_raw_SNP.vcf.gz > data/cmaxima_raw.map
bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cpepo_raw_SNP.vcf.gz  > data/cpepo_raw.map
bcftools query -f '%ID,%CHROM,%POS\n' data/raw/Cmoschata_raw_SNP.vcf.gz  > data/cmoschata_raw.map

