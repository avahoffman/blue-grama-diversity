#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_WR
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgWR.%j.out
#SBATCH --output=out_bgWR.%j.out
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

TruncateFastq.pl -i BOGR_WR01_S1_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR01_S1_T.fastq
TruncateFastq.pl -i BOGR_WR02_S2_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR02_S2_T.fastq
TruncateFastq.pl -i BOGR_WR03_S3_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR03_S3_T.fastq
TruncateFastq.pl -i BOGR_WR04_S4_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR04_S4_T.fastq
TruncateFastq.pl -i BOGR_WR05_S5_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR05_S5_T.fastq
TruncateFastq.pl -i BOGR_WR06_S6_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR06_S6_T.fastq
TruncateFastq.pl -i BOGR_WR07_S7_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR07_S7_T.fastq
TruncateFastq.pl -i BOGR_WR08_S8_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR08_S8_T.fastq
TruncateFastq.pl -i BOGR_WR09_S9_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR09_S9_T.fastq
TruncateFastq.pl -i BOGR_WR10_S10_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR10_S10_T.fastq
TruncateFastq.pl -i BOGR_WR11_S11_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR11_S11_T.fastq
TruncateFastq.pl -i BOGR_WR12_S12_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR12_S12_T.fastq
TruncateFastq.pl -i BOGR_WR13_S13_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR13_S13_T.fastq
TruncateFastq.pl -i BOGR_WR14_S14_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR14_S14_T.fastq
TruncateFastq.pl -i BOGR_WR15_S15_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR15_S15_T.fastq
TruncateFastq.pl -i BOGR_WR16_S16_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR16_S16_T.fastq
TruncateFastq.pl -i BOGR_WR17_S17_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR17_S17_T.fastq
QualFilterFastq.pl -i BOGR_WR01_S1_T.fastq -m 20 -x 4 -o BOGR_WR01_S1_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR02_S2_T.fastq -m 20 -x 4 -o BOGR_WR02_S2_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR03_S3_T.fastq -m 20 -x 4 -o BOGR_WR03_S3_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR04_S4_T.fastq -m 20 -x 4 -o BOGR_WR04_S4_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR05_S5_T.fastq -m 20 -x 4 -o BOGR_WR05_S5_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR06_S6_T.fastq -m 20 -x 4 -o BOGR_WR06_S6_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR07_S7_T.fastq -m 20 -x 4 -o BOGR_WR07_S7_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR08_S8_T.fastq -m 20 -x 4 -o BOGR_WR08_S8_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR09_S9_T.fastq -m 20 -x 4 -o BOGR_WR09_S9_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR10_S10_T.fastq -m 20 -x 4 -o BOGR_WR10_S10_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR11_S11_T.fastq -m 20 -x 4 -o BOGR_WR11_S11_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR12_S12_T.fastq -m 20 -x 4 -o BOGR_WR12_S12_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR13_S13_T.fastq -m 20 -x 4 -o BOGR_WR13_S13_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR14_S14_T.fastq -m 20 -x 4 -o BOGR_WR14_S14_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR15_S15_T.fastq -m 20 -x 4 -o BOGR_WR15_S15_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR16_S16_T.fastq -m 20 -x 4 -o BOGR_WR16_S16_T_Q.fastq
QualFilterFastq.pl -i BOGR_WR17_S17_T.fastq -m 20 -x 4 -o BOGR_WR17_S17_T_Q.fastq
bbduk.sh in=BOGR_WR01_S1_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR01_S1.txt out=BOGR_WR01_S1_T_Q_A.fastq
bbduk.sh in=BOGR_WR02_S2_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR02_S2.txt out=BOGR_WR02_S2_T_Q_A.fastq
bbduk.sh in=BOGR_WR03_S3_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR03_S3.txt out=BOGR_WR03_S3_T_Q_A.fastq
bbduk.sh in=BOGR_WR04_S4_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR04_S4.txt out=BOGR_WR04_S4_T_Q_A.fastq
bbduk.sh in=BOGR_WR05_S5_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR05_S5.txt out=BOGR_WR05_S5_T_Q_A.fastq
bbduk.sh in=BOGR_WR06_S6_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR06_S6.txt out=BOGR_WR06_S6_T_Q_A.fastq
bbduk.sh in=BOGR_WR07_S7_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR07_S7.txt out=BOGR_WR07_S7_T_Q_A.fastq
bbduk.sh in=BOGR_WR08_S8_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR08_S8.txt out=BOGR_WR08_S8_T_Q_A.fastq
bbduk.sh in=BOGR_WR09_S9_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR09_S9.txt out=BOGR_WR09_S9_T_Q_A.fastq
bbduk.sh in=BOGR_WR10_S10_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR10_S10.txt out=BOGR_WR10_S10_T_Q_A.fastq
bbduk.sh in=BOGR_WR11_S11_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR11_S11.txt out=BOGR_WR11_S11_T_Q_A.fastq
bbduk.sh in=BOGR_WR12_S12_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR12_S12.txt out=BOGR_WR12_S12_T_Q_A.fastq
bbduk.sh in=BOGR_WR13_S13_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR13_S13.txt out=BOGR_WR13_S13_T_Q_A.fastq
bbduk.sh in=BOGR_WR14_S14_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR14_S14.txt out=BOGR_WR14_S14_T_Q_A.fastq
bbduk.sh in=BOGR_WR15_S15_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR15_S15.txt out=BOGR_WR15_S15_T_Q_A.fastq
bbduk.sh in=BOGR_WR16_S16_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR16_S16.txt out=BOGR_WR16_S16_T_Q_A.fastq
bbduk.sh in=BOGR_WR17_S17_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR17_S17.txt out=BOGR_WR17_S17_T_Q_A.fastq
