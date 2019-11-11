#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_32
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align32.%j.out
#SBATCH --output=out_align32.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=4


# Written by:	 Ava Hoffman
# Date:		     19 July 2018
# Purpose: 	    make a normalized expression matrix

# purge all existing modules
module purge

# load any modules needed to run your program  
module load jdk/1.8.0

# Set paths
export PATH=$PATH:/projects/hoffmana@colostate.edu/bbmap
export PATH=$PATH:/projects/hoffmana@colostate.edu/2bRAD_utilities/scripts
export PATH=$PATH:/projects/hoffmana@colostate.edu/SHRiMP_2_2_3/bin
export PATH=$PATH:/projects/hoffmana@colostate.edu/cd-hit-v4.6.8-2017-1208
export PATH=$PATH:/projects/hoffmana@colostate.edu/standard-RAxML
export PATH=$PATH:/projects/hoffmana@colostate.edu/cd-hit-v4.6.8-2017-1208
export PATH=$PATH:/projects/hoffmana@colostate.edu/BGC


#########
# Alignments & Basecalls
## Run time 03:16:41


gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST01_S152_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST01_S152.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST02_S153_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST02_S153.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST03_S154_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST03_S154.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST04_S155_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST04_S155.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST05_S156_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST05_S156.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST06_S157_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST06_S157.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST07_S158_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST07_S158.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST08_S159_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST08_S159.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST09_S160_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_ST09_S160.sam

SAMFilter.pl -i gmapper_BOGR_ST01_S152.sam -m 32 -o filtered_BOGR_ST01_S152.sam
SAMFilter.pl -i gmapper_BOGR_ST02_S153.sam -m 32 -o filtered_BOGR_ST02_S153.sam
SAMFilter.pl -i gmapper_BOGR_ST03_S154.sam -m 32 -o filtered_BOGR_ST03_S154.sam
SAMFilter.pl -i gmapper_BOGR_ST04_S155.sam -m 32 -o filtered_BOGR_ST04_S155.sam
SAMFilter.pl -i gmapper_BOGR_ST05_S156.sam -m 32 -o filtered_BOGR_ST05_S156.sam
SAMFilter.pl -i gmapper_BOGR_ST06_S157.sam -m 32 -o filtered_BOGR_ST06_S157.sam
SAMFilter.pl -i gmapper_BOGR_ST07_S158.sam -m 32 -o filtered_BOGR_ST07_S158.sam
SAMFilter.pl -i gmapper_BOGR_ST08_S159.sam -m 32 -o filtered_BOGR_ST08_S159.sam
SAMFilter.pl -i gmapper_BOGR_ST09_S160.sam -m 32 -o filtered_BOGR_ST09_S160.sam
