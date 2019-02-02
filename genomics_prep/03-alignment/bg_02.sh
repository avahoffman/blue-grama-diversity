#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_02
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align02.%j.out
#SBATCH --output=out_align02.%j.out
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

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_5_1-114C_S418_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_1_5_1-114C_S418.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_1_1-117B_S441_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_1_1-117B_S441.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_2_1-117C_S442_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_2_1-117C_S442.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_3_1-117D_S443_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_3_1-117D_S443.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_4_1-117E_S444_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_4_1-117E_S444.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_5_1-117F_S445_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_5_1-117F_S445.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_10_6_1-117G_S446_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_10_6_1-117G_S446.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_2_1_1-114D_S419_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_2_1_1-114D_S419.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_2_2_1-114E_S420_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_2_2_1-114E_S420.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_2_3_1-114F_S421_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_2_3_1-114F_S421.sam 

SAMFilter.pl -i gmapper_Bgedge_1_5_1-114C_S418.sam -m 32 -o filtered_Bgedge_1_5_1-114C_S418.sam
SAMFilter.pl -i gmapper_Bgedge_10_1_1-117B_S441.sam -m 32 -o filtered_Bgedge_10_1_1-117B_S441.sam
SAMFilter.pl -i gmapper_Bgedge_10_2_1-117C_S442.sam -m 32 -o filtered_Bgedge_10_2_1-117C_S442.sam
SAMFilter.pl -i gmapper_Bgedge_10_3_1-117D_S443.sam -m 32 -o filtered_Bgedge_10_3_1-117D_S443.sam
SAMFilter.pl -i gmapper_Bgedge_10_4_1-117E_S444.sam -m 32 -o filtered_Bgedge_10_4_1-117E_S444.sam
SAMFilter.pl -i gmapper_Bgedge_10_5_1-117F_S445.sam -m 32 -o filtered_Bgedge_10_5_1-117F_S445.sam
SAMFilter.pl -i gmapper_Bgedge_10_6_1-117G_S446.sam -m 32 -o filtered_Bgedge_10_6_1-117G_S446.sam
SAMFilter.pl -i gmapper_Bgedge_2_1_1-114D_S419.sam -m 32 -o filtered_Bgedge_2_1_1-114D_S419.sam
SAMFilter.pl -i gmapper_Bgedge_2_2_1-114E_S420.sam -m 32 -o filtered_Bgedge_2_2_1-114E_S420.sam
SAMFilter.pl -i gmapper_Bgedge_2_3_1-114F_S421.sam -m 32 -o filtered_Bgedge_2_3_1-114F_S421.sam
