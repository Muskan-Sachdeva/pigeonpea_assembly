#!/bin/bash
#$ -N interproscan_test
#$ -cwd
#$ -l h_rt=04:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=12G

module load java
source activate interproscan

./interproscan.sh \
-i test_proteins.fasta \
-f tsv \
-cpu 16
