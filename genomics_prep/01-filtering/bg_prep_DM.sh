#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_DM
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgDM.%j.out
#SBATCH --output=out_bgDM.%j.out
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

TruncateFastq.pl -i BOGR_DM01_S118_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM01_S118_T.fastq
TruncateFastq.pl -i BOGR_DM02_S119_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM02_S119_T.fastq
TruncateFastq.pl -i BOGR_DM03_S120_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM03_S120_T.fastq
TruncateFastq.pl -i BOGR_DM04_S121_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM04_S121_T.fastq
TruncateFastq.pl -i BOGR_DM05_S122_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM05_S122_T.fastq
TruncateFastq.pl -i BOGR_DM06_S123_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM06_S123_T.fastq
TruncateFastq.pl -i BOGR_DM07_S124_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM07_S124_T.fastq
TruncateFastq.pl -i BOGR_DM08_S125_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM08_S125_T.fastq
TruncateFastq.pl -i BOGR_DM09_S126_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM09_S126_T.fastq
TruncateFastq.pl -i BOGR_DM10_S127_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM10_S127_T.fastq
TruncateFastq.pl -i BOGR_DM11_S128_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM11_S128_T.fastq
TruncateFastq.pl -i BOGR_DM12_S129_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM12_S129_T.fastq
TruncateFastq.pl -i BOGR_DM13_S130_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM13_S130_T.fastq
TruncateFastq.pl -i BOGR_DM14_S131_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM14_S131_T.fastq
TruncateFastq.pl -i BOGR_DM15_S132_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM15_S132_T.fastq
TruncateFastq.pl -i BOGR_DM16_S133_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM16_S133_T.fastq
TruncateFastq.pl -i BOGR_DM17_S134_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM17_S134_T.fastq
QualFilterFastq.pl -i BOGR_DM01_S118_T.fastq -m 20 -x 4 -o BOGR_DM01_S118_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM02_S119_T.fastq -m 20 -x 4 -o BOGR_DM02_S119_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM03_S120_T.fastq -m 20 -x 4 -o BOGR_DM03_S120_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM04_S121_T.fastq -m 20 -x 4 -o BOGR_DM04_S121_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM05_S122_T.fastq -m 20 -x 4 -o BOGR_DM05_S122_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM06_S123_T.fastq -m 20 -x 4 -o BOGR_DM06_S123_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM07_S124_T.fastq -m 20 -x 4 -o BOGR_DM07_S124_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM08_S125_T.fastq -m 20 -x 4 -o BOGR_DM08_S125_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM09_S126_T.fastq -m 20 -x 4 -o BOGR_DM09_S126_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM10_S127_T.fastq -m 20 -x 4 -o BOGR_DM10_S127_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM11_S128_T.fastq -m 20 -x 4 -o BOGR_DM11_S128_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM12_S129_T.fastq -m 20 -x 4 -o BOGR_DM12_S129_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM13_S130_T.fastq -m 20 -x 4 -o BOGR_DM13_S130_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM14_S131_T.fastq -m 20 -x 4 -o BOGR_DM14_S131_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM15_S132_T.fastq -m 20 -x 4 -o BOGR_DM15_S132_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM16_S133_T.fastq -m 20 -x 4 -o BOGR_DM16_S133_T_Q.fastq
QualFilterFastq.pl -i BOGR_DM17_S134_T.fastq -m 20 -x 4 -o BOGR_DM17_S134_T_Q.fastq
bbduk.sh in=BOGR_DM01_S118_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM01_S118.txt out=BOGR_DM01_S118_T_Q_A.fastq
bbduk.sh in=BOGR_DM02_S119_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM02_S119.txt out=BOGR_DM02_S119_T_Q_A.fastq
bbduk.sh in=BOGR_DM03_S120_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM03_S120.txt out=BOGR_DM03_S120_T_Q_A.fastq
bbduk.sh in=BOGR_DM04_S121_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM04_S121.txt out=BOGR_DM04_S121_T_Q_A.fastq
bbduk.sh in=BOGR_DM05_S122_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM05_S122.txt out=BOGR_DM05_S122_T_Q_A.fastq
bbduk.sh in=BOGR_DM06_S123_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM06_S123.txt out=BOGR_DM06_S123_T_Q_A.fastq
bbduk.sh in=BOGR_DM07_S124_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM07_S124.txt out=BOGR_DM07_S124_T_Q_A.fastq
bbduk.sh in=BOGR_DM08_S125_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM08_S125.txt out=BOGR_DM08_S125_T_Q_A.fastq
bbduk.sh in=BOGR_DM09_S126_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM09_S126.txt out=BOGR_DM09_S126_T_Q_A.fastq
bbduk.sh in=BOGR_DM10_S127_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM10_S127.txt out=BOGR_DM10_S127_T_Q_A.fastq
bbduk.sh in=BOGR_DM11_S128_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM11_S128.txt out=BOGR_DM11_S128_T_Q_A.fastq
bbduk.sh in=BOGR_DM12_S129_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM12_S129.txt out=BOGR_DM12_S129_T_Q_A.fastq
bbduk.sh in=BOGR_DM13_S130_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM13_S130.txt out=BOGR_DM13_S130_T_Q_A.fastq
bbduk.sh in=BOGR_DM14_S131_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM14_S131.txt out=BOGR_DM14_S131_T_Q_A.fastq
bbduk.sh in=BOGR_DM15_S132_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM15_S132.txt out=BOGR_DM15_S132_T_Q_A.fastq
bbduk.sh in=BOGR_DM16_S133_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM16_S133.txt out=BOGR_DM16_S133_T_Q_A.fastq
bbduk.sh in=BOGR_DM17_S134_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM17_S134.txt out=BOGR_DM17_S134_T_Q_A.fastq
