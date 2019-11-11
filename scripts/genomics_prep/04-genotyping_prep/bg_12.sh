#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_12
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts12.%j.out
#SBATCH --output=out_counts12.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_RM01_S35.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM01_S35.tab
SAMBaseCounts.pl -i filtered_BOGR_RM02_S36.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM02_S36.tab
SAMBaseCounts.pl -i filtered_BOGR_RM03_S37.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM03_S37.tab
SAMBaseCounts.pl -i filtered_BOGR_RM04_S38.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM04_S38.tab
SAMBaseCounts.pl -i filtered_BOGR_RM05_S39.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM05_S39.tab
SAMBaseCounts.pl -i filtered_BOGR_RM06_S40.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM06_S40.tab
SAMBaseCounts.pl -i filtered_BOGR_RM07_S41.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM07_S41.tab
SAMBaseCounts.pl -i filtered_BOGR_RM08_S42.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM08_S42.tab
SAMBaseCounts.pl -i filtered_BOGR_RM09_S43.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RM09_S43.tab
