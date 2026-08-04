#!/bin/bash
#================================================================
# Script: run_nanoplot.sh
# Purpose: Assess Nanopore read quality and calculate N50 using NanoPlot
#AUTHOR: MUSKAN
#================================================================

# Set variables
INPUT_FASTQ=~/Documents/SO_12802_NSPP_87_barcode12.fastq
OUTPUT_DIR=~/Documents/nanoplot_output_NS_87
THREADS=8

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Run NanoPlot
NanoPlot --fastq $INPUT_FASTQ \
         --outdir $OUTPUT_DIR \
         --threads $THREADS \
         --N50

echo "NanoPlot analysis completed. Results are in $OUTPUT_DIR"
