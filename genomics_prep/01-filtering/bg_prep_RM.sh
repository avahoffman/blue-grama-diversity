#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_RM
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgRM.%j.out
#SBATCH --output=out_bgRM.%j.out
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

TruncateFastq.pl -i BOGR_RM01_S35_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM01_S35_T.fastq
TruncateFastq.pl -i BOGR_RM02_S36_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM02_S36_T.fastq
TruncateFastq.pl -i BOGR_RM03_S37_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM03_S37_T.fastq
TruncateFastq.pl -i BOGR_RM04_S38_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM04_S38_T.fastq
TruncateFastq.pl -i BOGR_RM05_S39_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM05_S39_T.fastq
TruncateFastq.pl -i BOGR_RM06_S40_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM06_S40_T.fastq
TruncateFastq.pl -i BOGR_RM07_S41_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM07_S41_T.fastq
TruncateFastq.pl -i BOGR_RM08_S42_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM08_S42_T.fastq
TruncateFastq.pl -i BOGR_RM09_S43_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM09_S43_T.fastq
TruncateFastq.pl -i BOGR_RM10_S44_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM10_S44_T.fastq
TruncateFastq.pl -i BOGR_RM11_S45_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM11_S45_T.fastq
TruncateFastq.pl -i BOGR_RM12_S46_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM12_S46_T.fastq
TruncateFastq.pl -i BOGR_RM13_S47_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM13_S47_T.fastq
TruncateFastq.pl -i BOGR_RM14_S48_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM14_S48_T.fastq
TruncateFastq.pl -i BOGR_RM15_S49_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM15_S49_T.fastq
TruncateFastq.pl -i BOGR_RM16_S50_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM16_S50_T.fastq
TruncateFastq.pl -i BOGR_RM17_S51_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM17_S51_T.fastq
QualFilterFastq.pl -i BOGR_RM01_S35_T.fastq -m 20 -x 4 -o BOGR_RM01_S35_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM02_S36_T.fastq -m 20 -x 4 -o BOGR_RM02_S36_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM03_S37_T.fastq -m 20 -x 4 -o BOGR_RM03_S37_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM04_S38_T.fastq -m 20 -x 4 -o BOGR_RM04_S38_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM05_S39_T.fastq -m 20 -x 4 -o BOGR_RM05_S39_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM06_S40_T.fastq -m 20 -x 4 -o BOGR_RM06_S40_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM07_S41_T.fastq -m 20 -x 4 -o BOGR_RM07_S41_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM08_S42_T.fastq -m 20 -x 4 -o BOGR_RM08_S42_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM09_S43_T.fastq -m 20 -x 4 -o BOGR_RM09_S43_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM10_S44_T.fastq -m 20 -x 4 -o BOGR_RM10_S44_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM11_S45_T.fastq -m 20 -x 4 -o BOGR_RM11_S45_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM12_S46_T.fastq -m 20 -x 4 -o BOGR_RM12_S46_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM13_S47_T.fastq -m 20 -x 4 -o BOGR_RM13_S47_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM14_S48_T.fastq -m 20 -x 4 -o BOGR_RM14_S48_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM15_S49_T.fastq -m 20 -x 4 -o BOGR_RM15_S49_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM16_S50_T.fastq -m 20 -x 4 -o BOGR_RM16_S50_T_Q.fastq
QualFilterFastq.pl -i BOGR_RM17_S51_T.fastq -m 20 -x 4 -o BOGR_RM17_S51_T_Q.fastq
bbduk.sh in=BOGR_RM01_S35_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM01_S35.txt out=BOGR_RM01_S35_T_Q_A.fastq
bbduk.sh in=BOGR_RM02_S36_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM02_S36.txt out=BOGR_RM02_S36_T_Q_A.fastq
bbduk.sh in=BOGR_RM03_S37_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM03_S37.txt out=BOGR_RM03_S37_T_Q_A.fastq
bbduk.sh in=BOGR_RM04_S38_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM04_S38.txt out=BOGR_RM04_S38_T_Q_A.fastq
bbduk.sh in=BOGR_RM05_S39_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM05_S39.txt out=BOGR_RM05_S39_T_Q_A.fastq
bbduk.sh in=BOGR_RM06_S40_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM06_S40.txt out=BOGR_RM06_S40_T_Q_A.fastq
bbduk.sh in=BOGR_RM07_S41_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM07_S41.txt out=BOGR_RM07_S41_T_Q_A.fastq
bbduk.sh in=BOGR_RM08_S42_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM08_S42.txt out=BOGR_RM08_S42_T_Q_A.fastq
bbduk.sh in=BOGR_RM09_S43_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM09_S43.txt out=BOGR_RM09_S43_T_Q_A.fastq
bbduk.sh in=BOGR_RM10_S44_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM10_S44.txt out=BOGR_RM10_S44_T_Q_A.fastq
bbduk.sh in=BOGR_RM11_S45_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM11_S45.txt out=BOGR_RM11_S45_T_Q_A.fastq
bbduk.sh in=BOGR_RM12_S46_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM12_S46.txt out=BOGR_RM12_S46_T_Q_A.fastq
bbduk.sh in=BOGR_RM13_S47_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM13_S47.txt out=BOGR_RM13_S47_T_Q_A.fastq
bbduk.sh in=BOGR_RM14_S48_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM14_S48.txt out=BOGR_RM14_S48_T_Q_A.fastq
bbduk.sh in=BOGR_RM15_S49_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM15_S49.txt out=BOGR_RM15_S49_T_Q_A.fastq
bbduk.sh in=BOGR_RM16_S50_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM16_S50.txt out=BOGR_RM16_S50_T_Q_A.fastq
bbduk.sh in=BOGR_RM17_S51_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM17_S51.txt out=BOGR_RM17_S51_T_Q_A.fastq
