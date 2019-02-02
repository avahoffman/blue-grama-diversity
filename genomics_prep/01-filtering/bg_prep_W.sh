#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_W
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgW.%j.out
#SBATCH --output=out_bgW.%j.out
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

TruncateFastq.pl -i BOGR_W01_S52_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W01_S52_T.fastq
TruncateFastq.pl -i BOGR_W02_S53_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W02_S53_T.fastq
TruncateFastq.pl -i BOGR_W03_S54_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W03_S54_T.fastq
TruncateFastq.pl -i BOGR_W04_S55_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W04_S55_T.fastq
TruncateFastq.pl -i BOGR_W05_S56_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W05_S56_T.fastq
TruncateFastq.pl -i BOGR_W06_S57_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W06_S57_T.fastq
TruncateFastq.pl -i BOGR_W07_S58_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W07_S58_T.fastq
TruncateFastq.pl -i BOGR_W08_S59_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W08_S59_T.fastq
TruncateFastq.pl -i BOGR_W09_S60_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W09_S60_T.fastq
TruncateFastq.pl -i BOGR_W10_S61_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W10_S61_T.fastq
TruncateFastq.pl -i BOGR_W11_S62_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W11_S62_T.fastq
TruncateFastq.pl -i BOGR_W12_S63_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W12_S63_T.fastq
TruncateFastq.pl -i BOGR_W13_S64_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W13_S64_T.fastq
TruncateFastq.pl -i BOGR_W14_S65_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W14_S65_T.fastq
TruncateFastq.pl -i BOGR_W15_S66_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W15_S66_T.fastq
TruncateFastq.pl -i BOGR_W16_S67_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W16_S67_T.fastq
QualFilterFastq.pl -i BOGR_W01_S52_T.fastq -m 20 -x 4 -o BOGR_W01_S52_T_Q.fastq
QualFilterFastq.pl -i BOGR_W02_S53_T.fastq -m 20 -x 4 -o BOGR_W02_S53_T_Q.fastq
QualFilterFastq.pl -i BOGR_W03_S54_T.fastq -m 20 -x 4 -o BOGR_W03_S54_T_Q.fastq
QualFilterFastq.pl -i BOGR_W04_S55_T.fastq -m 20 -x 4 -o BOGR_W04_S55_T_Q.fastq
QualFilterFastq.pl -i BOGR_W05_S56_T.fastq -m 20 -x 4 -o BOGR_W05_S56_T_Q.fastq
QualFilterFastq.pl -i BOGR_W06_S57_T.fastq -m 20 -x 4 -o BOGR_W06_S57_T_Q.fastq
QualFilterFastq.pl -i BOGR_W07_S58_T.fastq -m 20 -x 4 -o BOGR_W07_S58_T_Q.fastq
QualFilterFastq.pl -i BOGR_W08_S59_T.fastq -m 20 -x 4 -o BOGR_W08_S59_T_Q.fastq
QualFilterFastq.pl -i BOGR_W09_S60_T.fastq -m 20 -x 4 -o BOGR_W09_S60_T_Q.fastq
QualFilterFastq.pl -i BOGR_W10_S61_T.fastq -m 20 -x 4 -o BOGR_W10_S61_T_Q.fastq
QualFilterFastq.pl -i BOGR_W11_S62_T.fastq -m 20 -x 4 -o BOGR_W11_S62_T_Q.fastq
QualFilterFastq.pl -i BOGR_W12_S63_T.fastq -m 20 -x 4 -o BOGR_W12_S63_T_Q.fastq
QualFilterFastq.pl -i BOGR_W13_S64_T.fastq -m 20 -x 4 -o BOGR_W13_S64_T_Q.fastq
QualFilterFastq.pl -i BOGR_W14_S65_T.fastq -m 20 -x 4 -o BOGR_W14_S65_T_Q.fastq
QualFilterFastq.pl -i BOGR_W15_S66_T.fastq -m 20 -x 4 -o BOGR_W15_S66_T_Q.fastq
QualFilterFastq.pl -i BOGR_W16_S67_T.fastq -m 20 -x 4 -o BOGR_W16_S67_T_Q.fastq
bbduk.sh in=BOGR_W01_S52_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W01_S52.txt out=BOGR_W01_S52_T_Q_A.fastq
bbduk.sh in=BOGR_W02_S53_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W02_S53.txt out=BOGR_W02_S53_T_Q_A.fastq
bbduk.sh in=BOGR_W03_S54_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W03_S54.txt out=BOGR_W03_S54_T_Q_A.fastq
bbduk.sh in=BOGR_W04_S55_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W04_S55.txt out=BOGR_W04_S55_T_Q_A.fastq
bbduk.sh in=BOGR_W05_S56_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W05_S56.txt out=BOGR_W05_S56_T_Q_A.fastq
bbduk.sh in=BOGR_W06_S57_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W06_S57.txt out=BOGR_W06_S57_T_Q_A.fastq
bbduk.sh in=BOGR_W07_S58_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W07_S58.txt out=BOGR_W07_S58_T_Q_A.fastq
bbduk.sh in=BOGR_W08_S59_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W08_S59.txt out=BOGR_W08_S59_T_Q_A.fastq
bbduk.sh in=BOGR_W09_S60_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W09_S60.txt out=BOGR_W09_S60_T_Q_A.fastq
bbduk.sh in=BOGR_W10_S61_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W10_S61.txt out=BOGR_W10_S61_T_Q_A.fastq
bbduk.sh in=BOGR_W11_S62_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W11_S62.txt out=BOGR_W11_S62_T_Q_A.fastq
bbduk.sh in=BOGR_W12_S63_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W12_S63.txt out=BOGR_W12_S63_T_Q_A.fastq
bbduk.sh in=BOGR_W13_S64_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W13_S64.txt out=BOGR_W13_S64_T_Q_A.fastq
bbduk.sh in=BOGR_W14_S65_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W14_S65.txt out=BOGR_W14_S65_T_Q_A.fastq
bbduk.sh in=BOGR_W15_S66_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W15_S66.txt out=BOGR_W15_S66_T_Q_A.fastq
bbduk.sh in=BOGR_W16_S67_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W16_S67.txt out=BOGR_W16_S67_T_Q_A.fastq
