conda create -n braker
conda activate braker

module load miniforge

conda install bioconda::braker3

#creating a writable directory for augustus in home directory

mkdir -p ~/augustus_config
cp -r /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/config/ ~/augustus_config/
#export the variable
export AUGUSTUS_CONFIG_PATH=~/augustus_config/config

echo 'export AUGUSTUS_CONFIG_PATH=~/augustus_config/config' >> ~/.bashrc
source ~/.bashrc


# to check braker3 version

braker.pl --version

#installing GeneMark-ETP from google - GeneMark-ES/ET/EP+ ver 4.73_lic for LINUX 64 kernel 3.10 - 5
#output file:  gm_key.gz,  gmes_linux_64_4.tar.gz

#transfering files to Eddie

scp  source_path /destination_path

#gunzip both the files
gunzip gm_key.gz
gunzip gmes_linux_64_4.tar.gz

mv gm_key.gz ~/.gm_key

ls ~/.gm_key

#Unpack GeneMark
mkdir -p /exports/cmvm/eddie/eb/groups/muskan_research/software/genemark
cd /exports/cmvm/eddie/eb/groups/muskan_research/software/genemark

tar xvfz ~/gmes_linux_64_4.tar.gz
# this will create something like 'gmes_linux_64_4/' with gmes_petap.pl inside


conda activate braker
export GENEMARK_PATH=/exports/cmvm/eddie/eb/groups/muskan_research/software/genemark/gmes_linux_64_4
export PATH=$GENEMARK_PATH:$PATH
which gmes_petap.pl


#Make GeneMark Path permanent
echo 'export GENEMARK_PATH=/exports/cmvm/eddie/eb/groups/muskan_research/software/genemark/gmes_linux_64_4' >> ~/.bashrc
echo 'export PATH=$GENEMARK_PATH:$PATH' >> ~/.bashrc



#To check whether GeneMark Installed properly or not

 braker.pl --checkSoftware

#Verify the dependencies of braker3

which braker.pl
which augustus
which gmes_petap.pl
which diamond
which tsebra.py



#catenate all the fasta files of proteins downloaded from ensemble, uniport to make a protein database
cat \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Phytozome/PhytozomeV12/early_release/Carietinum_492_v1.0/annotation/Carietinum_492_v1.0.transcript_primaryTranscriptOnly.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Arabidopsis_thaliana.TAIR10.pep.all.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Cajanus_cajan.C.cajan_V1.0.pep.all.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Glycine_soja.ASM419377v2.pep.all.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Vigna_radiata.Vradiata_ver6.pep.all.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Glycine_max.Glycine_max_v2.1.pep.all.fa \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Cicer_arietinum_pep.fasta \
  /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/envs/braker/Medicago_truncatula.MtrunA17r5.0_ANR.pep.all.fa \
  > pigeonpea_braker_protein_database.fasta

#final script for braker

#!/bin/bash
# Grid Engine options
#$ -N braker_3C                     # Job name
#$ -cwd                            # Run in current working directory
#$ -l h_rt=24:00:00                # Runtime limit
#$ -pe sharedmem 16                # Request CPU cores
#$ -l h_vmem=16G                   # Memory per core
#$ -j y                             # Join stdout and stderr
#$ -o braker_3C.log                  # Log file

# Initialise environment
. /etc/profile.d/modules.sh
module load miniforge
conda activate braker            # Your conda environment

# Ensure output directory exists
mkdir -p /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C_new

cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C_new


braker.pl \
  --genome=/exports/eddie/scratch/s2907620/repeat_masker/terrier_soft_masking/NSPP_3C/ragtag_3C_scaffold_renamed.fasta.masked \
  --prot_seq=/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/protein_database/pigeonpea_braker_protein_database.fasta \
  --species=Cajanus_cajan \
  --softmasking \
  --threads 16 \
  --PROTHINT_PATH=/exports/cmvm/eddie/eb/groups/muskan_research/software/ProtHint/bin \
  --workingdir=/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C_new






 #!/bin/bash
#$ -N braker_50
#$ -cwd
#$ -l h_rt=24:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=16G
#$ -j y
#$ -o braker_50.log

# Activate YOUR conda
source /exports/cmvm/eddie/eb/groups/muskan_research/anaconda/etc/profile.d/conda.sh
conda activate braker

#  Force correct python
export PATH=$CONDA_PREFIX/bin:$PATH

# Output directory
mkdir -p /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C_new
cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_3C_new

# Run BRAKER
braker.pl \
  --genome=/exports/eddie/scratch/s2907620/repeat_masker/terrier_soft_masking/NSPP_3C/ragtag_3C_scaffold_renamed.fasta.masked \
  --prot_seq=/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/protein_database/pigeonpea_braker_protein_database.fasta \
  --species=Cajanus_cajan \
  --softmasking \
  --threads 16 \
  --PROTHINT_PATH=/exports/cmvm/eddie/eb/groups/muskan_research/software/ProtHint/bin \
  --python3_path=$CONDA_PREFIX/bin/python3 \
  --workingdir=$(pwd)



#!/bin/bash
#$ -N braker_70
#$ -cwd
#$ -l h_rt=24:00:00
#$ -pe sharedmem 16
#$ -l h_vmem=16G
#$ -j y
#$ -o braker_70.log

module load miniforge
conda activate braker

export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1

export PATH=$CONDA_PREFIX/bin:$PATH

mkdir -p /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_70_fixed
cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker_output/NSPP_70_fixed

braker.pl \
  --genome=/exports/eddie/scratch/s2907620/repeat_masker/terrier_soft_masking/NSPP_70/ragtag_70_scaffold_renamed.fasta.masked \
  --prot_seq=/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/protein_database/pigeonpea_braker_protein_database.fasta \
  --species=Cajanus_cajan_70 \
  --softmasking \
  --threads 32 \
  --PROTHINT_PATH=/exports/cmvm/eddie/eb/groups/muskan_research/software/ProtHint/bin \
  --python3_path=$CONDA_PREFIX/bin/python3 \
  --workingdir=$(pwd)
