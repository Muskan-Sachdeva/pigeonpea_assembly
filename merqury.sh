#!/bin/bash
###############################################################################
# Merqury Assembly Quality Evaluation using k-mer Analysis
#
# Description:
# This script runs Merqury to assess the quality of a pigeonpea genome
# assembly using k-mer spectra derived from sequencing reads.
#
# Merqury evaluates:
#   - Assembly completeness
#   - Consensus quality (QV)
#   - k-mer copy number consistency
#
# Platform:
#   - Eddie HPC (SGE scheduler)
#
# Input:
#   1. Meryl k-mer database generated from sequencing reads
#   2. Genome assembly FASTA file
#
# Output:
#   - Merqury reports, plots, and QV estimates
#
# Author: Muskan Sachdeva
###############################################################################

############################
# SGE JOB CONFIGURATION
############################
#$ -N merqury_NSPP50_job          # Job name
#$ -cwd                          # Run job from current directory
#$ -l h_rt=24:00:00              # Maximum runtime (24 hours)
#$ -pe sharedmem 16              # Number of CPU cores requested
#$ -l h_vmem=19G                 # Memory per core

############################
# LOAD MODULES & ENVIRONMENT
############################

# Initialise module system
. /etc/profile.d/modules.sh

# Load conda/miniforge module
module load miniforge

# Activate conda environment containing Merqury
conda activate hifiasm

############################
# OUTPUT DIRECTORY SETUP
############################

# Create output directory for Merqury results
mkdir -p /exports/eddie/scratch/s2907620/merqury_out/NSPP_50_new

############################
# RUN MERQURY
############################

merqury.sh \
  /exports/eddie/scratch/s2907620/meryl_database/reads.k21.meryl \
  /exports/eddie/scratch/s2907620/hifiasm_results/NSPP_50/NSPP_50_assembly.fasta \
  /exports/eddie/scratch/s2907620/merqury_out/NSPP_50_new

############################
# PARAMETERS EXPLAINED:
#
# Input 1:
#   Meryl k-mer database generated from raw sequencing reads (k=21)
#
# Input 2:
#   Genome assembly FASTA file to be evaluated
#
# Input 3:
#   Output directory for Merqury results
#
# Merqury compares k-mers from the reads against the assembly to estimate
# consensus accuracy (QV) and detect missing or erroneous regions.
############################

