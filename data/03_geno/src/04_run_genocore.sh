#!/bin/bash

# linked in data/GenoCore directory
# Script must be run in the data/genocore directory 

Rscript --vanilla run_genocore.R pepo.csv -cv 99 -d 0.001 -o cpepo_core

Rscript --vanilla run_genocore.R moschata.csv -cv 99 -d 0.001 -o cmoschata_core

Rscript --vanilla run_genocore.R maxima.csv -cv 99 -d 0.001 -o cmaxima_core


