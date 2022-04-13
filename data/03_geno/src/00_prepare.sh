#!/bin/bash

# Make base directories
if [[ ! -d "data/raw" ]]
then
  mkdir data/raw data/filtered 
fi

# Download raw genotype data
wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cmaxima_raw_SNP.vcf.gz -O data/raw/Cmaxima_raw_SNP.vcf.gz

wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cmoschata_raw_SNP.vcf.gz -O data/raw/Cmoschata_raw_SNP.vcf.gz

wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cpepo_raw_SNP.vcf.gz -O data/raw/Cpepo_raw_SNP.vcf.gz

