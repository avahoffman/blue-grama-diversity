#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_A
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgA.%j.out
#SBATCH --output=out_bgA.%j.out
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

TruncateFastq.pl -i BOGR_A01_S68_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A01_S68_T.fastq
TruncateFastq.pl -i BOGR_A02_S69_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A02_S69_T.fastq
TruncateFastq.pl -i BOGR_A03_S70_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A03_S70_T.fastq
TruncateFastq.pl -i BOGR_A04_S71_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A04_S71_T.fastq
TruncateFastq.pl -i BOGR_A05_S72_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A05_S72_T.fastq
TruncateFastq.pl -i BOGR_A06_S73_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A06_S73_T.fastq
TruncateFastq.pl -i BOGR_A07_S74_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A07_S74_T.fastq
TruncateFastq.pl -i BOGR_A08_S75_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A08_S75_T.fastq
TruncateFastq.pl -i BOGR_A09_S76_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A09_S76_T.fastq
TruncateFastq.pl -i BOGR_A10_S77_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A10_S77_T.fastq
TruncateFastq.pl -i BOGR_A11_S78_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A11_S78_T.fastq
TruncateFastq.pl -i BOGR_A12_S79_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A12_S79_T.fastq
TruncateFastq.pl -i BOGR_A13_S80_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A13_S80_T.fastq
TruncateFastq.pl -i BOGR_A14_S81_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A14_S81_T.fastq
TruncateFastq.pl -i BOGR_A15_S82_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A15_S82_T.fastq
TruncateFastq.pl -i BOGR_A16_S83_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A16_S83_T.fastq
TruncateFastq.pl -i BOGR_A17_S84_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A17_S84_T.fastq
QualFilterFastq.pl -i BOGR_A01_S68_T.fastq -m 20 -x 4 -o BOGR_A01_S68_T_Q.fastq
QualFilterFastq.pl -i BOGR_A02_S69_T.fastq -m 20 -x 4 -o BOGR_A02_S69_T_Q.fastq
QualFilterFastq.pl -i BOGR_A03_S70_T.fastq -m 20 -x 4 -o BOGR_A03_S70_T_Q.fastq
QualFilterFastq.pl -i BOGR_A04_S71_T.fastq -m 20 -x 4 -o BOGR_A04_S71_T_Q.fastq
QualFilterFastq.pl -i BOGR_A05_S72_T.fastq -m 20 -x 4 -o BOGR_A05_S72_T_Q.fastq
QualFilterFastq.pl -i BOGR_A06_S73_T.fastq -m 20 -x 4 -o BOGR_A06_S73_T_Q.fastq
QualFilterFastq.pl -i BOGR_A07_S74_T.fastq -m 20 -x 4 -o BOGR_A07_S74_T_Q.fastq
QualFilterFastq.pl -i BOGR_A08_S75_T.fastq -m 20 -x 4 -o BOGR_A08_S75_T_Q.fastq
QualFilterFastq.pl -i BOGR_A09_S76_T.fastq -m 20 -x 4 -o BOGR_A09_S76_T_Q.fastq
QualFilterFastq.pl -i BOGR_A10_S77_T.fastq -m 20 -x 4 -o BOGR_A10_S77_T_Q.fastq
QualFilterFastq.pl -i BOGR_A11_S78_T.fastq -m 20 -x 4 -o BOGR_A11_S78_T_Q.fastq
QualFilterFastq.pl -i BOGR_A12_S79_T.fastq -m 20 -x 4 -o BOGR_A12_S79_T_Q.fastq
QualFilterFastq.pl -i BOGR_A13_S80_T.fastq -m 20 -x 4 -o BOGR_A13_S80_T_Q.fastq
QualFilterFastq.pl -i BOGR_A14_S81_T.fastq -m 20 -x 4 -o BOGR_A14_S81_T_Q.fastq
QualFilterFastq.pl -i BOGR_A15_S82_T.fastq -m 20 -x 4 -o BOGR_A15_S82_T_Q.fastq
QualFilterFastq.pl -i BOGR_A16_S83_T.fastq -m 20 -x 4 -o BOGR_A16_S83_T_Q.fastq
QualFilterFastq.pl -i BOGR_A17_S84_T.fastq -m 20 -x 4 -o BOGR_A17_S84_T_Q.fastq
bbduk.sh in=BOGR_A01_S68_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A01_S68.txt out=BOGR_A01_S68_T_Q_A.fastq
bbduk.sh in=BOGR_A02_S69_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A02_S69.txt out=BOGR_A02_S69_T_Q_A.fastq
bbduk.sh in=BOGR_A03_S70_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A03_S70.txt out=BOGR_A03_S70_T_Q_A.fastq
bbduk.sh in=BOGR_A04_S71_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A04_S71.txt out=BOGR_A04_S71_T_Q_A.fastq
bbduk.sh in=BOGR_A05_S72_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A05_S72.txt out=BOGR_A05_S72_T_Q_A.fastq
bbduk.sh in=BOGR_A06_S73_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A06_S73.txt out=BOGR_A06_S73_T_Q_A.fastq
bbduk.sh in=BOGR_A07_S74_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A07_S74.txt out=BOGR_A07_S74_T_Q_A.fastq
bbduk.sh in=BOGR_A08_S75_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A08_S75.txt out=BOGR_A08_S75_T_Q_A.fastq
bbduk.sh in=BOGR_A09_S76_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A09_S76.txt out=BOGR_A09_S76_T_Q_A.fastq
bbduk.sh in=BOGR_A10_S77_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A10_S77.txt out=BOGR_A10_S77_T_Q_A.fastq
bbduk.sh in=BOGR_A11_S78_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A11_S78.txt out=BOGR_A11_S78_T_Q_A.fastq
bbduk.sh in=BOGR_A12_S79_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A12_S79.txt out=BOGR_A12_S79_T_Q_A.fastq
bbduk.sh in=BOGR_A13_S80_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A13_S80.txt out=BOGR_A13_S80_T_Q_A.fastq
bbduk.sh in=BOGR_A14_S81_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A14_S81.txt out=BOGR_A14_S81_T_Q_A.fastq
bbduk.sh in=BOGR_A15_S82_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A15_S82.txt out=BOGR_A15_S82_T_Q_A.fastq
bbduk.sh in=BOGR_A16_S83_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A16_S83.txt out=BOGR_A16_S83_T_Q_A.fastq
bbduk.sh in=BOGR_A17_S84_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A17_S84.txt out=BOGR_A17_S84_T_Q_A.fastq
