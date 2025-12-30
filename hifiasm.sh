#!/bin/bash
###############################################################################
# Script: hifiasm_assembly_NSPP_50.sh
# Purpose: Genome assembly of NSPP_50 using Hifiasm (ONT long reads)
# Platform: Linux / HPC cluster
#
# Description:
# This script assembles Oxford Nanopore reads of NSPP_50 genotype using Hifiasm,
# then converts the contig GFA output to a FASTA file for downstream analyses
# such as read mapping, repeat annotation, and genome polishing.
#
# Notes:
# - This script can be used for multiple genotypes by updating input/output paths.
# - Ensure Hifiasm is installed in the activated environment.
###############################################################################

############################
# Input parameters
############################

# Path to input ONT reads (FASTQ, gzipped)
ONT_READS="/exports/eddie/scratch/s2907620/SO_12802_NSPP_3C_barcode13.fastq.gz"

# Output directory for Hifiasm assembly
OUT_DIR="/exports/eddie/scratch/s2907620/hifiasm_output"
mkdir -p $OUT_DIR

# Base name for Hifiasm output files
ASM_PREFIX="$OUT_DIR/NSPP_50_assembly"

############################
# Step 1: Run Hifiasm genome assembler
############################

# -t 32 : use 32 threads
# --ont : input is Oxford Nanopore reads
# -o    : output prefix
hifiasm -t 32 --ont -o $ASM_PREFIX $ONT_READS

############################
# Step 2: Convert GFA contigs to FASTA
############################

# The contig file produced by Hifiasm: NSPP_50_assembly.asm.bp.p_ctg.gfa
# AWK command extracts contig sequences into standard FASTA format
awk '/^S/{print ">"$2"\n"$3}' "${ASM_PREFIX}.asm.bp.p_ctg.gfa" > "${ASM_PREFIX}.fasta"

###############################################################################
# End of script
###############################################################################
