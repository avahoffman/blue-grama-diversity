#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_SGS
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgSGS.%j.out
#SBATCH --output=out_bgSGS.%j.out
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

TruncateFastq.pl -i BOGR_SGS01_S85_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS01_S85_T.fastq
TruncateFastq.pl -i BOGR_SGS02_S86_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS02_S86_T.fastq
TruncateFastq.pl -i BOGR_SGS03_S87_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS03_S87_T.fastq
TruncateFastq.pl -i BOGR_SGS04_S88_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS04_S88_T.fastq
TruncateFastq.pl -i BOGR_SGS05_S89_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS05_S89_T.fastq
TruncateFastq.pl -i BOGR_SGS06_S90_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS06_S90_T.fastq
TruncateFastq.pl -i BOGR_SGS07_S91_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS07_S91_T.fastq
TruncateFastq.pl -i BOGR_SGS08_S92_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS08_S92_T.fastq
TruncateFastq.pl -i BOGR_SGS09_S93_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS09_S93_T.fastq
TruncateFastq.pl -i BOGR_SGS10_S94_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS10_S94_T.fastq
TruncateFastq.pl -i BOGR_SGS11_S95_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS11_S95_T.fastq
TruncateFastq.pl -i BOGR_SGS12_S96_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS12_S96_T.fastq
TruncateFastq.pl -i BOGR_SGS13_S97_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS13_S97_T.fastq
TruncateFastq.pl -i BOGR_SGS14_S98_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS14_S98_T.fastq
TruncateFastq.pl -i BOGR_SGS15_S99_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS15_S99_T.fastq
TruncateFastq.pl -i BOGR_SGS16_S100_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS16_S100_T.fastq
TruncateFastq.pl -i BOGR_SGS17_S101_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS17_S101_T.fastq
QualFilterFastq.pl -i BOGR_SGS01_S85_T.fastq -m 20 -x 4 -o BOGR_SGS01_S85_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS02_S86_T.fastq -m 20 -x 4 -o BOGR_SGS02_S86_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS03_S87_T.fastq -m 20 -x 4 -o BOGR_SGS03_S87_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS04_S88_T.fastq -m 20 -x 4 -o BOGR_SGS04_S88_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS05_S89_T.fastq -m 20 -x 4 -o BOGR_SGS05_S89_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS06_S90_T.fastq -m 20 -x 4 -o BOGR_SGS06_S90_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS07_S91_T.fastq -m 20 -x 4 -o BOGR_SGS07_S91_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS08_S92_T.fastq -m 20 -x 4 -o BOGR_SGS08_S92_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS09_S93_T.fastq -m 20 -x 4 -o BOGR_SGS09_S93_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS10_S94_T.fastq -m 20 -x 4 -o BOGR_SGS10_S94_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS11_S95_T.fastq -m 20 -x 4 -o BOGR_SGS11_S95_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS12_S96_T.fastq -m 20 -x 4 -o BOGR_SGS12_S96_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS13_S97_T.fastq -m 20 -x 4 -o BOGR_SGS13_S97_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS14_S98_T.fastq -m 20 -x 4 -o BOGR_SGS14_S98_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS15_S99_T.fastq -m 20 -x 4 -o BOGR_SGS15_S99_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS16_S100_T.fastq -m 20 -x 4 -o BOGR_SGS16_S100_T_Q.fastq
QualFilterFastq.pl -i BOGR_SGS17_S101_T.fastq -m 20 -x 4 -o BOGR_SGS17_S101_T_Q.fastq
bbduk.sh in=BOGR_SGS01_S85_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS01_S85.txt out=BOGR_SGS01_S85_T_Q_A.fastq
bbduk.sh in=BOGR_SGS02_S86_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS02_S86.txt out=BOGR_SGS02_S86_T_Q_A.fastq
bbduk.sh in=BOGR_SGS03_S87_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS03_S87.txt out=BOGR_SGS03_S87_T_Q_A.fastq
bbduk.sh in=BOGR_SGS04_S88_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS04_S88.txt out=BOGR_SGS04_S88_T_Q_A.fastq
bbduk.sh in=BOGR_SGS05_S89_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS05_S89.txt out=BOGR_SGS05_S89_T_Q_A.fastq
bbduk.sh in=BOGR_SGS06_S90_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS06_S90.txt out=BOGR_SGS06_S90_T_Q_A.fastq
bbduk.sh in=BOGR_SGS07_S91_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS07_S91.txt out=BOGR_SGS07_S91_T_Q_A.fastq
bbduk.sh in=BOGR_SGS08_S92_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS08_S92.txt out=BOGR_SGS08_S92_T_Q_A.fastq
bbduk.sh in=BOGR_SGS09_S93_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS09_S93.txt out=BOGR_SGS09_S93_T_Q_A.fastq
bbduk.sh in=BOGR_SGS10_S94_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS10_S94.txt out=BOGR_SGS10_S94_T_Q_A.fastq
bbduk.sh in=BOGR_SGS11_S95_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS11_S95.txt out=BOGR_SGS11_S95_T_Q_A.fastq
bbduk.sh in=BOGR_SGS12_S96_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS12_S96.txt out=BOGR_SGS12_S96_T_Q_A.fastq
bbduk.sh in=BOGR_SGS13_S97_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS13_S97.txt out=BOGR_SGS13_S97_T_Q_A.fastq
bbduk.sh in=BOGR_SGS14_S98_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS14_S98.txt out=BOGR_SGS14_S98_T_Q_A.fastq
bbduk.sh in=BOGR_SGS15_S99_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS15_S99.txt out=BOGR_SGS15_S99_T_Q_A.fastq
bbduk.sh in=BOGR_SGS16_S100_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS16_S100.txt out=BOGR_SGS16_S100_T_Q_A.fastq
bbduk.sh in=BOGR_SGS17_S101_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS17_S101.txt out=BOGR_SGS17_S101_T_Q_A.fastq
