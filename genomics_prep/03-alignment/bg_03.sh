#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_03
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align03.%j.out
#SBATCH --output=out_align03.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=4


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

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_2_4_1-114G_S422_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_2_4_1-114G_S422.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_1_1-114H_S423_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_1_1-114H_S423.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_2_1-115A_S424_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_2_1-115A_S424.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_3_1-115B_S425_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_3_1-115B_S425.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_4_1-115C_S426_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_4_1-115C_S426.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_5_1-115D_S427_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_5_1-115D_S427.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_4_6_1-115E_S428_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_4_6_1-115E_S428.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_8_1_1-115F_S429_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_8_1_1-115F_S429.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_8_2_1-115G_S430_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_8_2_1-115G_S430.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_8_3_1-115H_S431_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_8_3_1-115H_S431.sam 

SAMFilter.pl -i gmapper_Bgedge_2_4_1-114G_S422.sam -m 32 -o filtered_Bgedge_2_4_1-114G_S422.sam
SAMFilter.pl -i gmapper_Bgedge_4_1_1-114H_S423.sam -m 32 -o filtered_Bgedge_4_1_1-114H_S423.sam
SAMFilter.pl -i gmapper_Bgedge_4_2_1-115A_S424.sam -m 32 -o filtered_Bgedge_4_2_1-115A_S424.sam
SAMFilter.pl -i gmapper_Bgedge_4_3_1-115B_S425.sam -m 32 -o filtered_Bgedge_4_3_1-115B_S425.sam
SAMFilter.pl -i gmapper_Bgedge_4_4_1-115C_S426.sam -m 32 -o filtered_Bgedge_4_4_1-115C_S426.sam
SAMFilter.pl -i gmapper_Bgedge_4_5_1-115D_S427.sam -m 32 -o filtered_Bgedge_4_5_1-115D_S427.sam
SAMFilter.pl -i gmapper_Bgedge_4_6_1-115E_S428.sam -m 32 -o filtered_Bgedge_4_6_1-115E_S428.sam
SAMFilter.pl -i gmapper_Bgedge_8_1_1-115F_S429.sam -m 32 -o filtered_Bgedge_8_1_1-115F_S429.sam
SAMFilter.pl -i gmapper_Bgedge_8_2_1-115G_S430.sam -m 32 -o filtered_Bgedge_8_2_1-115G_S430.sam
SAMFilter.pl -i gmapper_Bgedge_8_3_1-115H_S431.sam -m 32 -o filtered_Bgedge_8_3_1-115H_S431.sam
