#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_27
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts27.%j.out
#SBATCH --output=out_counts27.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_BG10_S212.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG10_S212.tab
SAMBaseCounts.pl -i filtered_BOGR_BG11_S213.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG11_S213.tab
SAMBaseCounts.pl -i filtered_BOGR_BG12_S214.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG12_S214.tab
SAMBaseCounts.pl -i filtered_BOGR_BG13_S215.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG13_S215.tab
SAMBaseCounts.pl -i filtered_BOGR_BG14_S216.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG14_S216.tab
SAMBaseCounts.pl -i filtered_BOGR_BG15_S217.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG15_S217.tab
SAMBaseCounts.pl -i filtered_BOGR_BG16_S218.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG16_S218.tab
SAMBaseCounts.pl -i filtered_BOGR_BG17_S219.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_BG17_S219.tab
