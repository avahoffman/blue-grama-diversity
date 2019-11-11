#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align10.%j.out
#SBATCH --output=out_align10.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=48


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
## Run time 11:18:21

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K01_S18_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K01_S18.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K02_S19_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K02_S19.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K03_S20_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K03_S20.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K04_S21_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K04_S21.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K05_S22_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K05_S22.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K06_S23_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K06_S23.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K07_S24_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K07_S24.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K08_S25_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K08_S25.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K09_S26_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K09_S26.sam

SAMFilter.pl -i gmapper_BOGR_K01_S18.sam -m 32 -o filtered_BOGR_K01_S18.sam
SAMFilter.pl -i gmapper_BOGR_K02_S19.sam -m 32 -o filtered_BOGR_K02_S19.sam
SAMFilter.pl -i gmapper_BOGR_K03_S20.sam -m 32 -o filtered_BOGR_K03_S20.sam
SAMFilter.pl -i gmapper_BOGR_K04_S21.sam -m 32 -o filtered_BOGR_K04_S21.sam
SAMFilter.pl -i gmapper_BOGR_K05_S22.sam -m 32 -o filtered_BOGR_K05_S22.sam
SAMFilter.pl -i gmapper_BOGR_K06_S23.sam -m 32 -o filtered_BOGR_K06_S23.sam
SAMFilter.pl -i gmapper_BOGR_K07_S24.sam -m 32 -o filtered_BOGR_K07_S24.sam
SAMFilter.pl -i gmapper_BOGR_K08_S25.sam -m 32 -o filtered_BOGR_K08_S25.sam
SAMFilter.pl -i gmapper_BOGR_K09_S26.sam -m 32 -o filtered_BOGR_K09_S26.sam
