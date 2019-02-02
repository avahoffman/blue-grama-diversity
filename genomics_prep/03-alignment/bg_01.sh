#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_01
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align01.%j.out
#SBATCH --output=out_align01.%j.out
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
# Alignments

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgcultivar_na_1_1-1112E_S476.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgcultivar_na_2_1-1112F_S477.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgcultivar_na_3_1-1112G_S478.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgcultivar_na_4_1-1112H_S479.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_1_1-113E_S412_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_1_1-113E_S412.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_1_2-113F_S413_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_1_2-113F_S413.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_1_3-113G_S414_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_1_3-113G_S414.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_2_1-113H_S415_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_2_1-113H_S415.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_3_1-114A_S416_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_3_1-114A_S416.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_4_1-114B_S417_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_4_1-114B_S417.sam 

SAMFilter.pl -i gmapper_Bgcultivar_na_1_1-1112E_S476.sam -m 32 -o filtered_Bgcultivar_na_1_1-1112E_S476.sam
SAMFilter.pl -i gmapper_Bgcultivar_na_2_1-1112F_S477.sam -m 32 -o filtered_Bgcultivar_na_2_1-1112F_S477.sam
SAMFilter.pl -i gmapper_Bgcultivar_na_3_1-1112G_S478.sam -m 32 -o filtered_Bgcultivar_na_3_1-1112G_S478.sam
SAMFilter.pl -i gmapper_Bgcultivar_na_4_1-1112H_S479.sam -m 32 -o filtered_Bgcultivar_na_4_1-1112H_S479.sam
SAMFilter.pl -i gmapper_Bgedge_1_1_1-113E_S412.sam -m 32 -o filtered_Bgedge_1_1_1-113E_S412.sam
SAMFilter.pl -i gmapper_Bgedge_1_1_2-113F_S413.sam -m 32 -o filtered_Bgedge_1_1_2-113F_S413.sam
SAMFilter.pl -i gmapper_Bgedge_1_1_3-113G_S414.sam -m 32 -o filtered_Bgedge_1_1_3-113G_S414.sam
SAMFilter.pl -i gmapper_Bgedge_1_2_1-113H_S415.sam -m 32 -o filtered_Bgedge_1_2_1-113H_S415.sam
SAMFilter.pl -i gmapper_Bgedge_1_3_1-114A_S416.sam -m 32 -o filtered_Bgedge_1_3_1-114A_S416.sam
SAMFilter.pl -i gmapper_Bgedge_1_4_1-114B_S417.sam -m 32 -o filtered_Bgedge_1_4_1-114B_S417.sam