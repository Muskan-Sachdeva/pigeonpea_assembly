## **Overview**
This repository contains a pipeline for functional annotation of pigeonpea protein sequences using [EggNOG-mapper v2](http://eggnog-mapper.embl.de/).  
The pipeline performs:  
- Orthology assignment  
- Functional annotation: COG, GO, KEGG, EC  
- Taxonomy-specific annotation (Viridiplantae)  

###############################################################################
# EggNOG-mapper v2.1.12 functional annotation pipeline
# Pigeonpea (Cajanus cajan) genotypes: NSPP-3C/50/70/71/87
###############################################################################

conda create -n eggnog_new #Creating conda env for eggnog
conda activate eggnog_new
conda install bioconda::eggnog-mapper #Install eggnog using conda 

mkdir /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog
cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog

# Download eggNOG-mapper v5.0.2 database
# MAIN DATABASE: SQLite annotations (COG/GO/KEGG/EC mappings)
wget -c http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.db.gz 

# Download DIAMOND search database: 4.2M orthologous proteins
wget -c http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog_proteins.dmnd.gz


# Download TAXONOMY database: NCBI lineage traversal
wget -c http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.taxa.tar.gz

gunzip eggnog.db.gz
gunzip eggnog_proteins.dmnd.gz
tar -xvf eggnog.taxa.tar


mkdir /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog_results
cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog_results # Output directory 

mkdir NSPP_3C NSPP_50 NSPP_70 NSPP_71 NSPP_87 # Output folders

# Script to run emapper.py

#!/bin/bash
# Grid Engine options
#$ -N eggnog_3C
#$ -cwd
#$ -l h_rt=36:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=64G
#$ -j y
#$ -o eggnog_3C.log

# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate eggnog_new 

emapper.py \
  -i /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C/braker.noStop.aa \ #braker3 output
  -o NSPP_3C \
  -m diamond \
  --cpu 16 \
  --data_dir /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog \   #eggnog database directory
  --output_dir /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/eggnog_results/NSPP_3C \  #output directory
  --tax_scope 33090 \  #tax scope id of viridaeplantae
  --itype proteins \ #type of input file
  
###############################################################################
#END OF THE SCRIPT
###############################################################################
