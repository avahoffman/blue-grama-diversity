#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_CP
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgCP.%j.out
#SBATCH --output=out_bgCP.%j.out
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

TruncateFastq.pl -i BOGR_CP01_S271_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP01_S271_T.fastq
TruncateFastq.pl -i BOGR_CP02_S272_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP02_S272_T.fastq
TruncateFastq.pl -i BOGR_CP03_S273_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP03_S273_T.fastq
TruncateFastq.pl -i BOGR_CP04_S274_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP04_S274_T.fastq
TruncateFastq.pl -i BOGR_CP05_S275_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP05_S275_T.fastq
TruncateFastq.pl -i BOGR_CP06_S276_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP06_S276_T.fastq
TruncateFastq.pl -i BOGR_CP07_S277_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP07_S277_T.fastq
TruncateFastq.pl -i BOGR_CP08_S278_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP08_S278_T.fastq
TruncateFastq.pl -i BOGR_CP09_S279_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP09_S279_T.fastq
TruncateFastq.pl -i BOGR_CP10_S280_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP10_S280_T.fastq
TruncateFastq.pl -i BOGR_CP11_S281_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP11_S281_T.fastq
TruncateFastq.pl -i BOGR_CP12_S282_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP12_S282_T.fastq
TruncateFastq.pl -i BOGR_CP13_S283_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP13_S283_T.fastq
TruncateFastq.pl -i BOGR_CP14_S284_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP14_S284_T.fastq
TruncateFastq.pl -i BOGR_CP15_S285_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP15_S285_T.fastq
TruncateFastq.pl -i BOGR_CP16_S286_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP16_S286_T.fastq
TruncateFastq.pl -i BOGR_CP17_S287_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP17_S287_T.fastq
QualFilterFastq.pl -i BOGR_CP01_S271_T.fastq -m 20 -x 4 -o BOGR_CP01_S271_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP02_S272_T.fastq -m 20 -x 4 -o BOGR_CP02_S272_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP03_S273_T.fastq -m 20 -x 4 -o BOGR_CP03_S273_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP04_S274_T.fastq -m 20 -x 4 -o BOGR_CP04_S274_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP05_S275_T.fastq -m 20 -x 4 -o BOGR_CP05_S275_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP06_S276_T.fastq -m 20 -x 4 -o BOGR_CP06_S276_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP07_S277_T.fastq -m 20 -x 4 -o BOGR_CP07_S277_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP08_S278_T.fastq -m 20 -x 4 -o BOGR_CP08_S278_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP09_S279_T.fastq -m 20 -x 4 -o BOGR_CP09_S279_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP10_S280_T.fastq -m 20 -x 4 -o BOGR_CP10_S280_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP11_S281_T.fastq -m 20 -x 4 -o BOGR_CP11_S281_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP12_S282_T.fastq -m 20 -x 4 -o BOGR_CP12_S282_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP13_S283_T.fastq -m 20 -x 4 -o BOGR_CP13_S283_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP14_S284_T.fastq -m 20 -x 4 -o BOGR_CP14_S284_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP15_S285_T.fastq -m 20 -x 4 -o BOGR_CP15_S285_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP16_S286_T.fastq -m 20 -x 4 -o BOGR_CP16_S286_T_Q.fastq
QualFilterFastq.pl -i BOGR_CP17_S287_T.fastq -m 20 -x 4 -o BOGR_CP17_S287_T_Q.fastq
bbduk.sh in=BOGR_CP01_S271_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP01_S271.txt out=BOGR_CP01_S271_T_Q_A.fastq
bbduk.sh in=BOGR_CP02_S272_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP02_S272.txt out=BOGR_CP02_S272_T_Q_A.fastq
bbduk.sh in=BOGR_CP03_S273_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP03_S273.txt out=BOGR_CP03_S273_T_Q_A.fastq
bbduk.sh in=BOGR_CP04_S274_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP04_S274.txt out=BOGR_CP04_S274_T_Q_A.fastq
bbduk.sh in=BOGR_CP05_S275_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP05_S275.txt out=BOGR_CP05_S275_T_Q_A.fastq
bbduk.sh in=BOGR_CP06_S276_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP06_S276.txt out=BOGR_CP06_S276_T_Q_A.fastq
bbduk.sh in=BOGR_CP07_S277_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP07_S277.txt out=BOGR_CP07_S277_T_Q_A.fastq
bbduk.sh in=BOGR_CP08_S278_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP08_S278.txt out=BOGR_CP08_S278_T_Q_A.fastq
bbduk.sh in=BOGR_CP09_S279_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP09_S279.txt out=BOGR_CP09_S279_T_Q_A.fastq
bbduk.sh in=BOGR_CP10_S280_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP10_S280.txt out=BOGR_CP10_S280_T_Q_A.fastq
bbduk.sh in=BOGR_CP11_S281_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP11_S281.txt out=BOGR_CP11_S281_T_Q_A.fastq
bbduk.sh in=BOGR_CP12_S282_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP12_S282.txt out=BOGR_CP12_S282_T_Q_A.fastq
bbduk.sh in=BOGR_CP13_S283_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP13_S283.txt out=BOGR_CP13_S283_T_Q_A.fastq
bbduk.sh in=BOGR_CP14_S284_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP14_S284.txt out=BOGR_CP14_S284_T_Q_A.fastq
bbduk.sh in=BOGR_CP15_S285_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP15_S285.txt out=BOGR_CP15_S285_T_Q_A.fastq
bbduk.sh in=BOGR_CP16_S286_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP16_S286.txt out=BOGR_CP16_S286_T_Q_A.fastq
bbduk.sh in=BOGR_CP17_S287_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP17_S287.txt out=BOGR_CP17_S287_T_Q_A.fastq
