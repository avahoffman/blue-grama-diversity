#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_RC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bgRC.%j.out
#SBATCH --output=out_bgRC.%j.out
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

TruncateFastq.pl -i BOGR_RC01_S135_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC01_S135_T.fastq
TruncateFastq.pl -i BOGR_RC02_S136_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC02_S136_T.fastq
TruncateFastq.pl -i BOGR_RC03_S137_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC03_S137_T.fastq
TruncateFastq.pl -i BOGR_RC04_S138_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC04_S138_T.fastq
TruncateFastq.pl -i BOGR_RC05_S139_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC05_S139_T.fastq
TruncateFastq.pl -i BOGR_RC06_S140_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC06_S140_T.fastq
TruncateFastq.pl -i BOGR_RC07_S141_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC07_S141_T.fastq
TruncateFastq.pl -i BOGR_RC08_S142_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC08_S142_T.fastq
TruncateFastq.pl -i BOGR_RC09_S143_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC09_S143_T.fastq
TruncateFastq.pl -i BOGR_RC10_S144_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC10_S144_T.fastq
TruncateFastq.pl -i BOGR_RC11_S145_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC11_S145_T.fastq
TruncateFastq.pl -i BOGR_RC12_S146_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC12_S146_T.fastq
TruncateFastq.pl -i BOGR_RC13_S147_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC13_S147_T.fastq
TruncateFastq.pl -i BOGR_RC14_S148_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC14_S148_T.fastq
TruncateFastq.pl -i BOGR_RC15_S149_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC15_S149_T.fastq
TruncateFastq.pl -i BOGR_RC16_S150_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC16_S150_T.fastq
TruncateFastq.pl -i BOGR_RC17_S151_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC17_S151_T.fastq
QualFilterFastq.pl -i BOGR_RC01_S135_T.fastq -m 20 -x 4 -o BOGR_RC01_S135_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC02_S136_T.fastq -m 20 -x 4 -o BOGR_RC02_S136_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC03_S137_T.fastq -m 20 -x 4 -o BOGR_RC03_S137_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC04_S138_T.fastq -m 20 -x 4 -o BOGR_RC04_S138_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC05_S139_T.fastq -m 20 -x 4 -o BOGR_RC05_S139_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC06_S140_T.fastq -m 20 -x 4 -o BOGR_RC06_S140_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC07_S141_T.fastq -m 20 -x 4 -o BOGR_RC07_S141_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC08_S142_T.fastq -m 20 -x 4 -o BOGR_RC08_S142_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC09_S143_T.fastq -m 20 -x 4 -o BOGR_RC09_S143_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC10_S144_T.fastq -m 20 -x 4 -o BOGR_RC10_S144_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC11_S145_T.fastq -m 20 -x 4 -o BOGR_RC11_S145_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC12_S146_T.fastq -m 20 -x 4 -o BOGR_RC12_S146_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC13_S147_T.fastq -m 20 -x 4 -o BOGR_RC13_S147_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC14_S148_T.fastq -m 20 -x 4 -o BOGR_RC14_S148_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC15_S149_T.fastq -m 20 -x 4 -o BOGR_RC15_S149_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC16_S150_T.fastq -m 20 -x 4 -o BOGR_RC16_S150_T_Q.fastq
QualFilterFastq.pl -i BOGR_RC17_S151_T.fastq -m 20 -x 4 -o BOGR_RC17_S151_T_Q.fastq
bbduk.sh in=BOGR_RC01_S135_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC01_S135.txt out=BOGR_RC01_S135_T_Q_A.fastq
bbduk.sh in=BOGR_RC02_S136_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC02_S136.txt out=BOGR_RC02_S136_T_Q_A.fastq
bbduk.sh in=BOGR_RC03_S137_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC03_S137.txt out=BOGR_RC03_S137_T_Q_A.fastq
bbduk.sh in=BOGR_RC04_S138_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC04_S138.txt out=BOGR_RC04_S138_T_Q_A.fastq
bbduk.sh in=BOGR_RC05_S139_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC05_S139.txt out=BOGR_RC05_S139_T_Q_A.fastq
bbduk.sh in=BOGR_RC06_S140_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC06_S140.txt out=BOGR_RC06_S140_T_Q_A.fastq
bbduk.sh in=BOGR_RC07_S141_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC07_S141.txt out=BOGR_RC07_S141_T_Q_A.fastq
bbduk.sh in=BOGR_RC08_S142_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC08_S142.txt out=BOGR_RC08_S142_T_Q_A.fastq
bbduk.sh in=BOGR_RC09_S143_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC09_S143.txt out=BOGR_RC09_S143_T_Q_A.fastq
bbduk.sh in=BOGR_RC10_S144_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC10_S144.txt out=BOGR_RC10_S144_T_Q_A.fastq
bbduk.sh in=BOGR_RC11_S145_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC11_S145.txt out=BOGR_RC11_S145_T_Q_A.fastq
bbduk.sh in=BOGR_RC12_S146_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC12_S146.txt out=BOGR_RC12_S146_T_Q_A.fastq
bbduk.sh in=BOGR_RC13_S147_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC13_S147.txt out=BOGR_RC13_S147_T_Q_A.fastq
bbduk.sh in=BOGR_RC14_S148_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC14_S148.txt out=BOGR_RC14_S148_T_Q_A.fastq
bbduk.sh in=BOGR_RC15_S149_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC15_S149.txt out=BOGR_RC15_S149_T_Q_A.fastq
bbduk.sh in=BOGR_RC16_S150_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC16_S150.txt out=BOGR_RC16_S150_T_Q_A.fastq
bbduk.sh in=BOGR_RC17_S151_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC17_S151.txt out=BOGR_RC17_S151_T_Q_A.fastq
