#!/bin/bash

cat <(echo "chr,pos,allele") <(bcftools query -f "%CHROM,%POS,%REF/%ALT\n" data/filtered/cpepo_filt_imp.vcf) > data/cpepo_gwas_mrkinfo.tsv

cat <(echo "chr,pos,allele") <(bcftools query -f "%CHROM,%POS,%REF/%ALT\n" data/filtered/cmoschata_filt_imp.vcf) > data/cmos_gwas_mrkinfo.tsv

cat <(echo "chr,pos,allele") <(bcftools query -f "%CHROM,%POS,%REF/%ALT\n" data/filtered/cmaxima_filt_imp.vcf) > data/cmax_gwas_mrkinfo.tsv

