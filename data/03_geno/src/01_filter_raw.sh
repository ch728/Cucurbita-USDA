#!/bin/bash

bcftools view data/raw/Cmaxima_raw_SNP.vcf.gz |  
 bcftools reheader -h data/maxima_head.txt |
 bcftools view -M2 -m2 -i "MAF > 0.01  & F_MISSING <= 0.4"  |
 bcftools annotate --rename-chrs data/cmaxima_chrs.txt -Ob > data/cmaxima_filt.bcf


bcftools view data/raw/Cmoschata_raw_SNP.vcf.gz |  
 bcftools reheader -h data/moschata_head.txt |
 bcftools view -M2 -m2 -i "MAF > 0.01  & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs data/cmoschata_chrs.txt -Ob > data/cmoschata_filt.bcf

bcftools view data/raw/Cpepo_raw_SNP.vcf.gz |  
 bcftools reheader -h data/pepo_head.txt |
 bcftools view -M2 -m2 -i "MAF > 0.01  & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs data/cpepo_chrs.txt -Ob > data/cpepo_filt.bcf
