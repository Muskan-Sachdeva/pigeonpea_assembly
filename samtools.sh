#!/bin/bash
###############################################################################
# Script: sam_to_sorted_bam_NSPP_3C.sh
# Purpose: Convert a SAM file to a sorted BAM file and index it using samtools
# Platform: Grid Engine cluster#
# Description:
# This script takes a SAM file generated from genome alignments (e.g., minimap2),
# converts it to BAM format, sorts the BAM file, and creates a BAM index (.bai)
# for downstream analysis such as variant calling, visualization, or synteny analysis.
#
# Notes:
# - Ensure samtools is installed in the activated conda environment
# - Adjust runtime, memory, and CPU cores according to your dataset size
###############################################################################

############################
# SGE Job Configuration
############################
#$ -N bam_3C                   # Job name
#$ -cwd                         # Run in current working directory
#$ -l h_rt=04:00:00             # Maximum runtime (4 hours)
#$ -pe sharedmem 16             # Request 16 CPU cores
#$ -l h_vmem=20G                # Memory per core
#$ -j y                          # Join stdout and stderr
#$ -o bam_3C.log                # Log file

############################
# Load modules and environment
############################
. /etc/profile.d/modules.sh
module load miniforge
conda activate hifiasm          # Conda environment with samtools

############################
# Define input and output paths
############################

# Input SAM file (from genome alignment, e.g., minimap2)
SAM_FILE=/exports/eddie/scratch/s2907620/minimap_syri_output/NSPP_3C_syri.sam

# Output directory for BAM files
OUT_DIR=/exports/eddie/scratch/s2907620/minimap_syri_output/bam_files/NSPP_3C
mkdir -p $OUT_DIR

# Output BAM file path
BAM_FILE=$OUT_DIR/NSPP_3C_syri.bam

############################
# Convert SAM to sorted BAM
############################

# -bS: convert SAM to BAM
# pipe to samtools sort to generate sorted BAM
samtools view -bS $SAM_FILE | samtools sort -o $BAM_FILE

############################
# Index the sorted BAM
############################

# Generates .bai index for fast access by downstream tools
samtools index $BAM_FILE

###############################################################################

