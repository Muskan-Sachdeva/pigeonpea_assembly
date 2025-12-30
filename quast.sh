#!/bin/bash
###############################################################################
# QUAST Evaluation of Scaffolded Genome Assemblies
#
# Description:
# This script runs QUAST to assess and compare multiple scaffolded
# pigeonpea genome assemblies against a reference genome.
#
# QUAST provides assembly statistics such as N50, total length,
# number of contigs, misassemblies, and alignment-based metrics.
#
# Platform:
#   - Eddie HPC (SGE scheduler)
#
# Input:
#   - Multiple scaffolded genome assemblies (FASTA)
#   - Reference genome (FASTA)
#
# Output:
#   - QUAST report directory with summary statistics and plots
#
# Author: Muskan Sachdeva
###############################################################################

############################
# SGE JOB CONFIGURATION
############################
#$ -N quast_scaffold              # Job name
#$ -cwd                          # Run in current working directory
#$ -l h_rt=24:00:00              # Maximum runtime (24 hours)
#$ -pe sharedmem 16              # Number of CPU cores requested
#$ -l h_vmem=19G                 # Memory per core
#$ -j y                          # Merge standard output and error
#$ -o quast_scaffold.log         # Log file

############################
# LOAD MODULES & ENVIRONMENT
############################

# Initialise module system
. /etc/profile.d/modules.sh

# Load conda/miniforge module
module load miniforge

# Activate conda environment containing QUAST
conda activate hifiasm

############################
# RUN QUAST
############################

quast.py \
  /exports/eddie/scratch/s2907620/ragtag/NSPP_3C/NSPP_3C_scaffold/HY3C_scaffold.fa \
  /exports/eddie/scratch/s2907620/ragtag/NSPP_50/NSPP_50_scaffold/MC50_scaffold.fa \
  /exports/eddie/scratch/s2907620/ragtag/NSPP_70/NSPP_70_scaffold/MC70_scaffold.fa \
  /exports/eddie/scratch/s2907620/ragtag/NSPP_71/NSPP_71_scaffold/ICPL-13271_scaffold.fa \
  /exports/eddie/scratch/s2907620/ragtag/NSPP_87/NSPP_87_scaffold/ICPL-87_scaffold.fa \
  -r /exports/eddie/scratch/s2907620/reference/reference.fa \
  -o /exports/eddie/scratch/s2907620/quast/scaffold \
  --large \
  --eukaryote

############################
# PARAMETERS EXPLAINED:
#
# Input FASTA files:
#   Scaffolded assemblies from multiple pigeonpea genotypes
#
# -r:
#   Reference genome used for alignment-based evaluation
#
# -o:
#   Output directory for QUAST results
#
# --large:
#   Optimizes QUAST settings for large genome assemblies
#
# --eukaryote:
#   Enables eukaryote-specific gene and assembly metrics
############################

############################
# END OF SCRIPT
############################

