#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_CIB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgCIB.%j.out
#SBATCH --output=out_bgCIB.%j.out
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

TruncateFastq.pl -i BOGR_CI01_S237_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI01_S237_T.fastq
TruncateFastq.pl -i BOGR_CI02_S238_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI02_S238_T.fastq
TruncateFastq.pl -i BOGR_CI03_S239_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI03_S239_T.fastq
TruncateFastq.pl -i BOGR_CI04_S240_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI04_S240_T.fastq
TruncateFastq.pl -i BOGR_CI05_S241_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI05_S241_T.fastq
TruncateFastq.pl -i BOGR_CI06_S242_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI06_S242_T.fastq
TruncateFastq.pl -i BOGR_CI07_S243_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI07_S243_T.fastq
TruncateFastq.pl -i BOGR_CI08_S244_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI08_S244_T.fastq
TruncateFastq.pl -i BOGR_CI09_S245_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI09_S245_T.fastq
TruncateFastq.pl -i BOGR_CI10_S246_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI10_S246_T.fastq
TruncateFastq.pl -i BOGR_CI11_S247_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI11_S247_T.fastq
TruncateFastq.pl -i BOGR_CI12_S248_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI12_S248_T.fastq
TruncateFastq.pl -i BOGR_CI13_S249_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI13_S249_T.fastq
TruncateFastq.pl -i BOGR_CI14_S250_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI14_S250_T.fastq
TruncateFastq.pl -i BOGR_CI15_S251_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI15_S251_T.fastq
TruncateFastq.pl -i BOGR_CI16_S252_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI16_S252_T.fastq
TruncateFastq.pl -i BOGR_CI17_S253_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI17_S253_T.fastq
QualFilterFastq.pl -i BOGR_CI01_S237_T.fastq -m 20 -x 4 -o BOGR_CI01_S237_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI02_S238_T.fastq -m 20 -x 4 -o BOGR_CI02_S238_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI03_S239_T.fastq -m 20 -x 4 -o BOGR_CI03_S239_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI04_S240_T.fastq -m 20 -x 4 -o BOGR_CI04_S240_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI05_S241_T.fastq -m 20 -x 4 -o BOGR_CI05_S241_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI06_S242_T.fastq -m 20 -x 4 -o BOGR_CI06_S242_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI07_S243_T.fastq -m 20 -x 4 -o BOGR_CI07_S243_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI08_S244_T.fastq -m 20 -x 4 -o BOGR_CI08_S244_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI09_S245_T.fastq -m 20 -x 4 -o BOGR_CI09_S245_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI10_S246_T.fastq -m 20 -x 4 -o BOGR_CI10_S246_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI11_S247_T.fastq -m 20 -x 4 -o BOGR_CI11_S247_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI12_S248_T.fastq -m 20 -x 4 -o BOGR_CI12_S248_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI13_S249_T.fastq -m 20 -x 4 -o BOGR_CI13_S249_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI14_S250_T.fastq -m 20 -x 4 -o BOGR_CI14_S250_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI15_S251_T.fastq -m 20 -x 4 -o BOGR_CI15_S251_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI16_S252_T.fastq -m 20 -x 4 -o BOGR_CI16_S252_T_Q.fastq
QualFilterFastq.pl -i BOGR_CI17_S253_T.fastq -m 20 -x 4 -o BOGR_CI17_S253_T_Q.fastq
bbduk.sh in=BOGR_CI01_S237_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI01_S237.txt out=BOGR_CI01_S237_T_Q_A.fastq
bbduk.sh in=BOGR_CI02_S238_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI02_S238.txt out=BOGR_CI02_S238_T_Q_A.fastq
bbduk.sh in=BOGR_CI03_S239_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI03_S239.txt out=BOGR_CI03_S239_T_Q_A.fastq
bbduk.sh in=BOGR_CI04_S240_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI04_S240.txt out=BOGR_CI04_S240_T_Q_A.fastq
bbduk.sh in=BOGR_CI05_S241_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI05_S241.txt out=BOGR_CI05_S241_T_Q_A.fastq
bbduk.sh in=BOGR_CI06_S242_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI06_S242.txt out=BOGR_CI06_S242_T_Q_A.fastq
bbduk.sh in=BOGR_CI07_S243_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI07_S243.txt out=BOGR_CI07_S243_T_Q_A.fastq
bbduk.sh in=BOGR_CI08_S244_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI08_S244.txt out=BOGR_CI08_S244_T_Q_A.fastq
bbduk.sh in=BOGR_CI09_S245_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI09_S245.txt out=BOGR_CI09_S245_T_Q_A.fastq
bbduk.sh in=BOGR_CI10_S246_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI10_S246.txt out=BOGR_CI10_S246_T_Q_A.fastq
bbduk.sh in=BOGR_CI11_S247_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI11_S247.txt out=BOGR_CI11_S247_T_Q_A.fastq
bbduk.sh in=BOGR_CI12_S248_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI12_S248.txt out=BOGR_CI12_S248_T_Q_A.fastq
bbduk.sh in=BOGR_CI13_S249_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI13_S249.txt out=BOGR_CI13_S249_T_Q_A.fastq
bbduk.sh in=BOGR_CI14_S250_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI14_S250.txt out=BOGR_CI14_S250_T_Q_A.fastq
bbduk.sh in=BOGR_CI15_S251_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI15_S251.txt out=BOGR_CI15_S251_T_Q_A.fastq
bbduk.sh in=BOGR_CI16_S252_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI16_S252.txt out=BOGR_CI16_S252_T_Q_A.fastq
bbduk.sh in=BOGR_CI17_S253_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI17_S253.txt out=BOGR_CI17_S253_T_Q_A.fastq
