#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_BG
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgBG.%j.out
#SBATCH --output=out_bgBG.%j.out
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

TruncateFastq.pl -i BOGR_BG01_S203_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG01_S203_T.fastq
TruncateFastq.pl -i BOGR_BG02_S204_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG02_S204_T.fastq
TruncateFastq.pl -i BOGR_BG03_S205_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG03_S205_T.fastq
TruncateFastq.pl -i BOGR_BG04_S206_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG04_S206_T.fastq
TruncateFastq.pl -i BOGR_BG05_S207_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG05_S207_T.fastq
TruncateFastq.pl -i BOGR_BG06_S208_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG06_S208_T.fastq
TruncateFastq.pl -i BOGR_BG07_S209_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG07_S209_T.fastq
TruncateFastq.pl -i BOGR_BG08_S210_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG08_S210_T.fastq
TruncateFastq.pl -i BOGR_BG09_S211_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG09_S211_T.fastq
TruncateFastq.pl -i BOGR_BG10_S212_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG10_S212_T.fastq
TruncateFastq.pl -i BOGR_BG11_S213_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG11_S213_T.fastq
TruncateFastq.pl -i BOGR_BG12_S214_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG12_S214_T.fastq
TruncateFastq.pl -i BOGR_BG13_S215_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG13_S215_T.fastq
TruncateFastq.pl -i BOGR_BG14_S216_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG14_S216_T.fastq
TruncateFastq.pl -i BOGR_BG15_S217_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG15_S217_T.fastq
TruncateFastq.pl -i BOGR_BG16_S218_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG16_S218_T.fastq
TruncateFastq.pl -i BOGR_BG17_S219_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG17_S219_T.fastq
QualFilterFastq.pl -i BOGR_BG01_S203_T.fastq -m 20 -x 4 -o BOGR_BG01_S203_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG02_S204_T.fastq -m 20 -x 4 -o BOGR_BG02_S204_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG03_S205_T.fastq -m 20 -x 4 -o BOGR_BG03_S205_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG04_S206_T.fastq -m 20 -x 4 -o BOGR_BG04_S206_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG05_S207_T.fastq -m 20 -x 4 -o BOGR_BG05_S207_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG06_S208_T.fastq -m 20 -x 4 -o BOGR_BG06_S208_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG07_S209_T.fastq -m 20 -x 4 -o BOGR_BG07_S209_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG08_S210_T.fastq -m 20 -x 4 -o BOGR_BG08_S210_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG09_S211_T.fastq -m 20 -x 4 -o BOGR_BG09_S211_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG10_S212_T.fastq -m 20 -x 4 -o BOGR_BG10_S212_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG11_S213_T.fastq -m 20 -x 4 -o BOGR_BG11_S213_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG12_S214_T.fastq -m 20 -x 4 -o BOGR_BG12_S214_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG13_S215_T.fastq -m 20 -x 4 -o BOGR_BG13_S215_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG14_S216_T.fastq -m 20 -x 4 -o BOGR_BG14_S216_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG15_S217_T.fastq -m 20 -x 4 -o BOGR_BG15_S217_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG16_S218_T.fastq -m 20 -x 4 -o BOGR_BG16_S218_T_Q.fastq
QualFilterFastq.pl -i BOGR_BG17_S219_T.fastq -m 20 -x 4 -o BOGR_BG17_S219_T_Q.fastq
bbduk.sh in=BOGR_BG01_S203_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG01_S203.txt out=BOGR_BG01_S203_T_Q_A.fastq
bbduk.sh in=BOGR_BG02_S204_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG02_S204.txt out=BOGR_BG02_S204_T_Q_A.fastq
bbduk.sh in=BOGR_BG03_S205_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG03_S205.txt out=BOGR_BG03_S205_T_Q_A.fastq
bbduk.sh in=BOGR_BG04_S206_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG04_S206.txt out=BOGR_BG04_S206_T_Q_A.fastq
bbduk.sh in=BOGR_BG05_S207_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG05_S207.txt out=BOGR_BG05_S207_T_Q_A.fastq
bbduk.sh in=BOGR_BG06_S208_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG06_S208.txt out=BOGR_BG06_S208_T_Q_A.fastq
bbduk.sh in=BOGR_BG07_S209_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG07_S209.txt out=BOGR_BG07_S209_T_Q_A.fastq
bbduk.sh in=BOGR_BG08_S210_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG08_S210.txt out=BOGR_BG08_S210_T_Q_A.fastq
bbduk.sh in=BOGR_BG09_S211_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG09_S211.txt out=BOGR_BG09_S211_T_Q_A.fastq
bbduk.sh in=BOGR_BG10_S212_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG10_S212.txt out=BOGR_BG10_S212_T_Q_A.fastq
bbduk.sh in=BOGR_BG11_S213_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG11_S213.txt out=BOGR_BG11_S213_T_Q_A.fastq
bbduk.sh in=BOGR_BG12_S214_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG12_S214.txt out=BOGR_BG12_S214_T_Q_A.fastq
bbduk.sh in=BOGR_BG13_S215_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG13_S215.txt out=BOGR_BG13_S215_T_Q_A.fastq
bbduk.sh in=BOGR_BG14_S216_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG14_S216.txt out=BOGR_BG14_S216_T_Q_A.fastq
bbduk.sh in=BOGR_BG15_S217_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG15_S217.txt out=BOGR_BG15_S217_T_Q_A.fastq
bbduk.sh in=BOGR_BG16_S218_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG16_S218.txt out=BOGR_BG16_S218_T_Q_A.fastq
bbduk.sh in=BOGR_BG17_S219_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG17_S219.txt out=BOGR_BG17_S219_T_Q_A.fastq
