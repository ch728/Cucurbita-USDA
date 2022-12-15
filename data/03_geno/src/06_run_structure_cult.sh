#!/bin/bash

# Must create links to appropriate files in directore. Example for cpepo:
# cp data/admix/cpepo/cpepo_admix_nocult.6.P data/admix/cpepo/cpepo_admix_cult.6.P.in
# ln -s data/filtered/cpepo_admix_cult.* data/admix/cpepo/.

admixture -P data/admix/cpepo/cpepo_admix_cult.bed 10
admixture -P data/admix/cmoschata/cmoschata_admix_cult.bed 6
admixture -P data/admix/cmaxima/cmaxima_admix_cult.bed 6

