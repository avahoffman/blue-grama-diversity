#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_07
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align07.%j.out
#SBATCH --output=out_align07.%j.out
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
## Run time 04:18:31

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_2_1-1110E_S468_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_2_1-1110E_S468.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_2_2-1110F_S469_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_2_2-1110F_S469.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_2_3-1110G_S470_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_2_3-1110G_S470.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_3_1-1110H_S471_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_3_1-1110H_S471.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_4_1-1111B_S472_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_4_1-1111B_S472.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_5_1-1111B_S473_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_5_1-1111B_S473.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_6_1-1111C_S474_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_6_1-1111C_S474.sam 
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_9_7_1-1111D_S475_L006_R1_001_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BgHq_9_7_1-1111D_S475.sam 

SAMFilter.pl -i gmapper_BgHq_9_2_1-1110E_S468.sam -m 32 -o filtered_BgHq_9_2_1-1110E_S468.sam 
SAMFilter.pl -i gmapper_BgHq_9_2_2-1110F_S469.sam -m 32 -o filtered_BgHq_9_2_2-1110F_S469.sam
SAMFilter.pl -i gmapper_BgHq_9_2_3-1110G_S470.sam -m 32 -o filtered_BgHq_9_2_3-1110G_S470.sam
SAMFilter.pl -i gmapper_BgHq_9_3_1-1110H_S471.sam -m 32 -o filtered_BgHq_9_3_1-1110H_S471.sam
SAMFilter.pl -i gmapper_BgHq_9_4_1-1111B_S472.sam -m 32 -o filtered_BgHq_9_4_1-1111B_S472.sam
SAMFilter.pl -i gmapper_BgHq_9_5_1-1111B_S473.sam -m 32 -o filtered_BgHq_9_5_1-1111B_S473.sam
SAMFilter.pl -i gmapper_BgHq_9_6_1-1111C_S474.sam -m 32 -o filtered_BgHq_9_6_1-1111C_S474.sam
SAMFilter.pl -i gmapper_BgHq_9_7_1-1111D_S475.sam -m 32 -o filtered_BgHq_9_7_1-1111D_S475.sam
