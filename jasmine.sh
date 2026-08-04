##jasmine_run
##
##script for jasmine run to merge the output of 3 tools svim, sniffles and cutesv
##content of jasmine_file_list.txt file
#/home/s2907620/pigeonpea_project/sniffles/NSPP_3C/filtered_mapq30/NSPP_3C_filtered.vcf
#/home/s2907620/pigeonpea_project/cutesv/NSPP_3C/filtered_mapq_30/NSPP_3C_cutesv_filtered.vcf
#/home/s2907620/pigeonpea_project/svim/svim/NSPP_3C/NSPP_3C/svim_pass_50bp.vcf

#!/bin/bash
# Grid Engine options
#$ -N jasmine_3C
#$ -cwd
#$ -l h_rt=48:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=12G
#$ -j y
#$ -o jasmine_3C.log

# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
/exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/jasmine

jasmine \
    file_list=/home/s2907620/pigeonpea_project/jasmine/NSPP_3C/NSPP_3C_jasmine_file_list.txt \
    out_file=/home/s2907620/pigeonpea_project/jasmine/NSPP_3C/output_3_tools/pigeonpea_3_merged_highconf.vcf \
    threads=16 \
    max_dist=200 \
    min_support=2 \
    --spec_len_diff=0.2 \
    --output_genotypes \
    --centroid_merging \
    --ignore_strand

