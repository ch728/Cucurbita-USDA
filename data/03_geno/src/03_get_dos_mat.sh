#!/bin/bash

# Creates dosage matrix used for PCA analysis

paste <(bcftools query -l data/cpepo_filt.bcf) <(bcftools query -f "[%GT\t]\n" data/cpepo_filt.bcf | datamash transpose) |
     sed 's|1/1|2|g' |
     sed 's|0/0|0|g' |
     sed 's|1/0|1|g' |
     sed 's|\./\.|NA|g' |
     sed 's|0/1|1|g' > data/cpepo.dos

paste <(bcftools query -l data/cmoschata_filt.bcf) <(bcftools query -f "[%GT\t]\n" data/cmoschata_filt.bcf | datamash transpose) |
     sed 's|1/1|2|g' |
     sed 's|0/0|0|g' |
     sed 's|1/0|1|g' |
     sed 's|\./\.|NA|g' |
     sed 's|0/1|1|g' > data/cmoschata.dos

paste <(bcftools query -l data/cmaxima_filt.bcf) <(bcftools query -f "[%GT\t]\n" data/cmaxima_filt.bcf | datamash transpose) |
     sed 's|1/1|2|g' |
     sed 's|0/0|0|g' |
     sed 's|1/0|1|g' |
     sed 's|\./\.|NA|g' |
     sed 's|0/1|1|g' > data/cmaxima.dos

