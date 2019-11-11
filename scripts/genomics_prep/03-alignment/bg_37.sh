#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_37
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align37.%j.out
#SBATCH --output=out_align37.%j.out
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
## Run time 03:07:04

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP10_S280_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP10_S280.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP11_S281_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP11_S281.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP12_S282_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP12_S282.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP13_S283_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP13_S283.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP14_S284_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP14_S284.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP15_S285_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP15_S285.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP16_S286_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP16_S286.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP17_S287_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CP17_S287.sam

SAMFilter.pl -i gmapper_BOGR_CP10_S280.sam -m 32 -o filtered_BOGR_CP10_S280.sam
SAMFilter.pl -i gmapper_BOGR_CP11_S281.sam -m 32 -o filtered_BOGR_CP11_S281.sam
SAMFilter.pl -i gmapper_BOGR_CP12_S282.sam -m 32 -o filtered_BOGR_CP12_S282.sam
SAMFilter.pl -i gmapper_BOGR_CP13_S283.sam -m 32 -o filtered_BOGR_CP13_S283.sam
SAMFilter.pl -i gmapper_BOGR_CP14_S284.sam -m 32 -o filtered_BOGR_CP14_S284.sam
SAMFilter.pl -i gmapper_BOGR_CP15_S285.sam -m 32 -o filtered_BOGR_CP15_S285.sam
SAMFilter.pl -i gmapper_BOGR_CP16_S286.sam -m 32 -o filtered_BOGR_CP16_S286.sam
SAMFilter.pl -i gmapper_BOGR_CP17_S287.sam -m 32 -o filtered_BOGR_CP17_S287.sam
