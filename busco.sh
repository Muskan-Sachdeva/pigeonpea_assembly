#!/bin/bash
###############################################################################
# BUSCO Analysis for Reference Genome Quality Assessment
# The smae script is used for all the genotypes
# Description:
# This script runs BUSCO to evaluate the completeness of a pigeonpea
# reference genome assembly using the Fabales lineage dataset.
#
# BUSCO (Benchmarking Universal Single-Copy Orthologs) assesses genome
# completeness based on evolutionarily conserved genes.
#AUTHOR:MUSKAN
#
# Platform:
#   - Linux workstation / server
#
# Input:
#   - Genome assembly FASTA file
#
# Output:
#   - BUSCO summary statistics
#   - Full BUSCO result directory containing gene predictions and logs
#
# Author: Muskan Sachdeva
###############################################################################

############################
# RUN BUSCO
############################

busco \
  -i /media/muskan_sachdeva/OneTouch/Final_Gapfilled_PPgenome_8FLcontigs.fa \
  -m genome \
  -l fabales_odb10 \
  -o reference_busco \
  --out_path /media/muskan_sachdeva/731ce21c-4aa8-4f7d-bfcf-bd1600c77ffe/muskan/busco_results \
  -c 18

############################
# PARAMETERS EXPLAINED:
#
# -i        Input genome assembly (FASTA format)
# -m        Analysis mode set to 'genome'
# -l        BUSCO lineage dataset (fabales_odb10)
# -o        Output folder name
# --out_path Directory where BUSCO results will be written
# -c        Number of CPU threads used
#
# The Fabales lineage is appropriate for legume genomes,
# including Cajanus cajan (pigeonpea).
############################

############################
# END OF SCRIPT
############################
