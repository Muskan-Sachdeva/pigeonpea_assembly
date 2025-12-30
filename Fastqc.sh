#!/bin/bash
###############################################################################
# Script: fastqc_illumina_5genotypes.sh
# Purpose: Run FastQC for Illumina paired-end reads of 5 pigeonpea genotypes
# Notes:
# - Generates quality reports for R1 and R2 reads
# - Output goes to separate folders for each read
###############################################################################

# NSPP_3C
fastqc NSPP_3C_R1.fastq.gz -o fastqc_NSPP_3C_R1_output/
fastqc NSPP_3C_R2.fastq.gz -o fastqc_NSPP_3C_R2_output/

# NSPP_50
fastqc NSPP_50_R1.fastq.gz -o fastqc_NSPP_50_R1_output/
fastqc NSPP_50_R2.fastq.gz -o fastqc_NSPP_50_R2_output/

# NSPP_70
fastqc NSPP_70_R1.fastq.gz -o fastqc_NSPP_70_R1_output/
fastqc NSPP_70_R2.fastq.gz -o fastqc_NSPP_70_R2_output/

# NSPP_71
fastqc NSPP_71_R1.fastq.gz -o fastqc_NSPP_71_R1_output/
fastqc NSPP_71_R2.fastq.gz -o fastqc_NSPP_71_R2_output/

# NSPP_87
fastqc NSPP_87_R1.fastq.gz -o fastqc_NSPP_87_R1_output/
fastqc NSPP_87_R2.fastq.gz -o fastqc_NSPP_87_R2_output/
