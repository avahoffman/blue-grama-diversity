#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_24
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts24.%j.out
#SBATCH --output=out_counts24.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=2


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

SAMBaseCounts.pl -i filtered_BOGR_SGS01_S85.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS01_S85.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS02_S86.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS02_S86.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS03_S87.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS03_S87.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS04_S88.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS04_S88.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS05_S89.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS05_S89.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS06_S90.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS06_S90.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS07_S91.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS07_S91.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS08_S92.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS08_S92.tab
SAMBaseCounts.pl -i filtered_BOGR_SGS09_S93.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_SGS09_S93.tab