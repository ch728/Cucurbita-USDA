#!/bin/bash

# Get prune sets 
plink --bcf data/cpepo_filt.bcf  --double-id --allow-extra-chr --indep-pairwise 50 10 0.1 --out data/admix/cpepo/cpepo

plink --bcf data/cmoschata_filt.bcf  --double-id --allow-extra-chr --indep-pairwise 50 10 0.1 --out data/admix/cmoschata/cmoschata

plink --bcf data/cmaxima_filt.bcf  --double-id --allow-extra-chr --indep-pairwise 50 10 0.1 --out data/admix/cmaxima/cmaxima


# Get files for non-cultivars
plink --bcf data/cpepo_filt.bcf --extract data/admix/cpepo/cpepo.prune.in --remove ../01_meta/data/cpepo_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cpepo/cpepo_nocult 

plink --bcf data/cmoschata_filt.bcf --extract data/admix/cmoschata/cmoschata.prune.in --remove ../01_meta/data/cmoschata_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cmoschata/cmoschata_nocult 

plink --bcf data/cmaxima_filt.bcf --extract data/admix/cmaxima/cmaxima.prune.in --remove ../01_meta/data/cmaxima_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cmaxima/cmaxima_nocult 


# Get files for cultivars
plink --bcf data/cpepo_filt.bcf --extract data/admix/cpepo/cpepo.prune.in --keep ../01_meta/data/cpepo_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cpepo/cpepo_cult 

plink --bcf data/cmoschata_filt.bcf --extract data/admix/cmoschata/cmoschata.prune.in --keep ../01_meta/data/cmoschata_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cmoschata/cmoschata_cult 

plink --bcf data/cmaxima_filt.bcf --extract data/admix/cmaxima/cmaxima.prune.in --keep ../01_meta/data/cmaxima_cultivars.txt --make-bed --allow-extra-chr --double-id  --out data/admix/cmaxima/cmaxima_cult 


# Get files for cultivars
rm data/admix/cpepo/*.log
rm data/admix/cpepo/*.nosex
rm data/admix/cpepo/*.prune.out

rm data/admix/cmoschata/*.log
rm data/admix/cmoschata/*.nosex
rm data/admix/cmoschata/*.prune.out

rm data/admix/cmaxima/*.log
rm data/admix/cmaxima/*.nosex
rm data/admix/cmaxima/*.prune.out
