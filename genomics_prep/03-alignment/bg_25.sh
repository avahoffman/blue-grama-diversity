#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_25
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align25.%j.out
#SBATCH --output=out_align25.%j.out
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
##  Run time 03:41:45

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS10_S94_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS10_S94.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS11_S95_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS11_S95.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS12_S96_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS12_S96.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS13_S97_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS13_S97.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS14_S98_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS14_S98.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS15_S99_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS15_S99.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS16_S100_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS16_S100.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS17_S101_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SGS17_S101.sam

SAMFilter.pl -i gmapper_BOGR_SGS10_S94.sam -m 32 -o filtered_BOGR_SGS10_S94.sam
SAMFilter.pl -i gmapper_BOGR_SGS11_S95.sam -m 32 -o filtered_BOGR_SGS11_S95.sam
SAMFilter.pl -i gmapper_BOGR_SGS12_S96.sam -m 32 -o filtered_BOGR_SGS12_S96.sam
SAMFilter.pl -i gmapper_BOGR_SGS13_S97.sam -m 32 -o filtered_BOGR_SGS13_S97.sam
SAMFilter.pl -i gmapper_BOGR_SGS14_S98.sam -m 32 -o filtered_BOGR_SGS14_S98.sam
SAMFilter.pl -i gmapper_BOGR_SGS15_S99.sam -m 32 -o filtered_BOGR_SGS15_S99.sam
SAMFilter.pl -i gmapper_BOGR_SGS16_S100.sam -m 32 -o filtered_BOGR_SGS16_S100.sam
SAMFilter.pl -i gmapper_BOGR_SGS17_S101.sam -m 32 -o filtered_BOGR_SGS17_S101.sam