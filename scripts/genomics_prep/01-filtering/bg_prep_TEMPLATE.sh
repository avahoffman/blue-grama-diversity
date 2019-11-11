#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bg.%j.out
#SBATCH --output=out_bg.%j.out
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

# TruncateFastq.pl -i Bgcultivar_na_1_1-1112E_S476_L006_R1_001.fastq -s 1 -e 36 -o Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgcultivar_na_2_1-1112F_S477_L006_R1_001.fastq -s 1 -e 36 -o Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgcultivar_na_3_1-1112G_S478_L006_R1_001.fastq -s 1 -e 36 -o Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgcultivar_na_4_1-1112H_S479_L006_R1_001.fastq -s 1 -e 36 -o Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_1_1-113E_S412_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_1_1-113E_S412_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_1_2-113F_S413_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_1_2-113F_S413_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_1_3-113G_S414_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_1_3-113G_S414_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_2_1-113H_S415_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_2_1-113H_S415_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_3_1-114A_S416_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_3_1-114A_S416_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_4_1-114B_S417_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_4_1-114B_S417_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_1_5_1-114C_S418_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_1_5_1-114C_S418_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_1_1-117B_S441_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_1_1-117B_S441_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_2_1-117C_S442_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_2_1-117C_S442_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_3_1-117D_S443_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_3_1-117D_S443_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_4_1-117E_S444_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_4_1-117E_S444_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_5_1-117F_S445_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_5_1-117F_S445_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_10_6_1-117G_S446_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_10_6_1-117G_S446_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_2_1_1-114D_S419_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_2_1_1-114D_S419_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_2_2_1-114E_S420_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_2_2_1-114E_S420_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_2_3_1-114F_S421_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_2_3_1-114F_S421_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_2_4_1-114G_S422_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_2_4_1-114G_S422_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_1_1-114H_S423_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_1_1-114H_S423_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_2_1-115A_S424_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_2_1-115A_S424_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_3_1-115B_S425_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_3_1-115B_S425_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_4_1-115C_S426_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_4_1-115C_S426_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_5_1-115D_S427_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_5_1-115D_S427_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_4_6_1-115E_S428_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_4_6_1-115E_S428_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_8_1_1-115F_S429_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_8_1_1-115F_S429_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_8_2_1-115G_S430_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_8_2_1-115G_S430_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_8_3_1-115H_S431_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_8_3_1-115H_S431_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_8_4_1-116A_S432_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_8_4_1-116A_S432_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_8_5_1-116B_S433_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_8_5_1-116B_S433_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_1_1-116C_S434_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_1_1-116C_S434_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_1_2-116D_S435_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_1_2-116D_S435_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_1_3-116E_S436_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_1_3-116E_S436_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_2_1-116F_S437_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_2_1-116F_S437_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_3_1-116G_S438_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_3_1-116G_S438_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_4_1-116H_S439_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_4_1-116H_S439_L006_R1_001_T.fastq
# TruncateFastq.pl -i Bgedge_9_5_1-117A_S440_L006_R1_001.fastq -s 1 -e 36 -o Bgedge_9_5_1-117A_S440_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_1_1-117H_S447_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_1_1-117H_S447_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_1_2-118A_S448_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_1_2-118A_S448_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_1_3-118B_S449_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_1_3-118B_S449_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_2_1-118C_S450_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_2_1-118C_S450_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_3_1-118D_S451_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_3_1-118D_S451_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_1_4_1-118E_S452_L006_R1_001.fastq -s 1 -e 36 -o BgHq_1_4_1-118E_S452_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_2_1_1-118F_S453_L006_R1_001.fastq -s 1 -e 36 -o BgHq_2_1_1-118F_S453_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_2_2_1-118G_S454_L006_R1_001.fastq -s 1 -e 36 -o BgHq_2_2_1-118G_S454_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_2_3_1-118H_S455_L006_R1_001.fastq -s 1 -e 36 -o BgHq_2_3_1-118H_S455_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_4_1_1-119A_S456_L006_R1_001.fastq -s 1 -e 36 -o BgHq_4_1_1-119A_S456_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_4_2_1-119B_S457_L006_R1_001.fastq -s 1 -e 36 -o BgHq_4_2_1-119B_S457_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_4_3_1-119C_S458_L006_R1_001.fastq -s 1 -e 36 -o BgHq_4_3_1-119C_S458_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_6_1_1-119D_S459_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_1_1-119D_S459_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_6_2_1-119E_S460_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_2_1-119E_S460_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_6_3_1-119F_S461_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_3_1-119F_S461_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_6_4_1-119G_S462_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_4_1-119G_S462_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_6_5_1-119H_S463_L006_R1_001.fastq -s 1 -e 36 -o BgHq_6_5_1-119H_S463_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_7_1_1-1110A_S464_L006_R1_001.fastq -s 1 -e 36 -o BgHq_7_1_1-1110A_S464_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_7_2_1-1110B_S465_L006_R1_001.fastq -s 1 -e 36 -o BgHq_7_2_1-1110B_S465_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_7_3_1-1110C_S466_L006_R1_001.fastq -s 1 -e 36 -o BgHq_7_3_1-1110C_S466_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_1_1-1110D_S467_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_1_1-1110D_S467_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_2_1-1110E_S468_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_2_1-1110E_S468_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_2_2-1110F_S469_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_2_2-1110F_S469_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_2_3-1110G_S470_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_2_3-1110G_S470_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_3_1-1110H_S471_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_3_1-1110H_S471_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_4_1-1111B_S472_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_4_1-1111B_S472_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_5_1-1111B_S473_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_5_1-1111B_S473_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_6_1-1111C_S474_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_6_1-1111C_S474_L006_R1_001_T.fastq
# TruncateFastq.pl -i BgHq_9_7_1-1111D_S475_L006_R1_001.fastq -s 1 -e 36 -o BgHq_9_7_1-1111D_S475_L006_R1_001_T.fastq

#QualFilterFastq.pl -i Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T.fastq -m 20 -x 4 -o Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T.fastq -m 20 -x 4 -o Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T.fastq -m 20 -x 4 -o Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T.fastq -m 20 -x 4 -o Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_1_1-113E_S412_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_1_1-113E_S412_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_1_2-113F_S413_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_1_2-113F_S413_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_1_3-113G_S414_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_1_3-113G_S414_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_2_1-113H_S415_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_2_1-113H_S415_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_3_1-114A_S416_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_3_1-114A_S416_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_4_1-114B_S417_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_4_1-114B_S417_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_1_5_1-114C_S418_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_1_5_1-114C_S418_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_1_1-117B_S441_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_1_1-117B_S441_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_2_1-117C_S442_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_2_1-117C_S442_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_3_1-117D_S443_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_3_1-117D_S443_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_4_1-117E_S444_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_4_1-117E_S444_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_5_1-117F_S445_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_5_1-117F_S445_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_10_6_1-117G_S446_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_10_6_1-117G_S446_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_2_1_1-114D_S419_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_2_1_1-114D_S419_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_2_2_1-114E_S420_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_2_2_1-114E_S420_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_2_3_1-114F_S421_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_2_3_1-114F_S421_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_2_4_1-114G_S422_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_2_4_1-114G_S422_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_1_1-114H_S423_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_1_1-114H_S423_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_2_1-115A_S424_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_2_1-115A_S424_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_3_1-115B_S425_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_3_1-115B_S425_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_4_1-115C_S426_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_4_1-115C_S426_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_5_1-115D_S427_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_5_1-115D_S427_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_4_6_1-115E_S428_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_4_6_1-115E_S428_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_8_1_1-115F_S429_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_8_1_1-115F_S429_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_8_2_1-115G_S430_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_8_2_1-115G_S430_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_8_3_1-115H_S431_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_8_3_1-115H_S431_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_8_4_1-116A_S432_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_8_4_1-116A_S432_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_8_5_1-116B_S433_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_8_5_1-116B_S433_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_1_1-116C_S434_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_1_1-116C_S434_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_1_2-116D_S435_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_1_2-116D_S435_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_1_3-116E_S436_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_1_3-116E_S436_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_2_1-116F_S437_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_2_1-116F_S437_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_3_1-116G_S438_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_3_1-116G_S438_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_4_1-116H_S439_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_4_1-116H_S439_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i Bgedge_9_5_1-117A_S440_L006_R1_001_T.fastq -m 20 -x 4 -o Bgedge_9_5_1-117A_S440_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_1_1-117H_S447_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_1_1-117H_S447_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_1_2-118A_S448_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_1_2-118A_S448_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_1_3-118B_S449_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_1_3-118B_S449_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_2_1-118C_S450_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_2_1-118C_S450_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_3_1-118D_S451_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_3_1-118D_S451_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_1_4_1-118E_S452_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_1_4_1-118E_S452_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_2_1_1-118F_S453_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_2_1_1-118F_S453_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_2_2_1-118G_S454_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_2_2_1-118G_S454_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_2_3_1-118H_S455_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_2_3_1-118H_S455_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_4_1_1-119A_S456_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_4_1_1-119A_S456_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_4_2_1-119B_S457_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_4_2_1-119B_S457_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_4_3_1-119C_S458_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_4_3_1-119C_S458_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_6_1_1-119D_S459_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_1_1-119D_S459_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_6_2_1-119E_S460_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_2_1-119E_S460_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_6_3_1-119F_S461_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_3_1-119F_S461_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_6_4_1-119G_S462_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_4_1-119G_S462_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_6_5_1-119H_S463_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_6_5_1-119H_S463_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_7_1_1-1110A_S464_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_7_1_1-1110A_S464_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_7_2_1-1110B_S465_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_7_2_1-1110B_S465_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_7_3_1-1110C_S466_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_7_3_1-1110C_S466_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_1_1-1110D_S467_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_1_1-1110D_S467_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_2_1-1110E_S468_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_2_1-1110E_S468_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_2_2-1110F_S469_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_2_2-1110F_S469_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_2_3-1110G_S470_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_2_3-1110G_S470_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_3_1-1110H_S471_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_3_1-1110H_S471_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_4_1-1111B_S472_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_4_1-1111B_S472_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_5_1-1111B_S473_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_5_1-1111B_S473_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_6_1-1111C_S474_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_6_1-1111C_S474_L006_R1_001_T_Q.fastq
#QualFilterFastq.pl -i BgHq_9_7_1-1111D_S475_L006_R1_001_T.fastq -m 20 -x 4 -o BgHq_9_7_1-1111D_S475_L006_R1_001_T_Q.fastq

# bbduk.sh in=Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats01.txt out=Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats02.txt out=Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats03.txt out=Bgcultivar_na_3_1-1112G_S478_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats04.txt out=Bgcultivar_na_4_1-1112H_S479_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_1_1-113E_S412_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats05.txt out=Bgedge_1_1_1-113E_S412_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_1_2-113F_S413_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats06.txt out=Bgedge_1_1_2-113F_S413_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_1_3-113G_S414_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats07.txt out=Bgedge_1_1_3-113G_S414_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_2_1-113H_S415_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats08.txt out=Bgedge_1_2_1-113H_S415_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_3_1-114A_S416_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats09.txt out=Bgedge_1_3_1-114A_S416_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_4_1-114B_S417_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats10.txt out=Bgedge_1_4_1-114B_S417_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_1_5_1-114C_S418_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats11.txt out=Bgedge_1_5_1-114C_S418_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_1_1-117B_S441_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats12.txt out=Bgedge_10_1_1-117B_S441_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_2_1-117C_S442_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats13.txt out=Bgedge_10_2_1-117C_S442_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_3_1-117D_S443_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats14.txt out=Bgedge_10_3_1-117D_S443_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_4_1-117E_S444_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats15.txt out=Bgedge_10_4_1-117E_S444_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_5_1-117F_S445_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats16.txt out=Bgedge_10_5_1-117F_S445_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_10_6_1-117G_S446_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats17.txt out=Bgedge_10_6_1-117G_S446_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_2_1_1-114D_S419_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats18.txt out=Bgedge_2_1_1-114D_S419_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_2_2_1-114E_S420_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats19.txt out=Bgedge_2_2_1-114E_S420_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_2_3_1-114F_S421_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats20.txt out=Bgedge_2_3_1-114F_S421_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_2_4_1-114G_S422_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats21.txt out=Bgedge_2_4_1-114G_S422_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_1_1-114H_S423_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats22.txt out=Bgedge_4_1_1-114H_S423_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_2_1-115A_S424_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats23.txt out=Bgedge_4_2_1-115A_S424_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_3_1-115B_S425_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats24.txt out=Bgedge_4_3_1-115B_S425_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_4_1-115C_S426_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats25.txt out=Bgedge_4_4_1-115C_S426_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_5_1-115D_S427_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats26.txt out=Bgedge_4_5_1-115D_S427_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_4_6_1-115E_S428_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats27.txt out=Bgedge_4_6_1-115E_S428_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_8_1_1-115F_S429_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats28.txt out=Bgedge_8_1_1-115F_S429_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_8_2_1-115G_S430_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats29.txt out=Bgedge_8_2_1-115G_S430_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_8_3_1-115H_S431_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats30.txt out=Bgedge_8_3_1-115H_S431_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_8_4_1-116A_S432_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats31.txt out=Bgedge_8_4_1-116A_S432_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_8_5_1-116B_S433_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats32.txt out=Bgedge_8_5_1-116B_S433_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_1_1-116C_S434_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats33.txt out=Bgedge_9_1_1-116C_S434_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_1_2-116D_S435_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats34.txt out=Bgedge_9_1_2-116D_S435_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_1_3-116E_S436_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats35.txt out=Bgedge_9_1_3-116E_S436_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_2_1-116F_S437_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats36.txt out=Bgedge_9_2_1-116F_S437_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_3_1-116G_S438_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats37.txt out=Bgedge_9_3_1-116G_S438_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_4_1-116H_S439_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats38.txt out=Bgedge_9_4_1-116H_S439_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=Bgedge_9_5_1-117A_S440_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats39.txt out=Bgedge_9_5_1-117A_S440_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_1_1-117H_S447_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats40.txt out=BgHq_1_1_1-117H_S447_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_1_2-118A_S448_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats41.txt out=BgHq_1_1_2-118A_S448_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_1_3-118B_S449_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats42.txt out=BgHq_1_1_3-118B_S449_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_2_1-118C_S450_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats43.txt out=BgHq_1_2_1-118C_S450_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_3_1-118D_S451_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats44.txt out=BgHq_1_3_1-118D_S451_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_1_4_1-118E_S452_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats45.txt out=BgHq_1_4_1-118E_S452_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_2_1_1-118F_S453_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats46.txt out=BgHq_2_1_1-118F_S453_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_2_2_1-118G_S454_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats47.txt out=BgHq_2_2_1-118G_S454_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_2_3_1-118H_S455_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats48.txt out=BgHq_2_3_1-118H_S455_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_4_1_1-119A_S456_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats49.txt out=BgHq_4_1_1-119A_S456_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_4_2_1-119B_S457_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats50.txt out=BgHq_4_2_1-119B_S457_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_4_3_1-119C_S458_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats51.txt out=BgHq_4_3_1-119C_S458_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_6_1_1-119D_S459_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats52.txt out=BgHq_6_1_1-119D_S459_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_6_2_1-119E_S460_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats53.txt out=BgHq_6_2_1-119E_S460_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_6_3_1-119F_S461_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats54.txt out=BgHq_6_3_1-119F_S461_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_6_4_1-119G_S462_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats55.txt out=BgHq_6_4_1-119G_S462_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_6_5_1-119H_S463_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats56.txt out=BgHq_6_5_1-119H_S463_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_7_1_1-1110A_S464_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats57.txt out=BgHq_7_1_1-1110A_S464_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_7_2_1-1110B_S465_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats58.txt out=BgHq_7_2_1-1110B_S465_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_7_3_1-1110C_S466_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats59.txt out=BgHq_7_3_1-1110C_S466_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_1_1-1110D_S467_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats60.txt out=BgHq_9_1_1-1110D_S467_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_2_1-1110E_S468_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats61.txt out=BgHq_9_2_1-1110E_S468_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_2_2-1110F_S469_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats62.txt out=BgHq_9_2_2-1110F_S469_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_2_3-1110G_S470_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats63.txt out=BgHq_9_2_3-1110G_S470_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_3_1-1110H_S471_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats64.txt out=BgHq_9_3_1-1110H_S471_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_4_1-1111B_S472_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats65.txt out=BgHq_9_4_1-1111B_S472_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_5_1-1111B_S473_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats66.txt out=BgHq_9_5_1-1111B_S473_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_6_1-1111C_S474_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats67.txt out=BgHq_9_6_1-1111C_S474_L006_R1_001_T_Q_A.fastq
# bbduk.sh in=BgHq_9_7_1-1111D_S475_L006_R1_001_T_Q.fastq ref=~/scratch_dir/KC2/adaptors.fasta k=12 stats=stats68.txt out=BgHq_9_7_1-1111D_S475_L006_R1_001_T_Q_A.fastq
