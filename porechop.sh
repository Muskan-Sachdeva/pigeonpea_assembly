#!/bin/bash
# The same script used for all the genotypes
# Script: porechop_ont_adapter_trimming.sh
# Purpose: Adapter trimming and chimera removal for Oxford Nanopore (ONT) long-read data
# Tool: Porechop
#Author: MUSKAN
# Input: Raw ONT FASTQ file
# Output: Adapter-trimmed FASTQ file suitable for genome assembly
#
# Notes:
# - Porechop trims sequencing adapters from ONT reads
# - --discard_middle removes chimeric reads containing internal adapters
# - This script is suitable for long-read genome assembly workflows
#

# -------------------------------
# Input FASTQ file (ONT reads)
# -------------------------------
INPUT_FASTQ="/tmp/muskan/Fastq/SO_12802_NSPP_3C_barcode13.fastq"

# -------------------------------
# Output FASTQ file (trimmed reads)
# -------------------------------
OUTPUT_FASTQ="/tmp/muskan/porechop/NSPP_3C_trimmed.fastq"

# -------------------------------
# Run Porechop
# -------------------------------
porechop \
  -i ${INPUT_FASTQ} \
  -o ${OUTPUT_FASTQ} \
  --threads 32 \
  --adapter_threshold 95 \
  --discard_middle
