#Purpose- long read polishing of draft assembled file
#The same script is used for all the genotypes
#Notes: Designed for Grid Engine cluster

#code for minimap2 for the alignment of hifiasm assembly and raw fastq reads, required for the polishing by racon. The same script is used for all the genotypes

#!/bin/bash
# Grid Engine options
#$ -N minimap_50_job              # Job name
#$ -cwd                             # Run in current working directory
#$ -l h_rt=24:00:00                 # Runtime limit of 24 hours
#$ -pe sharedmem 16                 # Request 16 CPU cores
#$ -l h_vmem=19G                    # Memory per core (16 × 19 GB = 304 GB total)

# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate hifiasm

# Run minimap2 with matching threads
minimap2 -ax map-ont -t 16 \
/exports/eddie/scratch/s2907620/hifiasm_results/NSPP_50/NSPP_50_assembly.fasta \
/exports/eddie/scratch/s2907620/Nanopore/SO_12802_NSPP_50_barcode15.fastq.gz \
> /exports/eddie/scratch/s2907620/alignment_racon/NSPP_50/NSPP_50_alignment.sam


#The script is used for racon for the polishing of hifiasm assembly output with the long read raw data and the .sam alignment file.
#!/bin/bash
# Grid Engine options
#$ -N minimap_50_job              # Job name
#$ -cwd                             # Run in current working directory
#$ -l h_rt=24:00:00                 # Runtime limit of 24 hours
#$ -pe sharedmem 16                 # Request 16 CPU cores
#$ -l h_vmem=19G                    # Memory per core (16 × 19 GB = 304 GB total)

racon \
-t 32 \
/tmp/muskan/Fastq/SO_12802_NSPP_50_barcode11.fastq.gz \
/tmp/muskan/alignment_racon/NSPP_50/alignment.sam \
/tmp/muskan/NSPP_70_out/NSPP_50_assembly.fasta \
> /tmp/muskan/alignment_racon/NSPP_50/polished_assembly.fasta


