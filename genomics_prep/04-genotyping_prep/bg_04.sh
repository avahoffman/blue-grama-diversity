#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_04
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts04.%j.out
#SBATCH --output=out_counts04.%j.out
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

SAMBaseCounts.pl -i filtered_Bgedge_8_4_1-116A_S432.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_8_4_1-116A_S432.tab
SAMBaseCounts.pl -i filtered_Bgedge_8_5_1-116B_S433.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_8_5_1-116B_S433.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_1_1-116C_S434.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_1_1-116C_S434.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_1_2-116D_S435.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_1_2-116D_S435.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_1_3-116E_S436.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_1_3-116E_S436.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_2_1-116F_S437.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_2_1-116F_S437.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_3_1-116G_S438.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_3_1-116G_S438.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_4_1-116H_S439.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_4_1-116H_S439.tab
SAMBaseCounts.pl -i filtered_Bgedge_9_5_1-117A_S440.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_9_5_1-117A_S440.tab
SAMBaseCounts.pl -i filtered_BgHq_1_1_1-117H_S447.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_1_1-117H_S447.tab
