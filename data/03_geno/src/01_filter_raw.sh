#!/bin/bash

# Tabix index raw vcfs to prevent annoying eror

# Filtering

bcftools view data/raw/Cmaxima_raw_SNP.vcf.gz |  
 bcftools reheader -h ../01_meta/data/maxima_head.txt |
 bcftools view -M2 -m2 -i "MAF > 0.05  & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs ../01_meta/data/cmoschata_chrs.txt -Ob > data/filtered/cmaxima_filt.bcf

#bcftools view data/raw/Cmoschata_raw_SNP.vcf.gz |  
# bcftools reheader -h ../01_meta/data/moschata_head.txt |
# bcftools view -M2 -m2 -i "MAF > 0.05  & F_MISSING <= 0.4" |
# bcftools annotate --rename-chrs ../01_meta/data/cmoschata_chrs.txt -Ob > data/filtered/cmoschata_filt.bcf
#
#bcftools view data/raw/Cpepo_raw_SNP.vcf.gz |  
# bcftools reheader -h ../01_meta/data/pepo_head.txt |
# bcftools view -M2 -m2 -i "MAF > 0.05  & F_MISSING <= 0.4" |
# bcftools annotate --rename-chrs ../01_meta/data/cpepo_chrs.txt -Ob > data/filtered/cpepo_filt.bcf
#
# LD prune to be used for population structure


