#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_KNZ
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgKNZ.%j.out
#SBATCH --output=out_bgKNZ.%j.out
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

TruncateFastq.pl -i BOGR_KNZ01_S254_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ01_S254_T.fastq
TruncateFastq.pl -i BOGR_KNZ02_S255_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ02_S255_T.fastq
TruncateFastq.pl -i BOGR_KNZ03_S256_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ03_S256_T.fastq
TruncateFastq.pl -i BOGR_KNZ04_S257_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ04_S257_T.fastq
TruncateFastq.pl -i BOGR_KNZ05_S258_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ05_S258_T.fastq
TruncateFastq.pl -i BOGR_KNZ06_S259_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ06_S259_T.fastq
TruncateFastq.pl -i BOGR_KNZ07_S260_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ07_S260_T.fastq
TruncateFastq.pl -i BOGR_KNZ08_S261_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ08_S261_T.fastq
TruncateFastq.pl -i BOGR_KNZ09_S262_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ09_S262_T.fastq
TruncateFastq.pl -i BOGR_KNZ10_S263_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ10_S263_T.fastq
TruncateFastq.pl -i BOGR_KNZ11_S264_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ11_S264_T.fastq
TruncateFastq.pl -i BOGR_KNZ12_S265_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ12_S265_T.fastq
TruncateFastq.pl -i BOGR_KNZ13_S266_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ13_S266_T.fastq
TruncateFastq.pl -i BOGR_KNZ14_S267_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ14_S267_T.fastq
TruncateFastq.pl -i BOGR_KNZ15_S268_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ15_S268_T.fastq
TruncateFastq.pl -i BOGR_KNZ16_S269_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ16_S269_T.fastq
TruncateFastq.pl -i BOGR_KNZ17_S270_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ17_S270_T.fastq
QualFilterFastq.pl -i BOGR_KNZ01_S254_T.fastq -m 20 -x 4 -o BOGR_KNZ01_S254_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ02_S255_T.fastq -m 20 -x 4 -o BOGR_KNZ02_S255_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ03_S256_T.fastq -m 20 -x 4 -o BOGR_KNZ03_S256_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ04_S257_T.fastq -m 20 -x 4 -o BOGR_KNZ04_S257_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ05_S258_T.fastq -m 20 -x 4 -o BOGR_KNZ05_S258_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ06_S259_T.fastq -m 20 -x 4 -o BOGR_KNZ06_S259_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ07_S260_T.fastq -m 20 -x 4 -o BOGR_KNZ07_S260_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ08_S261_T.fastq -m 20 -x 4 -o BOGR_KNZ08_S261_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ09_S262_T.fastq -m 20 -x 4 -o BOGR_KNZ09_S262_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ10_S263_T.fastq -m 20 -x 4 -o BOGR_KNZ10_S263_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ11_S264_T.fastq -m 20 -x 4 -o BOGR_KNZ11_S264_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ12_S265_T.fastq -m 20 -x 4 -o BOGR_KNZ12_S265_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ13_S266_T.fastq -m 20 -x 4 -o BOGR_KNZ13_S266_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ14_S267_T.fastq -m 20 -x 4 -o BOGR_KNZ14_S267_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ15_S268_T.fastq -m 20 -x 4 -o BOGR_KNZ15_S268_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ16_S269_T.fastq -m 20 -x 4 -o BOGR_KNZ16_S269_T_Q.fastq
QualFilterFastq.pl -i BOGR_KNZ17_S270_T.fastq -m 20 -x 4 -o BOGR_KNZ17_S270_T_Q.fastq
bbduk.sh in=BOGR_KNZ01_S254_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ01_S254.txt out=BOGR_KNZ01_S254_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ02_S255_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ02_S255.txt out=BOGR_KNZ02_S255_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ03_S256_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ03_S256.txt out=BOGR_KNZ03_S256_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ04_S257_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ04_S257.txt out=BOGR_KNZ04_S257_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ05_S258_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ05_S258.txt out=BOGR_KNZ05_S258_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ06_S259_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ06_S259.txt out=BOGR_KNZ06_S259_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ07_S260_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ07_S260.txt out=BOGR_KNZ07_S260_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ08_S261_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ08_S261.txt out=BOGR_KNZ08_S261_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ09_S262_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ09_S262.txt out=BOGR_KNZ09_S262_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ10_S263_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ10_S263.txt out=BOGR_KNZ10_S263_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ11_S264_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ11_S264.txt out=BOGR_KNZ11_S264_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ12_S265_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ12_S265.txt out=BOGR_KNZ12_S265_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ13_S266_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ13_S266.txt out=BOGR_KNZ13_S266_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ14_S267_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ14_S267.txt out=BOGR_KNZ14_S267_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ15_S268_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ15_S268.txt out=BOGR_KNZ15_S268_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ16_S269_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ16_S269.txt out=BOGR_KNZ16_S269_T_Q_A.fastq
bbduk.sh in=BOGR_KNZ17_S270_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ17_S270.txt out=BOGR_KNZ17_S270_T_Q_A.fastq
