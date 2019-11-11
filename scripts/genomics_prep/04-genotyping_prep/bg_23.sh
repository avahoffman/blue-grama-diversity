#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_23
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts23.%j.out
#SBATCH --output=out_counts23.%j.out
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

SAMBaseCounts.pl -i filtered_BOGR_RC10_S144.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC10_S144.tab
SAMBaseCounts.pl -i filtered_BOGR_RC11_S145.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC11_S145.tab
SAMBaseCounts.pl -i filtered_BOGR_RC12_S146.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC12_S146.tab
SAMBaseCounts.pl -i filtered_BOGR_RC13_S147.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC13_S147.tab
SAMBaseCounts.pl -i filtered_BOGR_RC14_S148.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC14_S148.tab
SAMBaseCounts.pl -i filtered_BOGR_RC15_S149.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC15_S149.tab
SAMBaseCounts.pl -i filtered_BOGR_RC16_S150.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC16_S150.tab
SAMBaseCounts.pl -i filtered_BOGR_RC17_S151.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BOGR_RC17_S151.tab
