#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_05
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts05.%j.out
#SBATCH --output=out_counts05.%j.out
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

SAMBaseCounts.pl -i filtered_BgHq_1_1_2-118A_S448.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_1_2-118A_S448.tab
SAMBaseCounts.pl -i filtered_BgHq_1_1_3-118B_S449.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_1_3-118B_S449.tab
SAMBaseCounts.pl -i filtered_BgHq_1_2_1-118C_S450.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_2_1-118C_S450.tab
SAMBaseCounts.pl -i filtered_BgHq_1_3_1-118D_S451.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_3_1-118D_S451.tab
SAMBaseCounts.pl -i filtered_BgHq_1_4_1-118E_S452.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_1_4_1-118E_S452.tab
SAMBaseCounts.pl -i filtered_BgHq_2_1_1-118F_S453.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_2_1_1-118F_S453.tab
SAMBaseCounts.pl -i filtered_BgHq_2_2_1-118G_S454.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_2_2_1-118G_S454.tab
SAMBaseCounts.pl -i filtered_BgHq_2_3_1-118H_S455.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_2_3_1-118H_S455.tab
SAMBaseCounts.pl -i filtered_BgHq_4_1_1-119A_S456.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_4_1_1-119A_S456.tab
SAMBaseCounts.pl -i filtered_BgHq_4_2_1-119B_S457.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_4_2_1-119B_S457.tab
