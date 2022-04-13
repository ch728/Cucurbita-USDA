#!/bin/bash

# Filtering
bcftools view data/raw/Cmaxima_raw_SNP.vcf.gz |  
 bcftools reheader -h ../01_meta/data/maxima_head.txt |
 bcftools view -S ^../01_meta/data/maxima_remove.txt -M2 -m2 -v snps -i "MAF >= 0.05 & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs ../01_meta/data/cmaxima_chrs.txt -Ob > data/filtered/cmaxima_filt.bcf

bcftools view data/raw/Cmoschata_raw_SNP.vcf.gz |  
 bcftools reheader -h ../01_meta/data/moschata_head.txt |
 bcftools view -M2 -m2 -v snps -i "MAF >= 0.05 & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs ../01_meta/data/cmoschata_chrs.txt -Ob > data/filtered/cmoschata_filt.bcf

bcftools view data/raw/Cpepo_raw_SNP.vcf.gz |  
 bcftools reheader -h ../01_meta/data/pepo_head.txt |
 bcftools view -S ^../01_meta/data/pepo_remove.txt -M2 -m2 -v snps -i "MAF >= 0.05 & F_MISSING <= 0.4" |
 bcftools annotate --rename-chrs ../01_meta/data/cpepo_chrs.txt -Ob > data/filtered/cpepo_filt.bcf

# LD prune to be used for population structure
plink --bcf data/filtered/cpepo_filt.bcf --double-id --indep-pairwise 50 10 0.1 --out data/filtered/cpepo

plink --bcf data/filtered/cmoschata_filt.bcf --double-id --indep-pairwise 50 10 0.1 --out data/filtered/cmoschata

plink --bcf data/filtered/cmaxima_filt.bcf --double-id --indep-pairwise 50 10 0.1 --out data/filtered/cmaxima

bcftools view data/filtered/cpepo_filt.bcf |
awk -f src/mark_filt.awk data/filtered/cpepo.prune.in - > data/filtered/cpepo_ld_filt.vcf

bcftools view data/filtered/cmoschata_filt.bcf |
awk -f src/mark_filt.awk data/filtered/cmoschata.prune.in - > data/filtered/cmoschata_ld_filt.vcf

bcftools view data/filtered/cmaxima_filt.bcf |
awk -f src/mark_filt.awk data/filtered/cmaxima.prune.in - > data/filtered/cmaxima_ld_filt.vcf

# Create files for stucture analysis
plink --vcf data/filtered/cpepo_ld_filt.vcf  --double-id --remove ../01_meta/data/cpepo_cultivars.txt --make-bed --out data/filtered/cpepo_admix_nocult

plink --vcf data/filtered/cpepo_ld_filt.vcf  --double-id --keep ../01_meta/data/cpepo_cultivars.txt --make-bed --out data/filtered/cpepo_admix_cult


plink --vcf data/filtered/cmoschata_ld_filt.vcf  --double-id --remove ../01_meta/data/cmoschata_cultivars.txt --make-bed --out data/filtered/cmoschata_admix_nocult

plink --vcf data/filtered/cmoschata_ld_filt.vcf --double-id --keep ../01_meta/data/cmoschata_cultivars.txt --make-bed --out data/filtered/cmoschata_admix_cult


plink --vcf data/filtered/cmaxima_ld_filt.vcf  --double-id --remove ../01_meta/data/cmaxima_cultivars.txt --make-bed --out data/filtered/cmaxima_admix_nocult

plink --vcf data/filtered/cmaxima_ld_filt.vcf  --double-id --keep ../01_meta/data/cmaxima_cultivars.txt --make-bed --out data/filtered/cmaxima_admix_cult

# Create vcf.gz files for imputation 
bcftools view data/filtered/cmaxima_filt.bcf -Oz > data/filtered/cmaxima_filt.vcf.gz
bcftools view data/filtered/cmoschata_filt.bcf -Oz > data/filtered/cmoschata_filt.vcf.gz
bcftools view data/filtered/cpepo_filt.bcf -Oz > data/filtered/cpepo_filt.vcf.gz

# Run imputation using tassel (assumes tassel-5-standalone is in PATH)
run_pipeline.pl -Xmx50g -VCF data/filtered/cmaxima_filt.vcf.gz \
-FilterSiteBuilderPlugin -siteMinAlleleFreq 0.05 -removeMinorSNPStates true -siteMinCount 288 -endPlugin \
-LDKNNiImputationPlugin -endPlugin \
-export data/filtered/cmaxima_filt_imp \
-exportType VCF 

run_pipeline.pl -Xmx50g -VCF data/filtered/cmoschata_filt.vcf.gz \
-FilterSiteBuilderPlugin -siteMinAlleleFreq 0.05 -removeMinorSNPStates true -siteMinCount 251 -endPlugin \
-LDKNNiImputationPlugin -endPlugin \
-export data/filtered/cmoschata_filt_imp \
-exportType VCF 

run_pipeline.pl -Xmx50g -VCF data/filtered/cpepo_filt.vcf.gz \
-FilterSiteBuilderPlugin -siteMinAlleleFreq 0.05 -removeMinorSNPStates true -siteMinCount 663 -endPlugin \
-LDKNNiImputationPlugin -endPlugin \
-export data/filtered/cpepo_filt_imp \
-exportType VCF 

# Create .gds for pca and GENESIS
Rscript --vanilla src/make_gds.R

# Clean up 
rm data/filtered/*.prune.out
rm data/filtered/*.log
rm data/filtered/*.nosex


