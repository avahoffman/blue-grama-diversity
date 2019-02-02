#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_30
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align30.%j.out
#SBATCH --output=out_align30.%j.out
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
## Run time 03:22:10

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO01_S186_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO01_S186.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO02_S187_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO02_S187.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO03_S188_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO03_S188.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO04_S189_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO04_S189.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO05_S190_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO05_S190.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO06_S191_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO06_S191.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO07_S192_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO07_S192.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO08_S193_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO08_S193.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO09_S194_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_CO09_S194.sam

SAMFilter.pl -i gmapper_BOGR_CO01_S186.sam -m 32 -o filtered_BOGR_CO01_S186.sam
SAMFilter.pl -i gmapper_BOGR_CO02_S187.sam -m 32 -o filtered_BOGR_CO02_S187.sam
SAMFilter.pl -i gmapper_BOGR_CO03_S188.sam -m 32 -o filtered_BOGR_CO03_S188.sam
SAMFilter.pl -i gmapper_BOGR_CO04_S189.sam -m 32 -o filtered_BOGR_CO04_S189.sam
SAMFilter.pl -i gmapper_BOGR_CO05_S190.sam -m 32 -o filtered_BOGR_CO05_S190.sam
SAMFilter.pl -i gmapper_BOGR_CO06_S191.sam -m 32 -o filtered_BOGR_CO06_S191.sam
SAMFilter.pl -i gmapper_BOGR_CO07_S192.sam -m 32 -o filtered_BOGR_CO07_S192.sam
SAMFilter.pl -i gmapper_BOGR_CO08_S193.sam -m 32 -o filtered_BOGR_CO08_S193.sam
SAMFilter.pl -i gmapper_BOGR_CO09_S194.sam -m 32 -o filtered_BOGR_CO09_S194.sam
