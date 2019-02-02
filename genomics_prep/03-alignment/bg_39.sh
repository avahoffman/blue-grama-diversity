#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_39
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align39.%j.out
#SBATCH --output=out_align39.%j.out
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
## Run time 04:01:26

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ10_S263_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ10_S263.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ11_S264_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ11_S264.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ12_S265_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ12_S265.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ13_S266_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ13_S266.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ14_S267_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ14_S267.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ15_S268_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ15_S268.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ16_S269_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ16_S269.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ17_S270_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_KNZ17_S270.sam

SAMFilter.pl -i gmapper_BOGR_KNZ10_S263.sam -m 32 -o filtered_BOGR_KNZ10_S263.sam
SAMFilter.pl -i gmapper_BOGR_KNZ11_S264.sam -m 32 -o filtered_BOGR_KNZ11_S264.sam
SAMFilter.pl -i gmapper_BOGR_KNZ12_S265.sam -m 32 -o filtered_BOGR_KNZ12_S265.sam
SAMFilter.pl -i gmapper_BOGR_KNZ13_S266.sam -m 32 -o filtered_BOGR_KNZ13_S266.sam
SAMFilter.pl -i gmapper_BOGR_KNZ14_S267.sam -m 32 -o filtered_BOGR_KNZ14_S267.sam
SAMFilter.pl -i gmapper_BOGR_KNZ15_S268.sam -m 32 -o filtered_BOGR_KNZ15_S268.sam
SAMFilter.pl -i gmapper_BOGR_KNZ16_S269.sam -m 32 -o filtered_BOGR_KNZ16_S269.sam
SAMFilter.pl -i gmapper_BOGR_KNZ17_S270.sam -m 32 -o filtered_BOGR_KNZ17_S270.sam