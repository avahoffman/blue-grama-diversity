#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_HV
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgHV.%j.out
#SBATCH --output=out_bgHV.%j.out
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

TruncateFastq.pl -i BOGR_HV01_S102_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV01_S102_T.fastq
TruncateFastq.pl -i BOGR_HV02_S103_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV02_S103_T.fastq
TruncateFastq.pl -i BOGR_HV03_S104_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV03_S104_T.fastq
TruncateFastq.pl -i BOGR_HV04_S105_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV04_S105_T.fastq
TruncateFastq.pl -i BOGR_HV05_S106_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV05_S106_T.fastq
TruncateFastq.pl -i BOGR_HV06_S107_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV06_S107_T.fastq
TruncateFastq.pl -i BOGR_HV07_S108_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV07_S108_T.fastq
TruncateFastq.pl -i BOGR_HV08_S109_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV08_S109_T.fastq
TruncateFastq.pl -i BOGR_HV10_S110_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV10_S110_T.fastq
TruncateFastq.pl -i BOGR_HV11_S111_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV11_S111_T.fastq
TruncateFastq.pl -i BOGR_HV12_S112_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV12_S112_T.fastq
TruncateFastq.pl -i BOGR_HV13_S113_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV13_S113_T.fastq
TruncateFastq.pl -i BOGR_HV14_S114_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV14_S114_T.fastq
TruncateFastq.pl -i BOGR_HV15_S115_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV15_S115_T.fastq
TruncateFastq.pl -i BOGR_HV16_S116_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV16_S116_T.fastq
TruncateFastq.pl -i BOGR_HV17_S117_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV17_S117_T.fastq
QualFilterFastq.pl -i BOGR_HV01_S102_T.fastq -m 20 -x 4 -o BOGR_HV01_S102_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV02_S103_T.fastq -m 20 -x 4 -o BOGR_HV02_S103_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV03_S104_T.fastq -m 20 -x 4 -o BOGR_HV03_S104_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV04_S105_T.fastq -m 20 -x 4 -o BOGR_HV04_S105_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV05_S106_T.fastq -m 20 -x 4 -o BOGR_HV05_S106_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV06_S107_T.fastq -m 20 -x 4 -o BOGR_HV06_S107_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV07_S108_T.fastq -m 20 -x 4 -o BOGR_HV07_S108_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV08_S109_T.fastq -m 20 -x 4 -o BOGR_HV08_S109_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV10_S110_T.fastq -m 20 -x 4 -o BOGR_HV10_S110_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV11_S111_T.fastq -m 20 -x 4 -o BOGR_HV11_S111_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV12_S112_T.fastq -m 20 -x 4 -o BOGR_HV12_S112_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV13_S113_T.fastq -m 20 -x 4 -o BOGR_HV13_S113_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV14_S114_T.fastq -m 20 -x 4 -o BOGR_HV14_S114_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV15_S115_T.fastq -m 20 -x 4 -o BOGR_HV15_S115_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV16_S116_T.fastq -m 20 -x 4 -o BOGR_HV16_S116_T_Q.fastq
QualFilterFastq.pl -i BOGR_HV17_S117_T.fastq -m 20 -x 4 -o BOGR_HV17_S117_T_Q.fastq
bbduk.sh in=BOGR_HV01_S102_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV01_S102.txt out=BOGR_HV01_S102_T_Q_A.fastq
bbduk.sh in=BOGR_HV02_S103_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV02_S103.txt out=BOGR_HV02_S103_T_Q_A.fastq
bbduk.sh in=BOGR_HV03_S104_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV03_S104.txt out=BOGR_HV03_S104_T_Q_A.fastq
bbduk.sh in=BOGR_HV04_S105_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV04_S105.txt out=BOGR_HV04_S105_T_Q_A.fastq
bbduk.sh in=BOGR_HV05_S106_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV05_S106.txt out=BOGR_HV05_S106_T_Q_A.fastq
bbduk.sh in=BOGR_HV06_S107_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV06_S107.txt out=BOGR_HV06_S107_T_Q_A.fastq
bbduk.sh in=BOGR_HV07_S108_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV07_S108.txt out=BOGR_HV07_S108_T_Q_A.fastq
bbduk.sh in=BOGR_HV08_S109_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV08_S109.txt out=BOGR_HV08_S109_T_Q_A.fastq
bbduk.sh in=BOGR_HV10_S110_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV10_S110.txt out=BOGR_HV10_S110_T_Q_A.fastq
bbduk.sh in=BOGR_HV11_S111_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV11_S111.txt out=BOGR_HV11_S111_T_Q_A.fastq
bbduk.sh in=BOGR_HV12_S112_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV12_S112.txt out=BOGR_HV12_S112_T_Q_A.fastq
bbduk.sh in=BOGR_HV13_S113_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV13_S113.txt out=BOGR_HV13_S113_T_Q_A.fastq
bbduk.sh in=BOGR_HV14_S114_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV14_S114.txt out=BOGR_HV14_S114_T_Q_A.fastq
bbduk.sh in=BOGR_HV15_S115_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV15_S115.txt out=BOGR_HV15_S115_T_Q_A.fastq
bbduk.sh in=BOGR_HV16_S116_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV16_S116.txt out=BOGR_HV16_S116_T_Q_A.fastq
bbduk.sh in=BOGR_HV17_S117_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV17_S117.txt out=BOGR_HV17_S117_T_Q_A.fastq
