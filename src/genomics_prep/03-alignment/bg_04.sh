#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_04
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align04.%j.out
#SBATCH --output=out_align04.%j.out
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
## Run time 04:16:55

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_8_4_1-116A_S432_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_8_4_1-116A_S432.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_8_5_1-116B_S433_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_8_5_1-116B_S433.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_1_1-116C_S434_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_1_1-116C_S434.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_1_2-116D_S435_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_1_2-116D_S435.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_1_3-116E_S436_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_1_3-116E_S436.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_2_1-116F_S437_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_2_1-116F_S437.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_3_1-116G_S438_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_3_1-116G_S438.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_4_1-116H_S439_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_4_1-116H_S439.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_9_5_1-117A_S440_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_Bgedge_9_5_1-117A_S440.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_1_1-117H_S447_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_1_1_1-117H_S447.sam 

SAMFilter.pl -i gmapper_Bgedge_8_4_1-116A_S432.sam -m 32 -o filtered_Bgedge_8_4_1-116A_S432.sam
SAMFilter.pl -i gmapper_Bgedge_8_5_1-116B_S433.sam -m 32 -o filtered_Bgedge_8_5_1-116B_S433.sam
SAMFilter.pl -i gmapper_Bgedge_9_1_1-116C_S434.sam -m 32 -o filtered_Bgedge_9_1_1-116C_S434.sam
SAMFilter.pl -i gmapper_Bgedge_9_1_2-116D_S435.sam -m 32 -o filtered_Bgedge_9_1_2-116D_S435.sam
SAMFilter.pl -i gmapper_Bgedge_9_1_3-116E_S436.sam -m 32 -o filtered_Bgedge_9_1_3-116E_S436.sam
SAMFilter.pl -i gmapper_Bgedge_9_2_1-116F_S437.sam -m 32 -o filtered_Bgedge_9_2_1-116F_S437.sam
SAMFilter.pl -i gmapper_Bgedge_9_3_1-116G_S438.sam -m 32 -o filtered_Bgedge_9_3_1-116G_S438.sam
SAMFilter.pl -i gmapper_Bgedge_9_4_1-116H_S439.sam -m 32 -o filtered_Bgedge_9_4_1-116H_S439.sam
SAMFilter.pl -i gmapper_Bgedge_9_5_1-117A_S440.sam -m 32 -o filtered_Bgedge_9_5_1-117A_S440.sam
SAMFilter.pl -i gmapper_BgHq_1_1_1-117H_S447.sam -m 32 -o filtered_BgHq_1_1_1-117H_S447.sam
