#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_BT
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgBT.%j.out
#SBATCH --output=out_bgBT.%j.out
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

TruncateFastq.pl -i BOGR_BT01_S169_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT01_S169_T.fastq
TruncateFastq.pl -i BOGR_BT02_S170_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT02_S170_T.fastq
TruncateFastq.pl -i BOGR_BT03_S171_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT03_S171_T.fastq
TruncateFastq.pl -i BOGR_BT04_S172_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT04_S172_T.fastq
TruncateFastq.pl -i BOGR_BT05_S173_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT05_S173_T.fastq
TruncateFastq.pl -i BOGR_BT06_S174_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT06_S174_T.fastq
TruncateFastq.pl -i BOGR_BT07_S175_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT07_S175_T.fastq
TruncateFastq.pl -i BOGR_BT08_S176_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT08_S176_T.fastq
TruncateFastq.pl -i BOGR_BT09_S177_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT09_S177_T.fastq
TruncateFastq.pl -i BOGR_BT10_S178_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT10_S178_T.fastq
TruncateFastq.pl -i BOGR_BT11_S179_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT11_S179_T.fastq
TruncateFastq.pl -i BOGR_BT12_S180_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT12_S180_T.fastq
TruncateFastq.pl -i BOGR_BT13_S181_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT13_S181_T.fastq
TruncateFastq.pl -i BOGR_BT14_S182_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT14_S182_T.fastq
TruncateFastq.pl -i BOGR_BT15_S183_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT15_S183_T.fastq
TruncateFastq.pl -i BOGR_BT16_S184_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT16_S184_T.fastq
TruncateFastq.pl -i BOGR_BT17_S185_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT17_S185_T.fastq
QualFilterFastq.pl -i BOGR_BT01_S169_T.fastq -m 20 -x 4 -o BOGR_BT01_S169_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT02_S170_T.fastq -m 20 -x 4 -o BOGR_BT02_S170_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT03_S171_T.fastq -m 20 -x 4 -o BOGR_BT03_S171_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT04_S172_T.fastq -m 20 -x 4 -o BOGR_BT04_S172_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT05_S173_T.fastq -m 20 -x 4 -o BOGR_BT05_S173_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT06_S174_T.fastq -m 20 -x 4 -o BOGR_BT06_S174_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT07_S175_T.fastq -m 20 -x 4 -o BOGR_BT07_S175_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT08_S176_T.fastq -m 20 -x 4 -o BOGR_BT08_S176_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT09_S177_T.fastq -m 20 -x 4 -o BOGR_BT09_S177_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT10_S178_T.fastq -m 20 -x 4 -o BOGR_BT10_S178_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT11_S179_T.fastq -m 20 -x 4 -o BOGR_BT11_S179_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT12_S180_T.fastq -m 20 -x 4 -o BOGR_BT12_S180_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT13_S181_T.fastq -m 20 -x 4 -o BOGR_BT13_S181_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT14_S182_T.fastq -m 20 -x 4 -o BOGR_BT14_S182_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT15_S183_T.fastq -m 20 -x 4 -o BOGR_BT15_S183_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT16_S184_T.fastq -m 20 -x 4 -o BOGR_BT16_S184_T_Q.fastq
QualFilterFastq.pl -i BOGR_BT17_S185_T.fastq -m 20 -x 4 -o BOGR_BT17_S185_T_Q.fastq
bbduk.sh in=BOGR_BT01_S169_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT01_S169.txt out=BOGR_BT01_S169_T_Q_A.fastq
bbduk.sh in=BOGR_BT02_S170_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT02_S170.txt out=BOGR_BT02_S170_T_Q_A.fastq
bbduk.sh in=BOGR_BT03_S171_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT03_S171.txt out=BOGR_BT03_S171_T_Q_A.fastq
bbduk.sh in=BOGR_BT04_S172_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT04_S172.txt out=BOGR_BT04_S172_T_Q_A.fastq
bbduk.sh in=BOGR_BT05_S173_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT05_S173.txt out=BOGR_BT05_S173_T_Q_A.fastq
bbduk.sh in=BOGR_BT06_S174_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT06_S174.txt out=BOGR_BT06_S174_T_Q_A.fastq
bbduk.sh in=BOGR_BT07_S175_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT07_S175.txt out=BOGR_BT07_S175_T_Q_A.fastq
bbduk.sh in=BOGR_BT08_S176_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT08_S176.txt out=BOGR_BT08_S176_T_Q_A.fastq
bbduk.sh in=BOGR_BT09_S177_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT09_S177.txt out=BOGR_BT09_S177_T_Q_A.fastq
bbduk.sh in=BOGR_BT10_S178_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT10_S178.txt out=BOGR_BT10_S178_T_Q_A.fastq
bbduk.sh in=BOGR_BT11_S179_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT11_S179.txt out=BOGR_BT11_S179_T_Q_A.fastq
bbduk.sh in=BOGR_BT12_S180_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT12_S180.txt out=BOGR_BT12_S180_T_Q_A.fastq
bbduk.sh in=BOGR_BT13_S181_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT13_S181.txt out=BOGR_BT13_S181_T_Q_A.fastq
bbduk.sh in=BOGR_BT14_S182_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT14_S182.txt out=BOGR_BT14_S182_T_Q_A.fastq
bbduk.sh in=BOGR_BT15_S183_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT15_S183.txt out=BOGR_BT15_S183_T_Q_A.fastq
bbduk.sh in=BOGR_BT16_S184_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT16_S184.txt out=BOGR_BT16_S184_T_Q_A.fastq
bbduk.sh in=BOGR_BT17_S185_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT17_S185.txt out=BOGR_BT17_S185_T_Q_A.fastq
