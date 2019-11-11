#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts16.%j.out
#SBATCH --output=out_counts16.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_WR01_S1.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR01_S1.tab
SAMBaseCounts.pl -i filtered_BOGR_WR02_S2.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR02_S2.tab
SAMBaseCounts.pl -i filtered_BOGR_WR03_S3.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR03_S3.tab
SAMBaseCounts.pl -i filtered_BOGR_WR04_S4.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR04_S4.tab
SAMBaseCounts.pl -i filtered_BOGR_WR05_S5.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR05_S5.tab
SAMBaseCounts.pl -i filtered_BOGR_WR06_S6.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR06_S6.tab
SAMBaseCounts.pl -i filtered_BOGR_WR07_S7.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR07_S7.tab
SAMBaseCounts.pl -i filtered_BOGR_WR08_S8.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR08_S8.tab
SAMBaseCounts.pl -i filtered_BOGR_WR09_S9.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_WR09_S9.tab
