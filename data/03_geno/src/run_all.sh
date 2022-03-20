#!/bin/bash

# Download raw genotype data and set up data directory
bash src/00_prepare.sh

# Filter raw data
bash src/01_filter_raw.sh

# Get maker maps
bash src/02_get_mrk_map.sh

# Create dosage matrix
bash src/03_get_dos_map.sh

# Run PCA analysis
bash src/04_run_pca.R

# Run Genocore program

#

