#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_ST
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgST.%j.out
#SBATCH --output=out_bgST.%j.out
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

TruncateFastq.pl -i BOGR_ST01_S152_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST01_S152_T.fastq
TruncateFastq.pl -i BOGR_ST02_S153_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST02_S153_T.fastq
TruncateFastq.pl -i BOGR_ST03_S154_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST03_S154_T.fastq
TruncateFastq.pl -i BOGR_ST04_S155_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST04_S155_T.fastq
TruncateFastq.pl -i BOGR_ST05_S156_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST05_S156_T.fastq
TruncateFastq.pl -i BOGR_ST06_S157_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST06_S157_T.fastq
TruncateFastq.pl -i BOGR_ST07_S158_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST07_S158_T.fastq
TruncateFastq.pl -i BOGR_ST08_S159_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST08_S159_T.fastq
TruncateFastq.pl -i BOGR_ST09_S160_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST09_S160_T.fastq
TruncateFastq.pl -i BOGR_ST10_S161_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST10_S161_T.fastq
TruncateFastq.pl -i BOGR_ST11_S162_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST11_S162_T.fastq
TruncateFastq.pl -i BOGR_ST12_S163_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST12_S163_T.fastq
TruncateFastq.pl -i BOGR_ST13_S164_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST13_S164_T.fastq
TruncateFastq.pl -i BOGR_ST14_S165_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST14_S165_T.fastq
TruncateFastq.pl -i BOGR_ST15_S166_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST15_S166_T.fastq
TruncateFastq.pl -i BOGR_ST16_S167_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST16_S167_T.fastq
TruncateFastq.pl -i BOGR_ST17_S168_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST17_S168_T.fastq
QualFilterFastq.pl -i BOGR_ST01_S152_T.fastq -m 20 -x 4 -o BOGR_ST01_S152_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST02_S153_T.fastq -m 20 -x 4 -o BOGR_ST02_S153_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST03_S154_T.fastq -m 20 -x 4 -o BOGR_ST03_S154_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST04_S155_T.fastq -m 20 -x 4 -o BOGR_ST04_S155_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST05_S156_T.fastq -m 20 -x 4 -o BOGR_ST05_S156_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST06_S157_T.fastq -m 20 -x 4 -o BOGR_ST06_S157_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST07_S158_T.fastq -m 20 -x 4 -o BOGR_ST07_S158_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST08_S159_T.fastq -m 20 -x 4 -o BOGR_ST08_S159_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST09_S160_T.fastq -m 20 -x 4 -o BOGR_ST09_S160_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST10_S161_T.fastq -m 20 -x 4 -o BOGR_ST10_S161_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST11_S162_T.fastq -m 20 -x 4 -o BOGR_ST11_S162_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST12_S163_T.fastq -m 20 -x 4 -o BOGR_ST12_S163_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST13_S164_T.fastq -m 20 -x 4 -o BOGR_ST13_S164_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST14_S165_T.fastq -m 20 -x 4 -o BOGR_ST14_S165_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST15_S166_T.fastq -m 20 -x 4 -o BOGR_ST15_S166_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST16_S167_T.fastq -m 20 -x 4 -o BOGR_ST16_S167_T_Q.fastq
QualFilterFastq.pl -i BOGR_ST17_S168_T.fastq -m 20 -x 4 -o BOGR_ST17_S168_T_Q.fastq
bbduk.sh in=BOGR_ST01_S152_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST01_S152.txt out=BOGR_ST01_S152_T_Q_A.fastq
bbduk.sh in=BOGR_ST02_S153_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST02_S153.txt out=BOGR_ST02_S153_T_Q_A.fastq
bbduk.sh in=BOGR_ST03_S154_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST03_S154.txt out=BOGR_ST03_S154_T_Q_A.fastq
bbduk.sh in=BOGR_ST04_S155_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST04_S155.txt out=BOGR_ST04_S155_T_Q_A.fastq
bbduk.sh in=BOGR_ST05_S156_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST05_S156.txt out=BOGR_ST05_S156_T_Q_A.fastq
bbduk.sh in=BOGR_ST06_S157_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST06_S157.txt out=BOGR_ST06_S157_T_Q_A.fastq
bbduk.sh in=BOGR_ST07_S158_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST07_S158.txt out=BOGR_ST07_S158_T_Q_A.fastq
bbduk.sh in=BOGR_ST08_S159_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST08_S159.txt out=BOGR_ST08_S159_T_Q_A.fastq
bbduk.sh in=BOGR_ST09_S160_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST09_S160.txt out=BOGR_ST09_S160_T_Q_A.fastq
bbduk.sh in=BOGR_ST10_S161_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST10_S161.txt out=BOGR_ST10_S161_T_Q_A.fastq
bbduk.sh in=BOGR_ST11_S162_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST11_S162.txt out=BOGR_ST11_S162_T_Q_A.fastq
bbduk.sh in=BOGR_ST12_S163_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST12_S163.txt out=BOGR_ST12_S163_T_Q_A.fastq
bbduk.sh in=BOGR_ST13_S164_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST13_S164.txt out=BOGR_ST13_S164_T_Q_A.fastq
bbduk.sh in=BOGR_ST14_S165_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST14_S165.txt out=BOGR_ST14_S165_T_Q_A.fastq
bbduk.sh in=BOGR_ST15_S166_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST15_S166.txt out=BOGR_ST15_S166_T_Q_A.fastq
bbduk.sh in=BOGR_ST16_S167_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST16_S167.txt out=BOGR_ST16_S167_T_Q_A.fastq
bbduk.sh in=BOGR_ST17_S168_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST17_S168.txt out=BOGR_ST17_S168_T_Q_A.fastq
