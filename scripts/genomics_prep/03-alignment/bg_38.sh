#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_38
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align38.%j.out
#SBATCH --output=out_align38.%j.out
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
## Run time 02:36:42

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ01_S254_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ01_S254.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ02_S255_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ02_S255.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ03_S256_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ03_S256.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ04_S257_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ04_S257.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ05_S258_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ05_S258.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ06_S259_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ06_S259.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ07_S260_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ07_S260.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ08_S261_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ08_S261.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ09_S262_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ09_S262.sam

SAMFilter.pl -i gmapper_BOGR_KNZ01_S254.sam -m 32 -o filtered_BOGR_KNZ01_S254.sam
SAMFilter.pl -i gmapper_BOGR_KNZ02_S255.sam -m 32 -o filtered_BOGR_KNZ02_S255.sam
SAMFilter.pl -i gmapper_BOGR_KNZ03_S256.sam -m 32 -o filtered_BOGR_KNZ03_S256.sam
SAMFilter.pl -i gmapper_BOGR_KNZ04_S257.sam -m 32 -o filtered_BOGR_KNZ04_S257.sam
SAMFilter.pl -i gmapper_BOGR_KNZ05_S258.sam -m 32 -o filtered_BOGR_KNZ05_S258.sam
SAMFilter.pl -i gmapper_BOGR_KNZ06_S259.sam -m 32 -o filtered_BOGR_KNZ06_S259.sam
SAMFilter.pl -i gmapper_BOGR_KNZ07_S260.sam -m 32 -o filtered_BOGR_KNZ07_S260.sam
SAMFilter.pl -i gmapper_BOGR_KNZ08_S261.sam -m 32 -o filtered_BOGR_KNZ08_S261.sam
SAMFilter.pl -i gmapper_BOGR_KNZ09_S262.sam -m 32 -o filtered_BOGR_KNZ09_S262.sam
