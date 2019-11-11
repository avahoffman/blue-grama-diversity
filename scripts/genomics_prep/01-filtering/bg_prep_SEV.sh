#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_SEV
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgSEV.%j.out
#SBATCH --output=out_bgSEV.%j.out
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

TruncateFastq.pl -i BOGR_SEV01_S220_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV01_S220_T.fastq
TruncateFastq.pl -i BOGR_SEV02_S221_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV02_S221_T.fastq
TruncateFastq.pl -i BOGR_SEV03_S222_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV03_S222_T.fastq
TruncateFastq.pl -i BOGR_SEV04_S223_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV04_S223_T.fastq
TruncateFastq.pl -i BOGR_SEV05_S224_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV05_S224_T.fastq
TruncateFastq.pl -i BOGR_SEV06_S225_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV06_S225_T.fastq
TruncateFastq.pl -i BOGR_SEV07_S226_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV07_S226_T.fastq
TruncateFastq.pl -i BOGR_SEV08_S227_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV08_S227_T.fastq
TruncateFastq.pl -i BOGR_SEV09_S228_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV09_S228_T.fastq
TruncateFastq.pl -i BOGR_SEV10_S229_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV10_S229_T.fastq
TruncateFastq.pl -i BOGR_SEV11_S230_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV11_S230_T.fastq
TruncateFastq.pl -i BOGR_SEV12_S231_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV12_S231_T.fastq
TruncateFastq.pl -i BOGR_SEV13_S232_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV13_S232_T.fastq
TruncateFastq.pl -i BOGR_SEV14_S233_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV14_S233_T.fastq
TruncateFastq.pl -i BOGR_SEV15_S234_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV15_S234_T.fastq
TruncateFastq.pl -i BOGR_SEV16_S235_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV16_S235_T.fastq
TruncateFastq.pl -i BOGR_SEV17_S236_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV17_S236_T.fastq
QualFilterFastq.pl -i BOGR_SEV01_S220_T.fastq -m 20 -x 4 -o BOGR_SEV01_S220_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV02_S221_T.fastq -m 20 -x 4 -o BOGR_SEV02_S221_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV03_S222_T.fastq -m 20 -x 4 -o BOGR_SEV03_S222_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV04_S223_T.fastq -m 20 -x 4 -o BOGR_SEV04_S223_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV05_S224_T.fastq -m 20 -x 4 -o BOGR_SEV05_S224_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV06_S225_T.fastq -m 20 -x 4 -o BOGR_SEV06_S225_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV07_S226_T.fastq -m 20 -x 4 -o BOGR_SEV07_S226_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV08_S227_T.fastq -m 20 -x 4 -o BOGR_SEV08_S227_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV09_S228_T.fastq -m 20 -x 4 -o BOGR_SEV09_S228_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV10_S229_T.fastq -m 20 -x 4 -o BOGR_SEV10_S229_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV11_S230_T.fastq -m 20 -x 4 -o BOGR_SEV11_S230_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV12_S231_T.fastq -m 20 -x 4 -o BOGR_SEV12_S231_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV13_S232_T.fastq -m 20 -x 4 -o BOGR_SEV13_S232_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV14_S233_T.fastq -m 20 -x 4 -o BOGR_SEV14_S233_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV15_S234_T.fastq -m 20 -x 4 -o BOGR_SEV15_S234_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV16_S235_T.fastq -m 20 -x 4 -o BOGR_SEV16_S235_T_Q.fastq
QualFilterFastq.pl -i BOGR_SEV17_S236_T.fastq -m 20 -x 4 -o BOGR_SEV17_S236_T_Q.fastq
bbduk.sh in=BOGR_SEV01_S220_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV01_S220.txt out=BOGR_SEV01_S220_T_Q_A.fastq
bbduk.sh in=BOGR_SEV02_S221_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV02_S221.txt out=BOGR_SEV02_S221_T_Q_A.fastq
bbduk.sh in=BOGR_SEV03_S222_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV03_S222.txt out=BOGR_SEV03_S222_T_Q_A.fastq
bbduk.sh in=BOGR_SEV04_S223_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV04_S223.txt out=BOGR_SEV04_S223_T_Q_A.fastq
bbduk.sh in=BOGR_SEV05_S224_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV05_S224.txt out=BOGR_SEV05_S224_T_Q_A.fastq
bbduk.sh in=BOGR_SEV06_S225_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV06_S225.txt out=BOGR_SEV06_S225_T_Q_A.fastq
bbduk.sh in=BOGR_SEV07_S226_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV07_S226.txt out=BOGR_SEV07_S226_T_Q_A.fastq
bbduk.sh in=BOGR_SEV08_S227_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV08_S227.txt out=BOGR_SEV08_S227_T_Q_A.fastq
bbduk.sh in=BOGR_SEV09_S228_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV09_S228.txt out=BOGR_SEV09_S228_T_Q_A.fastq
bbduk.sh in=BOGR_SEV10_S229_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV10_S229.txt out=BOGR_SEV10_S229_T_Q_A.fastq
bbduk.sh in=BOGR_SEV11_S230_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV11_S230.txt out=BOGR_SEV11_S230_T_Q_A.fastq
bbduk.sh in=BOGR_SEV12_S231_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV12_S231.txt out=BOGR_SEV12_S231_T_Q_A.fastq
bbduk.sh in=BOGR_SEV13_S232_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV13_S232.txt out=BOGR_SEV13_S232_T_Q_A.fastq
bbduk.sh in=BOGR_SEV14_S233_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV14_S233.txt out=BOGR_SEV14_S233_T_Q_A.fastq
bbduk.sh in=BOGR_SEV15_S234_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV15_S234.txt out=BOGR_SEV15_S234_T_Q_A.fastq
bbduk.sh in=BOGR_SEV16_S235_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV16_S235.txt out=BOGR_SEV16_S235_T_Q_A.fastq
bbduk.sh in=BOGR_SEV17_S236_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV17_S236.txt out=BOGR_SEV17_S236_T_Q_A.fastq
