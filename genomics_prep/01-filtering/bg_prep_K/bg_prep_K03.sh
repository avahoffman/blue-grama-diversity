#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_K3
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgK3.%j.out
#SBATCH --output=out_bgK3.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=4


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

# TruncateFastq.pl -i BOGR_K01_S18_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K01_S18_T.fastq
# TruncateFastq.pl -i BOGR_K02_S19_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K02_S19_T.fastq
TruncateFastq.pl -i BOGR_K03_S20_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K03_S20_T.fastq
# TruncateFastq.pl -i BOGR_K04_S21_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K04_S21_T.fastq
# TruncateFastq.pl -i BOGR_K05_S22_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K05_S22_T.fastq
# TruncateFastq.pl -i BOGR_K06_S23_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K06_S23_T.fastq
# TruncateFastq.pl -i BOGR_K07_S24_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K07_S24_T.fastq
# TruncateFastq.pl -i BOGR_K08_S25_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K08_S25_T.fastq
# TruncateFastq.pl -i BOGR_K09_S26_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K09_S26_T.fastq
# TruncateFastq.pl -i BOGR_K10_S27_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K10_S27_T.fastq
# TruncateFastq.pl -i BOGR_K11_S28_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K11_S28_T.fastq
# TruncateFastq.pl -i BOGR_K12_S29_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K12_S29_T.fastq
# TruncateFastq.pl -i BOGR_K13_S30_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K13_S30_T.fastq
# TruncateFastq.pl -i BOGR_K14_S31_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K14_S31_T.fastq
# TruncateFastq.pl -i BOGR_K15_S32_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K15_S32_T.fastq
# TruncateFastq.pl -i BOGR_K16_S33_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K16_S33_T.fastq
# TruncateFastq.pl -i BOGR_K17_S34_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K17_S34_T.fastq
# QualFilterFastq.pl -i BOGR_K01_S18_T.fastq -m 20 -x 4 -o BOGR_K01_S18_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K02_S19_T.fastq -m 20 -x 4 -o BOGR_K02_S19_T_Q.fastq
QualFilterFastq.pl -i BOGR_K03_S20_T.fastq -m 20 -x 4 -o BOGR_K03_S20_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K04_S21_T.fastq -m 20 -x 4 -o BOGR_K04_S21_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K05_S22_T.fastq -m 20 -x 4 -o BOGR_K05_S22_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K06_S23_T.fastq -m 20 -x 4 -o BOGR_K06_S23_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K07_S24_T.fastq -m 20 -x 4 -o BOGR_K07_S24_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K08_S25_T.fastq -m 20 -x 4 -o BOGR_K08_S25_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K09_S26_T.fastq -m 20 -x 4 -o BOGR_K09_S26_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K10_S27_T.fastq -m 20 -x 4 -o BOGR_K10_S27_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K11_S28_T.fastq -m 20 -x 4 -o BOGR_K11_S28_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K12_S29_T.fastq -m 20 -x 4 -o BOGR_K12_S29_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K13_S30_T.fastq -m 20 -x 4 -o BOGR_K13_S30_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K14_S31_T.fastq -m 20 -x 4 -o BOGR_K14_S31_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K15_S32_T.fastq -m 20 -x 4 -o BOGR_K15_S32_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K16_S33_T.fastq -m 20 -x 4 -o BOGR_K16_S33_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K17_S34_T.fastq -m 20 -x 4 -o BOGR_K17_S34_T_Q.fastq
# bbduk.sh in=BOGR_K01_S18_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K01_S18.txt out=BOGR_K01_S18_T_Q_A.fastq
# bbduk.sh in=BOGR_K02_S19_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K02_S19.txt out=BOGR_K02_S19_T_Q_A.fastq
bbduk.sh in=BOGR_K03_S20_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K03_S20.txt out=BOGR_K03_S20_T_Q_A.fastq
# bbduk.sh in=BOGR_K04_S21_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K04_S21.txt out=BOGR_K04_S21_T_Q_A.fastq
# bbduk.sh in=BOGR_K05_S22_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K05_S22.txt out=BOGR_K05_S22_T_Q_A.fastq
# bbduk.sh in=BOGR_K06_S23_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K06_S23.txt out=BOGR_K06_S23_T_Q_A.fastq
# bbduk.sh in=BOGR_K07_S24_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K07_S24.txt out=BOGR_K07_S24_T_Q_A.fastq
# bbduk.sh in=BOGR_K08_S25_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K08_S25.txt out=BOGR_K08_S25_T_Q_A.fastq
# bbduk.sh in=BOGR_K09_S26_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K09_S26.txt out=BOGR_K09_S26_T_Q_A.fastq
# bbduk.sh in=BOGR_K10_S27_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K10_S27.txt out=BOGR_K10_S27_T_Q_A.fastq
# bbduk.sh in=BOGR_K11_S28_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K11_S28.txt out=BOGR_K11_S28_T_Q_A.fastq
# bbduk.sh in=BOGR_K12_S29_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K12_S29.txt out=BOGR_K12_S29_T_Q_A.fastq
# bbduk.sh in=BOGR_K13_S30_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K13_S30.txt out=BOGR_K13_S30_T_Q_A.fastq
# bbduk.sh in=BOGR_K14_S31_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K14_S31.txt out=BOGR_K14_S31_T_Q_A.fastq
# bbduk.sh in=BOGR_K15_S32_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K15_S32.txt out=BOGR_K15_S32_T_Q_A.fastq
# bbduk.sh in=BOGR_K16_S33_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K16_S33.txt out=BOGR_K16_S33_T_Q_A.fastq
# bbduk.sh in=BOGR_K17_S34_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K17_S34.txt out=BOGR_K17_S34_T_Q_A.fastq
