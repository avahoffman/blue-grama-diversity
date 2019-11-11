#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_08
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts08.%j.out
#SBATCH --output=out_counts08.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_A01_S68.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A01_S68.tab
SAMBaseCounts.pl -i filtered_BOGR_A02_S69.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A02_S69.tab
SAMBaseCounts.pl -i filtered_BOGR_A03_S70.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A03_S70.tab
SAMBaseCounts.pl -i filtered_BOGR_A04_S71.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A04_S71.tab
SAMBaseCounts.pl -i filtered_BOGR_A05_S72.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A05_S72.tab
SAMBaseCounts.pl -i filtered_BOGR_A06_S73.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A06_S73.tab
SAMBaseCounts.pl -i filtered_BOGR_A07_S74.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A07_S74.tab
SAMBaseCounts.pl -i filtered_BOGR_A08_S75.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A08_S75.tab
SAMBaseCounts.pl -i filtered_BOGR_A09_S76.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_A09_S76.tab
