#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_02
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts02.%j.out
#SBATCH --output=out_counts02.%j.out
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

SAMBaseCounts.pl -i filtered_Bgedge_1_5_1-114C_S418.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_5_1-114C_S418.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_1_1-117B_S441.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_1_1-117B_S441.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_2_1-117C_S442.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_2_1-117C_S442.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_3_1-117D_S443.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_3_1-117D_S443.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_4_1-117E_S444.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_4_1-117E_S444.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_5_1-117F_S445.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_5_1-117F_S445.tab
SAMBaseCounts.pl -i filtered_Bgedge_10_6_1-117G_S446.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_10_6_1-117G_S446.tab
SAMBaseCounts.pl -i filtered_Bgedge_2_1_1-114D_S419.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_2_1_1-114D_S419.tab
SAMBaseCounts.pl -i filtered_Bgedge_2_2_1-114E_S420.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_2_2_1-114E_S420.tab
SAMBaseCounts.pl -i filtered_Bgedge_2_3_1-114F_S421.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_2_3_1-114F_S421.tab
