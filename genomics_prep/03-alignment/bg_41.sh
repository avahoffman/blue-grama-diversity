#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_41
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align41.%j.out
#SBATCH --output=out_align41.%j.out
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
## Run time 02:19:07

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV10_S229_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV10_S229.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV11_S230_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV11_S230.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV12_S231_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV12_S231.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV13_S232_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV13_S232.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV14_S233_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV14_S233.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV15_S234_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV15_S234.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV16_S235_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV16_S235.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV17_S236_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV17_S236.sam

SAMFilter.pl -i gmapper_BOGR_SEV10_S229.sam -m 32 -o filtered_BOGR_SEV10_S229.sam
SAMFilter.pl -i gmapper_BOGR_SEV11_S230.sam -m 32 -o filtered_BOGR_SEV11_S230.sam
SAMFilter.pl -i gmapper_BOGR_SEV12_S231.sam -m 32 -o filtered_BOGR_SEV12_S231.sam
SAMFilter.pl -i gmapper_BOGR_SEV13_S232.sam -m 32 -o filtered_BOGR_SEV13_S232.sam
SAMFilter.pl -i gmapper_BOGR_SEV14_S233.sam -m 32 -o filtered_BOGR_SEV14_S233.sam
SAMFilter.pl -i gmapper_BOGR_SEV15_S234.sam -m 32 -o filtered_BOGR_SEV15_S234.sam
SAMFilter.pl -i gmapper_BOGR_SEV16_S235.sam -m 32 -o filtered_BOGR_SEV16_S235.sam
SAMFilter.pl -i gmapper_BOGR_SEV17_S236.sam -m 32 -o filtered_BOGR_SEV17_S236.sam
