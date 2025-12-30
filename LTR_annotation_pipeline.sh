#!/bin/bash
###############################################################################
# LTR Retrotransposon Identification and Integration Pipeline (NSPP_3C)
#
# Description:
# This script performs LTR retrotransposon identification for the
# NSPP_3C pigeonpea genome using:
#   1. LTRharvest
#   2. LTR_FINDER_parallel
#   3. LTR_retriever
#
# The curated LTR library is then combined with RepeatModeler output
# and deduplicated using CD-HIT to generate a non-redundant repeat library.
#
# Platform:
#   - Eddie HPC (SGE scheduler)
#
###############################################################################
# PART 1: LTRharvest
###############################################################################

#$ -N harvest_3C
#$ -cwd
#$ -l h_rt=12:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=20G
#$ -j y
#$ -o harvest_3C.log

# Initialise module system and environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate repeat

# Run LTRharvest on pre-built suffix array index
gt ltrharvest \
  -index /exports/eddie/scratch/s2907620/ltr/harvest_db/NSPP_3C/NSPP_3C \
  -seqids yes \
  -minlenltr 100 \
  -maxlenltr 7000 \
  > /exports/eddie/scratch/s2907620/ltr/ltr_harvest/NSPP_3C/NSPP_3C_ltrharvest.out

###############################################################################
# PART 2: LTR_FINDER_parallel
###############################################################################

#$ -N finder_3C
#$ -cwd
#$ -l h_rt=12:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=20G
#$ -j y
#$ -o finder_3C.log

# Initialise module system and environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate repeat

# Run LTR_FINDER in parallel mode
LTR_FINDER_parallel \
  -seq /exports/eddie/scratch/s2907620/ragtag/NSPP_3C/NSPP_3C_scaffold/HY3C_scaffold.fa \
  -threads 16 \
  -size 500000 \
  > /exports/eddie/scratch/s2907620/ltr/LTR_finder/NSPP_3C/NSPP_3C_finder.out

###############################################################################
# PART 3: LTR_retriever (Integrating LTRharvest + LTR_FINDER)
###############################################################################

#$ -N ltr_retriever_3C
#$ -cwd
#$ -l h_rt=12:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=20G
#$ -j y
#$ -o ltr_retriever_3C.log

# Move to LTR_retriever output directory
cd /exports/eddie/scratch/s2907620/ltr/LTR_retriever/NSPP_3C

# Initialise module system and environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate repeat

# Run LTR_retriever to generate high-confidence LTR library
LTR_retriever \
  -genome /exports/eddie/scratch/s2907620/ragtag/NSPP_3C/NSPP_3C_scaffold/HY3C_scaffold.fa \
  -inharvest /exports/eddie/scratch/s2907620/ltr/ltr_harvest/NSPP_3C/NSPP_3C.harvest.scn \
  -infinder /exports/eddie/scratch/s2907620/ltr/LTR_finder/NSPP_3C/HY3C_scaffold.fa.finder.combine.scn \
  -threads 16

###############################################################################
# PART 4: Combine RepeatModeler and LTR_retriever Libraries
###############################################################################

# Concatenate RepeatModeler consensus repeats with curated LTR library
cat \
  /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/consensi.fa.classified \
  /exports/eddie/scratch/s2907620/ltr/LTR_retriever/NSPP_3C/HY3C_scaffold.fa.mod.LTRlib.fa \
  > /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_raw.fa

###############################################################################
# PART 5: Remove Redundancy Using CD-HIT
###############################################################################

# Deduplicate combined repeat library at 95% sequence identity
cd-hit-est \
  -i /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_raw.fa \
  -o /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/final_NSPP_3C_combined_raw_nr.fa \
  -c 0.95 \
  -n 10 \
  -T 16 \
  -M 0


