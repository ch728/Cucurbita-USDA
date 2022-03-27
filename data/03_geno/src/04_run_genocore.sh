#!/bin/bash

# linked in data/GenoCore directory
# Script must be run in the data/GenoCore directory 

Rscript --vanilla run_genocore.R cpepo.csv -cv 99 -d 0.001 -o cpepo_core

Rscript --vanilla run_genocore.R cmoschata.csv -cv 99 -d 0.001 -o cmoschata_core

Rscript --vanilla run_genocore.R cmaxima.csv -cv 99 -d 0.001 -o cmaxima_core


