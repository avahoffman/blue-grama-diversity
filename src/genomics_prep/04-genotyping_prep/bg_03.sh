#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_03
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts03.%j.out
#SBATCH --output=out_counts03.%j.out
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

SAMBaseCounts.pl -i filtered_Bgedge_2_4_1-114G_S422.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_2_4_1-114G_S422.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_1_1-114H_S423.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_1_1-114H_S423.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_2_1-115A_S424.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_2_1-115A_S424.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_3_1-115B_S425.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_3_1-115B_S425.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_4_1-115C_S426.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_4_1-115C_S426.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_5_1-115D_S427.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_5_1-115D_S427.tab
SAMBaseCounts.pl -i filtered_Bgedge_4_6_1-115E_S428.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_4_6_1-115E_S428.tab
SAMBaseCounts.pl -i filtered_Bgedge_8_1_1-115F_S429.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_8_1_1-115F_S429.tab
SAMBaseCounts.pl -i filtered_Bgedge_8_2_1-115G_S430.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_8_2_1-115G_S430.tab
SAMBaseCounts.pl -i filtered_Bgedge_8_3_1-115H_S431.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_Bgedge_8_3_1-115H_S431.tab
