#!/bin/bash
###############################################################################
# Post-processing of Repeat Libraries (NSPP_3C)
#
# Description:
# This script performs post-processing of repeat libraries by:
#   1. Combining RepeatModeler and LTR_retriever outputs
#   2. Removing redundant repeat sequences using CD-HIT
#   3. Classifying repeats using TErrier
#
# The final output is a non-redundant, classified repeat library suitable
# for RepeatMasker-based genome annotation.
#
# Platform:
#   - Linux / HPC environment
#Author: Muskan
################################################################################
# PART 1: Combine RepeatModeler and LTR_retriever Libraries
###############################################################################

# Concatenate RepeatModeler consensus repeats with curated LTR library
cat \
  /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/consensi.fa.classified \
  /exports/eddie/scratch/s2907620/ltr/LTR_retriever/NSPP_3C/HY3C_scaffold.fa.mod.LTRlib.fa \
  > /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_raw.fa

###############################################################################
# PART 2: Remove Redundant Repeat Sequences using CD-HIT
###############################################################################

# CD-HIT is used to cluster and remove highly similar sequences
# Threshold of 95% identity is commonly used for repeat libraries

cd-hit-est \
  -i /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_raw.fa \
  -o /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_nr.fa \
  -c 0.95 \
  -n 10 \
  -T 16 \
  -M 0

###############################################################################
# PART 3: Repeat Classification using Terrier
###############################################################################

# Terrier is used to classify repeat families and assign TE categories
# Outputs include classified FASTA, CSV summary, and diagnostic plots

terrier \
  --input /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_nr.fa \
  --output-fasta NSPP_3C_terrier_classified.fa \
  --output-csv NSPP_3C_terrier_classifications.csv \
  --batch-size 32 \
  --threads 16

###############################################################################
