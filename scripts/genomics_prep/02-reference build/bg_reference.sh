#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_ref
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_ref_big.%j.out
#SBATCH --output=out_ref_big.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=188


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
export PATH=$PATH:/projects/hoffmana@colostate.edu/cd-hit-v4.6.8-2017-1208
export PATH=$PATH:/projects/hoffmana@colostate.edu/standard-RAxML

#############
## Assemble reference
## take a representative subsample. 
## Here, using one high coverage sample per population.

# ExtractSites.pl -i /scratch/summit/hoffmana\@colostate.edu/rawdata/trinity_out_dir/Trinity.fasta -e AlfI -o Trinity_AlfIsites.fasta
## 187,084 Trinity extracted cut sites

## largest file
head -n 45662188 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_2_1-1112F_S477_L006_R1_001_T_Q_A.fastq >> combined_big.fastq
head -n 16644140 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_1_1-117H_S447_L006_R1_001_T_Q_A.fastq >> combined_big.fastq
head -n 25172732 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_3_1-114A_S416_L006_R1_001_T_Q_A.fastq >> combined_big.fastq
head -n 135826872 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K05_S22_T_Q_A.fastq >> combined_big.fastq
head -n 18949436 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RM17_S51_T_Q_A.fastq >> combined_big.fastq
head -n 21604132 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_W03_S54_T_Q_A.fastq >> combined_big.fastq
head -n 21364732 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_WR11_S11_T_Q_A.fastq >> combined_big.fastq
head -n 12846292 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_A10_S77_T_Q_A.fastq >> combined_big.fastq
head -n 14406052 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_DM12_S129_T_Q_A.fastq >> combined_big.fastq
head -n 14513200 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_HV16_S116_T_Q_A.fastq >> combined_big.fastq
head -n 14144160 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS13_S97_T_Q_A.fastq >> combined_big.fastq
head -n 13277396 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG03_S205_T_Q_A.fastq >> combined_big.fastq
head -n 13868652 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BT07_S175_T_Q_A.fastq >> combined_big.fastq
head -n 14249868 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO14_S199_T_Q_A.fastq >> combined_big.fastq
head -n 26352172 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC16_S150_T_Q_A.fastq >> combined_big.fastq
head -n 17311788 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST08_S159_T_Q_A.fastq >> combined_big.fastq
head -n 49500560 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CI09_S245_T_Q_A.fastq >> combined_big.fastq
head -n 14511796 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP17_S287_T_Q_A.fastq >> combined_big.fastq
head -n 19107996 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ14_S267_T_Q_A.fastq >> combined_big.fastq
head -n 8642960 ~/scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV15_S234_T_Q_A.fastq >> combined_big.fastq

## smallest file

#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgcultivar_na_1_1-1112E_S476_L006_R1_001_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/Bgedge_1_4_1-114B_S417_L006_R1_001_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BgHq_1_1_2-118A_S448_L006_R1_001_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_A04_S71_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BG14_S216_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_BT14_S182_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CI15_S251_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CO13_S198_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_CP15_S285_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_DM08_S125_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_HV15_S115_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_K11_S28_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_KNZ03_S256_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RC07_S141_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_RM04_S38_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SEV02_S221_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_SGS01_S85_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_ST11_S162_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_W11_S62_T_Q_A.fastq >> combined.fastq
#head -n 636956 /scratch/summit/hoffmana@colostate.edu/genomics/raw/BOGR_WR13_S13_T_Q_A.fastq >> combined.fastq


BuildRef.pl -i combined_big.fastq -o reference_samples.fasta
# cat reference_samples.fasta >> reference.fasta
# cat Trinity_AlfIsites.fasta >> reference.fasta 
