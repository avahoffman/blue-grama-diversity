#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_05
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align05.%j.out
#SBATCH --output=out_align05.%j.out
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
## Run time 04:09:28

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_1_2-118A_S448_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_1_2-118A_S448.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_1_3-118B_S449_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_1_3-118B_S449.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_2_1-118C_S450_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_2_1-118C_S450.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_3_1-118D_S451_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_3_1-118D_S451.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_4_1-118E_S452_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_4_1-118E_S452.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_2_1_1-118F_S453_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_2_1_1-118F_S453.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_2_2_1-118G_S454_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_2_2_1-118G_S454.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_2_3_1-118H_S455_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_2_3_1-118H_S455.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_4_1_1-119A_S456_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_4_1_1-119A_S456.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_4_2_1-119B_S457_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_4_2_1-119B_S457.sam 

SAMFilter.pl -i gmapper_BgHq_1_1_2-118A_S448.sam -m 32 -o filtered_BgHq_1_1_2-118A_S448.sam
SAMFilter.pl -i gmapper_BgHq_1_1_3-118B_S449.sam -m 32 -o filtered_BgHq_1_1_3-118B_S449.sam
SAMFilter.pl -i gmapper_BgHq_1_2_1-118C_S450.sam -m 32 -o filtered_BgHq_1_2_1-118C_S450.sam
SAMFilter.pl -i gmapper_BgHq_1_3_1-118D_S451.sam -m 32 -o filtered_BgHq_1_3_1-118D_S451.sam
SAMFilter.pl -i gmapper_BgHq_1_4_1-118E_S452.sam -m 32 -o filtered_BgHq_1_4_1-118E_S452.sam
SAMFilter.pl -i gmapper_BgHq_2_1_1-118F_S453.sam -m 32 -o filtered_BgHq_2_1_1-118F_S453.sam
SAMFilter.pl -i gmapper_BgHq_2_2_1-118G_S454.sam -m 32 -o filtered_BgHq_2_2_1-118G_S454.sam
SAMFilter.pl -i gmapper_BgHq_2_3_1-118H_S455.sam -m 32 -o filtered_BgHq_2_3_1-118H_S455.sam
SAMFilter.pl -i gmapper_BgHq_4_1_1-119A_S456.sam -m 32 -o filtered_BgHq_4_1_1-119A_S456.sam
SAMFilter.pl -i gmapper_BgHq_4_2_1-119B_S457.sam -m 32 -o filtered_BgHq_4_2_1-119B_S457.sam
