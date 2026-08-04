#################################################################################################################
##cutesv script to call structural variants from raw reads
##Author: Muskan
#################################################################################################################
#!/bin/bash
# Grid Engine options
#$ -N cutesv_3C                  # Job name
#$ -cwd                             # Run in current working directory
#$ -l h_rt=48:00:00                 # Runtime limit of 24 hours
#$ -pe sharedmem 16                 # Request 16 CPU cores
#$ -l h_vmem=12G                    # Memory per core (16 × 12 GB = 192 GB total)
#$ -j y                               # Join stdout and stderr
#$ -o cutesv_3C.log                  # Log file


# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate cutesv

cuteSV \
/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/minimap/NSPP_3C/NSPP_3C_filtered_sorted.bam \
/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/reference/reference.fa \
/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/cutesv/NSPP_3C/NSPP_3C_cutesv.vcf \
/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/cutesv/NSPP_3C \
-p -1 \
-q 30 \
-r 500 \
-md 200 \
-mi 200