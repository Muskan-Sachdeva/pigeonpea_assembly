#sgs.fofn file
# sgs.fofn = Short-read (Second Generation Sequencing) File Of File Names
# This file contains the full paths to Illumina paired-end FASTQ files
# used by NextPolish for short-read-based genome polishing.
# Each line in sgs.fofn points to one FASTQ file (R1 and R2).
nano sgs.fofn
/exports/eddie/scratch/s2907620/cutadapt/trimmed_NS_PP87_R1.fastq.gz
/exports/eddie/scratch/s2907620/cutadapt/trimmed_NS_PP87_R2.fastq.gz

 #cfg file
# ===============================================================
# NextPolish Configuration File
# Purpose: Polish a draft genome assembly using Illumina short reads
# Tool: NextPolish
# Input genome: Racon-polished assembly (ONT-based)
# Polishing strategy: Best mode (automatic multi-round polishing)

[General]
job_type = local
job_prefix = nextpolish

# Polishing task: best = automatically selects the best polishing strategy
task = best
rewrite = yes
rerun = 3
multithread_jobs = 32
genome = /exports/eddie/scratch/s2907620/alignment_racon/NSPP_87/polished_NSPP_87.fasta
genome_size = 770m
workdir = /exports/eddie/scratch/s2907620/nextpolish_results/NSPP_87
polish_options = -p {multithread_jobs}

# Options for short-read polishing:
# -max_depth 100 : limit maximum read depth
# -bwa          : use BWA for short-read alignment
[sgs_option]
sgs_fofn = ./sgs.fofn
sgs_options = -max_depth 100 -bwa


#Script to run NextPolish on an HPC cluster (Grid Engine)
#!/bin/bash
# Grid Engine options
#$ -N nextpolish_NSPP_87       # Job name
#$ -cwd                        # Run in current working directory
#$ -l h_rt=24:00:00            # Runtime limit of 24 hours
#$ -pe sharedmem 16            # Request 16 CPU cores
#$ -l h_vmem=19G               # Memory per core (16 × 19 GB = 304 GB total)

# Initialise environment
. /etc/profile.d/modules.sh
# Load Miniforge for Conda environment management
module load miniforge

# Enable conda in non-interactive shell
eval "$(conda shell.bash hook)"
conda activate hifiasm

# Path to NextPolish (optional, if not in PATH)
NEXT_POLISH=$CONDA_PREFIX/bin/nextPolish

# Run NextPolish with config file
python $NEXT_POLISH NSPP_87_run.cfg
# or just:
# nextPolish NSPP_87_run.cfg
