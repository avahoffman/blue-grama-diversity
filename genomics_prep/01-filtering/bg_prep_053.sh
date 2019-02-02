#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_53
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bg53.%j.out
#SBATCH --output=out_bg53.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=1


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
export PATH=$PATH:/home/hoffmana@colostate.edu/perl5/lib/perl5/x86_64-linux/
export PATH=$PATH:/perl5/lib/perl5/x86_64-linux/

#############

## truncate, quality filter, and filter for adaptor sequences
## truncate step is quite fast, but quality filter may take 0.5-2+ hrs per sample!!

TruncateFastq.pl -i BgHq_6_2_1-119E_S460_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_2_1-119E_S460_L006_R1_001_T.fastq
QualFilterFastq.pl -i BgHq_6_2_1-119E_S460_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_2_1-119E_S460_L006_R1_001_T_Q.fastq
bbduk.sh in=BgHq_6_2_1-119E_S460_L006_R1_001_T_Q.fastq ref=adaptors.fasta k=12 stats=stats53.txt out=BgHq_6_2_1-119E_S460_L006_R1_001_T_Q_A.fastq
