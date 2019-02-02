#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_24
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align24.%j.out
#SBATCH --output=out_align24.%j.out
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
## Run time 03:22:11

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS01_S85_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS01_S85.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS02_S86_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS02_S86.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS03_S87_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS03_S87.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS04_S88_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS04_S88.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS05_S89_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS05_S89.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS06_S90_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS06_S90.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS07_S91_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS07_S91.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS08_S92_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS08_S92.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS09_S93_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS09_S93.sam

SAMFilter.pl -i gmapper_BOGR_SGS01_S85.sam -m 32 -o filtered_BOGR_SGS01_S85.sam
SAMFilter.pl -i gmapper_BOGR_SGS02_S86.sam -m 32 -o filtered_BOGR_SGS02_S86.sam
SAMFilter.pl -i gmapper_BOGR_SGS03_S87.sam -m 32 -o filtered_BOGR_SGS03_S87.sam
SAMFilter.pl -i gmapper_BOGR_SGS04_S88.sam -m 32 -o filtered_BOGR_SGS04_S88.sam
SAMFilter.pl -i gmapper_BOGR_SGS05_S89.sam -m 32 -o filtered_BOGR_SGS05_S89.sam
SAMFilter.pl -i gmapper_BOGR_SGS06_S90.sam -m 32 -o filtered_BOGR_SGS06_S90.sam
SAMFilter.pl -i gmapper_BOGR_SGS07_S91.sam -m 32 -o filtered_BOGR_SGS07_S91.sam
SAMFilter.pl -i gmapper_BOGR_SGS08_S92.sam -m 32 -o filtered_BOGR_SGS08_S92.sam
SAMFilter.pl -i gmapper_BOGR_SGS09_S93.sam -m 32 -o filtered_BOGR_SGS09_S93.sam