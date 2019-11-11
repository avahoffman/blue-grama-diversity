#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_01
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts01.%j.out
#SBATCH --output=out_counts01.%j.out
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
# Alignments

SAMBaseCounts.pl -i filtered_Bgcultivar_na_1_1-1112E_S476.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgcultivar_na_1_1-1112E_S476.tab
SAMBaseCounts.pl -i filtered_Bgcultivar_na_2_1-1112F_S477.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgcultivar_na_2_1-1112F_S477.tab
SAMBaseCounts.pl -i filtered_Bgcultivar_na_3_1-1112G_S478.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgcultivar_na_3_1-1112G_S478.tab
SAMBaseCounts.pl -i filtered_Bgcultivar_na_4_1-1112H_S479.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgcultivar_na_4_1-1112H_S479.tab
SAMBaseCounts.pl -i filtered_Bgedge_1_1_1-113E_S412.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_1_1-113E_S412.tab
SAMBaseCounts.pl -i filtered_Bgedge_1_1_2-113F_S413.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_1_2-113F_S413.tab
SAMBaseCounts.pl -i filtered_Bgedge_1_1_3-113G_S414.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_1_3-113G_S414.tab
SAMBaseCounts.pl -i filtered_Bgedge_1_2_1-113H_S415.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_2_1-113H_S415.tab
SAMBaseCounts.pl -i filtered_Bgedge_1_3_1-114A_S416.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_3_1-114A_S416.tab 
SAMBaseCounts.pl -i filtered_Bgedge_1_4_1-114B_S417.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_1_4_1-114B_S417.tab