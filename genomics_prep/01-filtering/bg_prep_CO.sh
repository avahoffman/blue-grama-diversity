#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_CO
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgCO.%j.out
#SBATCH --output=out_bgCO.%j.out
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

TruncateFastq.pl -i BOGR_CO01_S186_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO01_S186_T.fastq
TruncateFastq.pl -i BOGR_CO02_S187_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO02_S187_T.fastq
TruncateFastq.pl -i BOGR_CO03_S188_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO03_S188_T.fastq
TruncateFastq.pl -i BOGR_CO04_S189_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO04_S189_T.fastq
TruncateFastq.pl -i BOGR_CO05_S190_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO05_S190_T.fastq
TruncateFastq.pl -i BOGR_CO06_S191_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO06_S191_T.fastq
TruncateFastq.pl -i BOGR_CO07_S192_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO07_S192_T.fastq
TruncateFastq.pl -i BOGR_CO08_S193_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO08_S193_T.fastq
TruncateFastq.pl -i BOGR_CO09_S194_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO09_S194_T.fastq
TruncateFastq.pl -i BOGR_CO10_S195_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO10_S195_T.fastq
TruncateFastq.pl -i BOGR_CO11_S196_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO11_S196_T.fastq
TruncateFastq.pl -i BOGR_CO12_S197_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO12_S197_T.fastq
TruncateFastq.pl -i BOGR_CO13_S198_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO13_S198_T.fastq
TruncateFastq.pl -i BOGR_CO14_S199_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO14_S199_T.fastq
TruncateFastq.pl -i BOGR_CO15_S200_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO15_S200_T.fastq
TruncateFastq.pl -i BOGR_CO16_S201_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO16_S201_T.fastq
TruncateFastq.pl -i BOGR_CO17_S202_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO17_S202_T.fastq
QualFilterFastq.pl -i BOGR_CO01_S186_T.fastq -m 20 -x 4 -o BOGR_CO01_S186_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO02_S187_T.fastq -m 20 -x 4 -o BOGR_CO02_S187_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO03_S188_T.fastq -m 20 -x 4 -o BOGR_CO03_S188_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO04_S189_T.fastq -m 20 -x 4 -o BOGR_CO04_S189_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO05_S190_T.fastq -m 20 -x 4 -o BOGR_CO05_S190_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO06_S191_T.fastq -m 20 -x 4 -o BOGR_CO06_S191_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO07_S192_T.fastq -m 20 -x 4 -o BOGR_CO07_S192_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO08_S193_T.fastq -m 20 -x 4 -o BOGR_CO08_S193_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO09_S194_T.fastq -m 20 -x 4 -o BOGR_CO09_S194_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO10_S195_T.fastq -m 20 -x 4 -o BOGR_CO10_S195_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO11_S196_T.fastq -m 20 -x 4 -o BOGR_CO11_S196_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO12_S197_T.fastq -m 20 -x 4 -o BOGR_CO12_S197_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO13_S198_T.fastq -m 20 -x 4 -o BOGR_CO13_S198_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO14_S199_T.fastq -m 20 -x 4 -o BOGR_CO14_S199_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO15_S200_T.fastq -m 20 -x 4 -o BOGR_CO15_S200_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO16_S201_T.fastq -m 20 -x 4 -o BOGR_CO16_S201_T_Q.fastq
QualFilterFastq.pl -i BOGR_CO17_S202_T.fastq -m 20 -x 4 -o BOGR_CO17_S202_T_Q.fastq
bbduk.sh in=BOGR_CO01_S186_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO01_S186.txt out=BOGR_CO01_S186_T_Q_A.fastq
bbduk.sh in=BOGR_CO02_S187_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO02_S187.txt out=BOGR_CO02_S187_T_Q_A.fastq
bbduk.sh in=BOGR_CO03_S188_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO03_S188.txt out=BOGR_CO03_S188_T_Q_A.fastq
bbduk.sh in=BOGR_CO04_S189_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO04_S189.txt out=BOGR_CO04_S189_T_Q_A.fastq
bbduk.sh in=BOGR_CO05_S190_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO05_S190.txt out=BOGR_CO05_S190_T_Q_A.fastq
bbduk.sh in=BOGR_CO06_S191_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO06_S191.txt out=BOGR_CO06_S191_T_Q_A.fastq
bbduk.sh in=BOGR_CO07_S192_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO07_S192.txt out=BOGR_CO07_S192_T_Q_A.fastq
bbduk.sh in=BOGR_CO08_S193_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO08_S193.txt out=BOGR_CO08_S193_T_Q_A.fastq
bbduk.sh in=BOGR_CO09_S194_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO09_S194.txt out=BOGR_CO09_S194_T_Q_A.fastq
bbduk.sh in=BOGR_CO10_S195_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO10_S195.txt out=BOGR_CO10_S195_T_Q_A.fastq
bbduk.sh in=BOGR_CO11_S196_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO11_S196.txt out=BOGR_CO11_S196_T_Q_A.fastq
bbduk.sh in=BOGR_CO12_S197_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO12_S197.txt out=BOGR_CO12_S197_T_Q_A.fastq
bbduk.sh in=BOGR_CO13_S198_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO13_S198.txt out=BOGR_CO13_S198_T_Q_A.fastq
bbduk.sh in=BOGR_CO14_S199_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO14_S199.txt out=BOGR_CO14_S199_T_Q_A.fastq
bbduk.sh in=BOGR_CO15_S200_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO15_S200.txt out=BOGR_CO15_S200_T_Q_A.fastq
bbduk.sh in=BOGR_CO16_S201_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO16_S201.txt out=BOGR_CO16_S201_T_Q_A.fastq
bbduk.sh in=BOGR_CO17_S202_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO17_S202.txt out=BOGR_CO17_S202_T_Q_A.fastq