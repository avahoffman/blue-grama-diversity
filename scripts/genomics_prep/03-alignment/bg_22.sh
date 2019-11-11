#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_22
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align22.%j.out
#SBATCH --output=out_align22.%j.out
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
## Run time 03:59:26

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC01_S135_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC01_S135.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC02_S136_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC02_S136.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC03_S137_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC03_S137.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC04_S138_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC04_S138.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC05_S139_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC05_S139.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC06_S140_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC06_S140.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC07_S141_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC07_S141.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC08_S142_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC08_S142.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC09_S143_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_RC09_S143.sam

SAMFilter.pl -i gmapper_BOGR_RC01_S135.sam -m 32 -o filtered_BOGR_RC01_S135.sam
SAMFilter.pl -i gmapper_BOGR_RC02_S136.sam -m 32 -o filtered_BOGR_RC02_S136.sam
SAMFilter.pl -i gmapper_BOGR_RC03_S137.sam -m 32 -o filtered_BOGR_RC03_S137.sam
SAMFilter.pl -i gmapper_BOGR_RC04_S138.sam -m 32 -o filtered_BOGR_RC04_S138.sam
SAMFilter.pl -i gmapper_BOGR_RC05_S139.sam -m 32 -o filtered_BOGR_RC05_S139.sam
SAMFilter.pl -i gmapper_BOGR_RC06_S140.sam -m 32 -o filtered_BOGR_RC06_S140.sam
SAMFilter.pl -i gmapper_BOGR_RC07_S141.sam -m 32 -o filtered_BOGR_RC07_S141.sam
SAMFilter.pl -i gmapper_BOGR_RC08_S142.sam -m 32 -o filtered_BOGR_RC08_S142.sam
SAMFilter.pl -i gmapper_BOGR_RC09_S143.sam -m 32 -o filtered_BOGR_RC09_S143.sam
