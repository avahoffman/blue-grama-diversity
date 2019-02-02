#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_06
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts06.%j.out
#SBATCH --output=out_counts06.%j.out
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

SAMBaseCounts.pl -i filtered_BgHq_4_3_1-119C_S458.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_4_3_1-119C_S458.tab
SAMBaseCounts.pl -i filtered_BgHq_6_1_1-119D_S459.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_6_1_1-119D_S459.tab
SAMBaseCounts.pl -i filtered_BgHq_6_2_1-119E_S460.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_6_2_1-119E_S460.tab
SAMBaseCounts.pl -i filtered_BgHq_6_3_1-119F_S461.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_6_3_1-119F_S461.tab
SAMBaseCounts.pl -i filtered_BgHq_6_4_1-119G_S462.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_6_4_1-119G_S462.tab
SAMBaseCounts.pl -i filtered_BgHq_6_5_1-119H_S463.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_6_5_1-119H_S463.tab
SAMBaseCounts.pl -i filtered_BgHq_7_1_1-1110A_S464.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_7_1_1-1110A_S464.tab
SAMBaseCounts.pl -i filtered_BgHq_7_2_1-1110B_S465.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_7_2_1-1110B_S465.tab
SAMBaseCounts.pl -i filtered_BgHq_7_3_1-1110C_S466.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_7_3_1-1110C_S466.tab
SAMBaseCounts.pl -i filtered_BgHq_9_1_1-1110D_S467.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_1_1-1110D_S467.tab
