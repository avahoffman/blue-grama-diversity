#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_11
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align11.%j.out
#SBATCH --output=out_align11.%j.out
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
# Run time 01:12:41

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K10_S27_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K10_S27.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K11_S28_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K11_S28.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K12_S29_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K12_S29.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K13_S30_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K13_S30.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K14_S31_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K14_S31.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K15_S32_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K15_S32.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K16_S33_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K16_S33.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K17_S34_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_K17_S34.sam

SAMFilter.pl -i gmapper_BOGR_K10_S27.sam -m 32 -o filtered_BOGR_K10_S27.sam
SAMFilter.pl -i gmapper_BOGR_K11_S28.sam -m 32 -o filtered_BOGR_K11_S28.sam
SAMFilter.pl -i gmapper_BOGR_K12_S29.sam -m 32 -o filtered_BOGR_K12_S29.sam
SAMFilter.pl -i gmapper_BOGR_K13_S30.sam -m 32 -o filtered_BOGR_K13_S30.sam
SAMFilter.pl -i gmapper_BOGR_K14_S31.sam -m 32 -o filtered_BOGR_K14_S31.sam
SAMFilter.pl -i gmapper_BOGR_K15_S32.sam -m 32 -o filtered_BOGR_K15_S32.sam
SAMFilter.pl -i gmapper_BOGR_K16_S33.sam -m 32 -o filtered_BOGR_K16_S33.sam
SAMFilter.pl -i gmapper_BOGR_K17_S34.sam -m 32 -o filtered_BOGR_K17_S34.sam
