#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_27
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align27.%j.out
#SBATCH --output=out_align27.%j.out
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
## Run time 03:03:58

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG10_S212_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG10_S212.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG11_S213_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG11_S213.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG12_S214_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG12_S214.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG13_S215_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG13_S215.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG14_S216_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG14_S216.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG15_S217_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG15_S217.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG16_S218_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG16_S218.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG17_S219_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_BG17_S219.sam

SAMFilter.pl -i gmapper_BOGR_BG10_S212.sam -m 32 -o filtered_BOGR_BG10_S212.sam
SAMFilter.pl -i gmapper_BOGR_BG11_S213.sam -m 32 -o filtered_BOGR_BG11_S213.sam
SAMFilter.pl -i gmapper_BOGR_BG12_S214.sam -m 32 -o filtered_BOGR_BG12_S214.sam
SAMFilter.pl -i gmapper_BOGR_BG13_S215.sam -m 32 -o filtered_BOGR_BG13_S215.sam
SAMFilter.pl -i gmapper_BOGR_BG14_S216.sam -m 32 -o filtered_BOGR_BG14_S216.sam
SAMFilter.pl -i gmapper_BOGR_BG15_S217.sam -m 32 -o filtered_BOGR_BG15_S217.sam
SAMFilter.pl -i gmapper_BOGR_BG16_S218.sam -m 32 -o filtered_BOGR_BG16_S218.sam
SAMFilter.pl -i gmapper_BOGR_BG17_S219.sam -m 32 -o filtered_BOGR_BG17_S219.sam
