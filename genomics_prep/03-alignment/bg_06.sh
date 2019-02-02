#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_06
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align06.%j.out
#SBATCH --output=out_align06.%j.out
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
## Run time 03:59:30

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_4_3_1-119C_S458_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_4_3_1-119C_S458.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_6_1_1-119D_S459_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_6_1_1-119D_S459.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_6_2_1-119E_S460_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_6_2_1-119E_S460.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_6_3_1-119F_S461_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_6_3_1-119F_S461.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_6_4_1-119G_S462_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_6_4_1-119G_S462.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_6_5_1-119H_S463_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_6_5_1-119H_S463.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_7_1_1-1110A_S464_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_7_1_1-1110A_S464.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_7_2_1-1110B_S465_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_7_2_1-1110B_S465.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_7_3_1-1110C_S466_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_7_3_1-1110C_S466.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_1_1-1110D_S467_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_1_1-1110D_S467.sam 

SAMFilter.pl -i gmapper_BgHq_4_3_1-119C_S458.sam -m 32 -o filtered_BgHq_4_3_1-119C_S458.sam
SAMFilter.pl -i gmapper_BgHq_6_1_1-119D_S459.sam -m 32 -o filtered_BgHq_6_1_1-119D_S459.sam
SAMFilter.pl -i gmapper_BgHq_6_2_1-119E_S460.sam -m 32 -o filtered_BgHq_6_2_1-119E_S460.sam
SAMFilter.pl -i gmapper_BgHq_6_3_1-119F_S461.sam -m 32 -o filtered_BgHq_6_3_1-119F_S461.sam
SAMFilter.pl -i gmapper_BgHq_6_4_1-119G_S462.sam -m 32 -o filtered_BgHq_6_4_1-119G_S462.sam
SAMFilter.pl -i gmapper_BgHq_6_5_1-119H_S463.sam -m 32 -o filtered_BgHq_6_5_1-119H_S463.sam
SAMFilter.pl -i gmapper_BgHq_7_1_1-1110A_S464.sam -m 32 -o filtered_BgHq_7_1_1-1110A_S464.sam
SAMFilter.pl -i gmapper_BgHq_7_2_1-1110B_S465.sam -m 32 -o filtered_BgHq_7_2_1-1110B_S465.sam
SAMFilter.pl -i gmapper_BgHq_7_3_1-1110C_S466.sam -m 32 -o filtered_BgHq_7_3_1-1110C_S466.sam
SAMFilter.pl -i gmapper_BgHq_9_1_1-1110D_S467.sam -m 32 -o filtered_BgHq_9_1_1-1110D_S467.sam
