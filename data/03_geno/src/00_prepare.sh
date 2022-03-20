#!/bin/bash

# Make base directories
if [[ ! -d "data" ]]
then
  mkdir data
  mkdir data/raw data/admix data/gwas data/pca data/filtered
  mkdir data/admix/cpepo data/admix/cmoschata data/admix/cmaxima
fi

# Download raw genotype data
wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cmaxima_raw_SNP.vcf.gz -O data/raw/Cmaxima_raw_SNP.vcf.gz

wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cmoschata_raw_SNP.vcf.gz -O data/raw/Cmoschata_raw_SNP.vcf.gz

wget http://cucurbitgenomics.org/ftp/GBS_SNP/cucurbita/Cpepo_raw_SNP.vcf.gz -O data/raw/Cpepo_raw_SNP.vcf.gz

# Clone Genocore repo and clean 
git clone https://github.com/lovemun/Genocore.git data/genocore
rm data/genocore/wheat* data/genocore/LICENSE data/genocore/README.md
rm -rf data/genocore/.git

