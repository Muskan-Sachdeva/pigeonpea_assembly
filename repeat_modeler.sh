#!/bin/bash
###############################################################################
# RepeatModeler De Novo Repeat Identification for Pigeonpea Genome
#Author: Muskan
# Description:
# This script runs RepeatModeler to identify de novo repetitive elements
# in the NSPP_50 pigeonpea genome assembly. Two analyses are performed:
#   1. Standard RepeatModeler run with multithreading
#   2. LTR-structure-aware RepeatModeler run
#
# Platform:
#   - Linux 
# Same script use for all the genotypes
# Prerequisites:
#   - Conda environment with RepeatModeler installed
#   - RepeatModeler database created using BuildDatabase
#
############################
# LOAD CONDA ENVIRONMENT
############################

# Initialize conda and activate RepeatModeler environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate repeat

############################
# PATH DEFINITIONS
############################

# Path to RepeatModeler database (created using BuildDatabase)
DATABASE="/media/muskan_sachdeva/731ce21c-4aa8-4f7d-bfcf-bd1600c77ffe/muskan/repeat_DB/NSPP_50/NSPP_50"

############################
# RUN 1: STANDARD REPEATMODELER
############################

# Output directory for standard RepeatModeler run
RESULTS_STD="/media/muskan_sachdeva/731ce21c-4aa8-4f7d-bfcf-bd1600c77ffe/muskan/repeat_modeler/NSPP_50"
mkdir -p "$RESULTS_STD"
cd "$RESULTS_STD"

# Run RepeatModeler using 16 threads and capture logs
RepeatModeler \
  -database "$DATABASE" \
  -threads 16 \
  &> rmod.log

############################
# RUN 2: LTR-STRUCTURE-AWARE REPEATMODELER
############################

# Output directory for LTR-structure-aware run
RESULTS_LTR="/media/muskan_sachdeva/731ce21c-4aa8-4f7d-bfcf-bd1600c77ffe/muskan/repeat_modeler/NSPP_50_LTR"
mkdir -p "$RESULTS_LTR"
cd "$RESULTS_LTR"

# Run RepeatModeler with LTR structural detection enabled
RepeatModeler \
  -database "$DATABASE" \
  -LTRStruct

############################


