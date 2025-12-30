#!/bin/bash
# =============================================================================
# Trim Illumina TruSeq adapters from paired-end reads using Cutadapt
# =============================================================================

# Description:
#   This script trims Illumina TruSeq adapter sequences from paired-end FASTQ 
#   files for multiple pigeonpea genotypes. It also removes low-quality bases 
#   and short reads.
# =============================================================================

# -------------------------
# USAGE:
# -------------------------
# ./trim_adapters.sh <R1_input.fastq.gz> <R2_input.fastq.gz> <output_prefix> <threads>
# Example:
# ./trim_adapters.sh SO_12802_NS_PP87_R1.fastq.gz SO_12802_NS_PP87_R2.fastq.gz first_trimmed_results/trimmed_NS_PP87 18

# -------------------------
# Arguments
# -------------------------
R1_FASTQ=$1   # Input FASTQ R1
R2_FASTQ=$2   # Input FASTQ R2
OUTPUT_PREFIX=$3   # Output prefix for trimmed files


# Create output directory if it doesn't exist
OUTPUT_DIR=$(dirname "$OUTPUT_PREFIX")
mkdir -p "$OUTPUT_DIR"

# -------------------------
# Adapter sequences
# -------------------------
ADAPTER_FWD="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
ADAPTER_REV="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"

# -------------------------
# Run Cutadapt
# -------------------------
cutadapt \
    -a "$ADAPTER_FWD" \
    -A "$ADAPTER_REV" \
    -o "${OUTPUT_PREFIX}_R1.fastq.gz" \
    -p "${OUTPUT_PREFIX}_R2.fastq.gz" \
    "$R1_FASTQ" "$R2_FASTQ" \
    --minimum-length 30 \
    --quality-cutoff 20 \
    --trim-n \
    --overlap 15 \
    --cores="$THREADS"
