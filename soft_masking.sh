#!/bin/bash
# Grid Engine options
#$ -N final_mask_3C
#$ -cwd
#$ -l h_rt=24:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=16G
#$ -j y
#$ -o final_mask_3C.log

# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate repeat

# Ensure output directory exists
mkdir -p /exports/eddie/scratch/s2907620/repeat_masker/final_soft_masking/NSPP_3C

# Run RepeatMasker
RepeatMasker \
  -pa 16 \
  -lib /exports/eddie/scratch/s2907620/repeat_GBU/NSPP_3C/combined_repeat_library_NSPP_3C.fa \
  -s \
  -xsmall \
  -gff \
  -dir /exports/eddie/scratch/s2907620/repeat_masker/final_soft_masking/NSPP_3C \
  -engine rmblast \
  /exports/eddie/scratch/s2907620/scaffold_files_syri/clean_NSPP_3C.fasta

