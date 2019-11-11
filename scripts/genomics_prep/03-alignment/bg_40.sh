#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_40
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_align40.%j.out
#SBATCH --output=out_align40.%j.out
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
## Run time 02:42:06

gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV01_S220_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV01_S220.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV02_S221_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV02_S221.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV03_S222_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV03_S222.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV04_S223_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV04_S223.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV05_S224_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV05_S224.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV06_S225_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV06_S225.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV07_S226_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV07_S226.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV08_S227_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV08_S227.sam
gmapper --qv-offset 33 -Q --strata -o 3 -N 1 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV09_S228_T_Q_A.fastq /scratch/summit/hoffmana@colostate.edu/genomics/reference/reference_samples.fasta >gmapper_BOGR_SEV09_S228.sam

SAMFilter.pl -i gmapper_BOGR_SEV01_S220.sam -m 32 -o filtered_BOGR_SEV01_S220.sam
SAMFilter.pl -i gmapper_BOGR_SEV02_S221.sam -m 32 -o filtered_BOGR_SEV02_S221.sam
SAMFilter.pl -i gmapper_BOGR_SEV03_S222.sam -m 32 -o filtered_BOGR_SEV03_S222.sam
SAMFilter.pl -i gmapper_BOGR_SEV04_S223.sam -m 32 -o filtered_BOGR_SEV04_S223.sam
SAMFilter.pl -i gmapper_BOGR_SEV05_S224.sam -m 32 -o filtered_BOGR_SEV05_S224.sam
SAMFilter.pl -i gmapper_BOGR_SEV06_S225.sam -m 32 -o filtered_BOGR_SEV06_S225.sam
SAMFilter.pl -i gmapper_BOGR_SEV07_S226.sam -m 32 -o filtered_BOGR_SEV07_S226.sam
SAMFilter.pl -i gmapper_BOGR_SEV08_S227.sam -m 32 -o filtered_BOGR_SEV08_S227.sam
SAMFilter.pl -i gmapper_BOGR_SEV09_S228.sam -m 32 -o filtered_BOGR_SEV09_S228.sam
