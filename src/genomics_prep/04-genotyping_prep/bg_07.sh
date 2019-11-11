#!/bin/bash


#SBATCH --time=6:00:00
#SBATCH --job-name=Bg_07
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_counts07.%j.out
#SBATCH --output=out_counts07.%j.out
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

SAMBaseCounts.pl -i filtered_BgHq_9_2_1-1110E_S468.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_2_1-1110E_S468.tab
SAMBaseCounts.pl -i filtered_BgHq_9_2_2-1110F_S469.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_2_2-1110F_S469.tab
SAMBaseCounts.pl -i filtered_BgHq_9_2_3-1110G_S470.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_2_3-1110G_S470.tab
SAMBaseCounts.pl -i filtered_BgHq_9_3_1-1110H_S471.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_3_1-1110H_S471.tab
SAMBaseCounts.pl -i filtered_BgHq_9_4_1-1111B_S472.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_4_1-1111B_S472.tab
SAMBaseCounts.pl -i filtered_BgHq_9_5_1-1111B_S473.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_5_1-1111B_S473.tab
SAMBaseCounts.pl -i filtered_BgHq_9_6_1-1111C_S474.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_6_1-1111C_S474.tab
SAMBaseCounts.pl -i filtered_BgHq_9_7_1-1111D_S475.sam -r /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference.fasta -15 -o basecounts_BgHq_9_7_1-1111D_S475.tab
