#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_38
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts38.%j.out
#SBATCH --output=out_counts38.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_KNZ01_S254.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ01_S254.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ02_S255.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ02_S255.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ03_S256.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ03_S256.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ04_S257.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ04_S257.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ05_S258.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ05_S258.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ06_S259.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ06_S259.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ07_S260.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ07_S260.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ08_S261.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ08_S261.tab
SAMBaseCounts.pl -i filtered_BOGR_KNZ09_S262.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_KNZ09_S262.tab
